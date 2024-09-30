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
    @Published var isLiked = false
    @Published var isDisliked = false
    
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
    
    func createNewComment(chat:SocialChat) async{
        do{
            if let authUser = user{
                try firebaseClient.createChatComment(
                    fireuser: fireuser ?? FirestoreUser(
                        id: authUser.uid,
                        username: authUser.displayName ?? "NoName",
                        userEmail: authUser.email ?? "NoEmail",
                        userProfileIcon: authUser.photoURL?.absoluteString ?? ""),
                    user: authUser,
                    chat: chat,
                    content: commentContent)
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
    
    func likeOrDislikeAComment(commentId:String)  {
        Task{
            guard let user else{return}
            
            do{
                try firebaseClient.likeOrDislikeAcomment(user: user, commentId: commentId, isLiked: isLiked, isDisliked: isDisliked)
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchCommentInteractions() {
        Task{
            do{
                guard let user else{return}
                
                let results = try await firebaseClient.fetchCommentInteraction(from: user.uid)
                commentInteractions = results
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteCommentInteraction(commentInteractioId:String) {
        Task{
            do{
                try await firebaseClient.deleteCommentInteraction(with: commentInteractioId)
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func updateCommentLikes(commentId:String,likeCount:Int){
        Task{
            do{
                try await firebaseClient.updateCommentLikes(commentId: commentId, likeCount: likeCount)
                fetchCommentInteractions()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func updateCommentDislikes(commentId:String,dislikeCount:Int){
        Task{
            do{
                try await firebaseClient.updateCommentDislikes(commentId: commentId, dislikeCount: dislikeCount)
                fetchCommentInteractions()
            }catch{
                print(error.localizedDescription)
            }
            
        }
    }
    
    func onCommentLikeClicked(chatComment:ChatComment,chatId:String) {
        let interactions = commentInteractionCheck(commentId: chatComment.id)
        
        if !interactions.isEmpty , interactions[0].isLiked{
             updateCommentLikes(commentId: chatComment.id, likeCount: chatComment.likes - 1)
             deleteCommentInteraction(commentInteractioId: interactions[0].id)
        }else if !interactions.isEmpty,interactions[0].isDisliked{
             updateCommentDislikes(commentId: chatComment.id, dislikeCount: chatComment.dislikes - 1)
             deleteCommentInteraction(commentInteractioId: interactions[0].id)
             likeOrDislikeAComment(commentId: chatComment.id)
             updateCommentLikes(commentId: chatComment.id, likeCount: chatComment.likes + 1)
        }else{
             updateCommentLikes(commentId: chatComment.id, likeCount: chatComment.likes + 1)
             likeOrDislikeAComment(commentId: chatComment.id)
        }
         fetchCommentInteractions()
        fetchComments(chatId: chatId)
    }
    
    
    func onCommentDislikeClicked(chatComment:ChatComment,chatId:String){
        let interactions = commentInteractionCheck(commentId: chatComment.id)
        
        if !interactions.isEmpty,interactions[0].isDisliked{
             updateCommentDislikes(commentId: chatComment.id, dislikeCount: chatComment.dislikes - 1)
             deleteCommentInteraction(commentInteractioId: interactions[0].id)
        }else if !interactions.isEmpty,interactions[0].isLiked{
             updateCommentLikes(commentId: chatComment.id, likeCount: chatComment.likes - 1)
             deleteCommentInteraction(commentInteractioId: interactions[0].id)
             likeOrDislikeAComment(commentId: chatComment.id)
             updateCommentDislikes(commentId: chatComment.id, dislikeCount: chatComment.dislikes + 1)
        }else{
             updateCommentDislikes(commentId: chatComment.id, dislikeCount: chatComment.dislikes + 1)
             likeOrDislikeAComment(commentId: chatComment.id)
        }
         fetchCommentInteractions()
        fetchComments(chatId: chatId)
    }
    
    func likeCheck(chatComment:ChatComment) ->Bool{
        let interactions = commentInteractionCheck(commentId: chatComment.id)
        if !interactions.isEmpty, interactions[0].commentId == chatComment.id{
            if interactions[0].isLiked{
                return true
            }
        }
        return false
    }
    
    func dislikeCheck(chatComment:ChatComment) ->Bool{
        let interactions = commentInteractionCheck(commentId: chatComment.id)
        if !interactions.isEmpty,interactions[0].commentId == chatComment.id{
            if interactions[0].isDisliked{
                return true
            }
        }
        return false
    }
}
