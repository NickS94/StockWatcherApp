//
//  SocialFeedViewModel.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 25.09.24.
//

import Foundation
import FirebaseAuth

@MainActor
class SocialFeedViewModel:ObservableObject{
    
    //MARK: - Properties
    
    @Published var socialChatList:[SocialChat] = []
    @Published var chatContent = ""
    @Published var chatTitle = ""
    @Published var chatInteractionsList:[LikedOrDislikedPost] = []
    @Published var fireuser:FirestoreUser?
    @Published var fireusers:[FirestoreUser] = []
    
    var user:User?{
        return firebaseClient.checkAuth()
    }
    
    private let firebaseClient = FirebaseRepository.shared
    
    //MARK: - Methods
    
    
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
    
    func getFireUserProfileIcon(socialPost: SocialChat) -> String {
        for fireUser in fireusers {
            if fireUser.id == socialPost.userId {
                return fireUser.userProfileIcon
            }
        }
        return "person"
    }
    
    func fetchSocialChats(){
        Task{
            do{
                let results = try await firebaseClient.fetchSocialChats()
                
                socialChatList = results
                
            } catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func createPost() {
        do{
            
            if let user = user{
                try firebaseClient.createSocialChat(fireuser: fireuser ?? FirestoreUser(id: user.uid, username: user.displayName ?? "NoName", userEmail: user.email ?? "NoEmail", userProfileIcon: user.photoURL?.absoluteString ?? ""), user: user, title: chatTitle, content: chatContent)
                fetchSocialChats()
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func likeOrDislikePost(chatId: String, isLiked: Bool, isDisliked: Bool)async {
        guard let user else { return }
        do {
            try firebaseClient.likeOrDislikeAPost(user: user, chatId: chatId, isLiked: isLiked, isDisliked: isDisliked)
        } catch {
            print(error.localizedDescription)
        }
    }
    
 
    func fetchPostInteractions()async {
        do{
            guard let user else {return}
            
            let results = try await firebaseClient.fetchPostInteraction(from: user.uid)
            chatInteractionsList = results
        }catch{
            print(error.localizedDescription)
        }
        
        
    }
    
    func deleteInteraction(interactionId:String) async {
        do{
            try await firebaseClient.deletePostInteraction(with: interactionId)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func interactionCheck(chatId:String) -> [LikedOrDislikedPost]{
        return chatInteractionsList.filter{ interaction in
            interaction.chatId == chatId
        }
    }
    
    func updateChatLikes(chatId:String,likeCount:Int)async {
        
        do{
            try await firebaseClient.updatePostLikes(postId: chatId, likeCount: likeCount)
            await fetchPostInteractions()
        }catch{
            print(error.localizedDescription)
        }
        
        
    }
    
    func updateChatDislikes(chatId:String,dislikeCount:Int) async{
        do{
            try await firebaseClient.updatePostDislikes(postId: chatId, dislikeCount: dislikeCount)
            await fetchPostInteractions()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func onLikeClicked(socialChat: SocialChat) async {
        let interactions = interactionCheck(chatId: socialChat.id)
        if !interactions.isEmpty, interactions[0].isLiked {
            await updateChatLikes(chatId: socialChat.id, likeCount: socialChat.likes - 1)
            await deleteInteraction(interactionId: interactions[0].id)
        }else if !interactions.isEmpty, interactions[0].isDisliked {
            await updateChatDislikes(chatId: socialChat.id, dislikeCount: socialChat.dislikes - 1)
            await deleteInteraction(interactionId: interactions[0].id)
            await likeOrDislikePost(chatId: socialChat.id, isLiked: true, isDisliked: false)
            await updateChatLikes(chatId: socialChat.id, likeCount: socialChat.likes + 1)
        }else {
            await updateChatLikes(chatId: socialChat.id, likeCount: socialChat.likes + 1)
            await likeOrDislikePost(chatId: socialChat.id, isLiked: true, isDisliked: false)
        }
        await fetchPostInteractions()
        fetchSocialChats()
    }
    
    func onDislikeClicked(socialChat: SocialChat) async {
        let interactions = interactionCheck(chatId: socialChat.id)
        if !interactions.isEmpty, interactions[0].isDisliked {
            await updateChatDislikes(chatId: socialChat.id, dislikeCount: socialChat.dislikes - 1)
            await deleteInteraction(interactionId: interactions[0].id)
        }else if !interactions.isEmpty, interactions[0].isLiked {
            await updateChatLikes(chatId: socialChat.id, likeCount: socialChat.likes - 1)
            await deleteInteraction(interactionId: interactions[0].id)
            await likeOrDislikePost(chatId: socialChat.id, isLiked: false, isDisliked: true)
            await updateChatDislikes(chatId: socialChat.id, dislikeCount: socialChat.dislikes + 1)
        }else {
            await updateChatDislikes(chatId: socialChat.id, dislikeCount: socialChat.dislikes + 1)
            await likeOrDislikePost(chatId: socialChat.id, isLiked: false, isDisliked: true)
        }
        await fetchPostInteractions()
        fetchSocialChats()
    }
    
}
