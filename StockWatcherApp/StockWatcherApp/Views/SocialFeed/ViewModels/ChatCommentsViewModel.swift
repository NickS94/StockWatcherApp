//
//  ChatCommentsViewModel.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 25.09.24.
//

import Foundation
import FirebaseAuth
@MainActor
class ChatCommentsViewModel:ObservableObject{
    
    //MARK: - Properties
    
    private let firebaseClient = FirebaseRepository.shared
    
    @Published var chatComments:[ChatComment] = []
    @Published var commentContent = ""
    @Published var commentInteractions:[LikeOrDislikeAComment] = []
    @Published var fireuser:FirestoreUser?
    @Published var fireusers:[FirestoreUser] = []
    
    var user:User?{
        return firebaseClient.checkAuth()
    }
    //MARK: - Methods
    
    
    func fetchComments(chatId:String){
        Task{
            do{
                let results = try await firebaseClient.fetchChatComments(with:chatId)
                
                chatComments = results
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func createNewComment(chat:SocialChat){
        do{
            if let authUser = user{
                try firebaseClient.createChatComment(fireuser: fireuser ?? FirestoreUser(id: authUser.uid, username: authUser.displayName ?? "NoName", userEmail: authUser.email ?? "NoEmail", userProfileIcon: authUser.photoURL?.absoluteString ?? ""), user: authUser, chat: chat, content: commentContent)
            }
            fetchFireUser()
            fetchComments(chatId: chat.id)
            
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func fetchFireUser(){
        Task{
            do{
                let result = try await firebaseClient.getFirestoreUser()
                
                fireuser = result
            }catch{
                print(error)
            }
        }
    }
    
    func fetchFireUsers(){
        Task{
            do{
                let results = try await firebaseClient.fetchFirestoreUsers()
                fireusers = results
            }catch{
                print(error)
            }
        }
    }
    
    func getFireUserProfileIcon(chatComment: ChatComment) -> String {
        for fireUser in fireusers {
            if fireUser.id == chatComment.userId {
                return fireUser.userProfileIcon
            }
        }
        return "person"
    }
    
    func commentInteractionCheck(commentId:String) -> [LikeOrDislikeAComment]{
        return commentInteractions.filter { interaction in
            interaction.commentId == commentId
        }
    }
    
    func likeOrDislikeAComment(commentId:String,isLiked:Bool,isDisliked:Bool) async {
        guard let user else{return}
        
        do{
            try firebaseClient.likeOrDislikeAcomment(user: user, commentId: commentId, isLiked: isLiked, isDisliked: isDisliked)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func fetchCommentInteractions() async {
        do{
            guard let user else{return}
            
            let results = try await firebaseClient.fetchCommentInteraction(from: user.uid)
            commentInteractions = results
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func deleteCommentInteraction(commentInteractioId:String) async {
        do{
            try await firebaseClient.deleteCommentInteraction(with: commentInteractioId)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func updateCommentLikes(commentId:String,likeCount:Int)async{
        do{
            try await firebaseClient.updateCommentLikes(commentId: commentId, likeCount: likeCount)
            await fetchCommentInteractions()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func updateCommentDislikes(commentId:String,dislikeCount:Int) async {
        do{
            try await firebaseClient.updateCommentDislikes(commentId: commentId, dislikeCount: dislikeCount)
            await fetchCommentInteractions()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func onCommentLikeClicked(chatComment:ChatComment,chatId:String) async {
        let interactions = commentInteractionCheck(commentId: chatComment.id)
        
        if !interactions.isEmpty , interactions[0].isLiked{
            await updateCommentLikes(commentId: chatComment.id, likeCount: chatComment.likes - 1)
            await deleteCommentInteraction(commentInteractioId: interactions[0].id)
        }else if !interactions.isEmpty,interactions[0].isDisliked{
            await updateCommentDislikes(commentId: chatComment.id, dislikeCount: chatComment.dislikes - 1)
            await deleteCommentInteraction(commentInteractioId: interactions[0].id)
            await likeOrDislikeAComment(commentId: chatComment.id, isLiked: true, isDisliked: false)
            await updateCommentLikes(commentId: chatComment.id, likeCount: chatComment.likes + 1)
        }else{
            await updateCommentLikes(commentId: chatComment.id, likeCount: chatComment.likes + 1)
            await likeOrDislikeAComment(commentId: chatComment.id, isLiked: true, isDisliked: false)
        }
        await fetchCommentInteractions()
        fetchComments(chatId: chatId)
    }
    
    
    func onCommentDislikeClicked(chatComment:ChatComment,chatId:String) async {
        let interactions = commentInteractionCheck(commentId: chatComment.id)
        
        if !interactions.isEmpty,interactions[0].isDisliked{
            await updateCommentDislikes(commentId: chatComment.id, dislikeCount: chatComment.dislikes - 1)
            await deleteCommentInteraction(commentInteractioId: interactions[0].id)
        }else if !interactions.isEmpty,interactions[0].isLiked{
            await updateCommentLikes(commentId: chatComment.id, likeCount: chatComment.likes - 1)
            await deleteCommentInteraction(commentInteractioId: interactions[0].id)
            await likeOrDislikeAComment(commentId: chatComment.id, isLiked: false, isDisliked: true)
            await updateCommentDislikes(commentId: chatComment.id, dislikeCount: chatComment.dislikes + 1)
        }else{
            await updateCommentDislikes(commentId: chatComment.id, dislikeCount: chatComment.dislikes + 1)
            await likeOrDislikeAComment(commentId: chatComment.id, isLiked: false, isDisliked: true)
        }
        await fetchCommentInteractions()
        fetchComments(chatId: chatId)
    }
}
