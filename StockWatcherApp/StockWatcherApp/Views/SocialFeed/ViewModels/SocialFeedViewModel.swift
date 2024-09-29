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
    
    var user:User?{
        return firebaseClient.checkAuth()
    }
        
    private let firebaseClient = FirebaseRepository.shared
    
    //MARK: - Methods
    
    func fetchFireuser(){
        Task{
            do{
                let result = try await firebaseClient.getFirestoreUser()
                fireuser = result
            }
        }
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
         
            if let user = user , let fireuser = fireuser {
                
                try firebaseClient.createSocialChat(fireuser: fireuser, user: user, title: chatTitle, content: chatContent)
                fetchSocialChats()
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func likeOrDislikePost(chatId:String,isLiked:Bool,isDisliked:Bool){
        guard let user else{
            return
        }
        do{
            try firebaseClient.likeOrDislikeAPost(user: user, chatId: chatId, isLiked: isLiked, isDisliked: isDisliked)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func fetchPostInteractions()async{
        
        do{
            guard let user else {return}
            
            let results = try await firebaseClient.fetchInteraction(from: user.uid)
            chatInteractionsList = results
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
    func deleteInteraction(interactionId:String) async{
        
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
    
    func updateChatLikes(chatId:String,likeCount:Int)async{
        do{
            try await firebaseClient.updatePostLikes(postId: chatId, likeCount: likeCount)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func updateChatDislikes(chatId:String,dislikeCount:Int)async{
        do{
            try await firebaseClient.updatePostDislikes(postId: chatId, dislikeCount: dislikeCount)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func onLikeClicked(socialChat:SocialChat) async{
        
        let interactions = interactionCheck(chatId: socialChat.id)
        
        if  !interactions.isEmpty, interactions[0].isLiked {
            await updateChatLikes(chatId: socialChat.id, likeCount: socialChat.likes - 1)
            await deleteInteraction(interactionId: interactions[0].id)
            fetchSocialChats()
        }else{
            likeOrDislikePost(chatId: socialChat.id, isLiked: true, isDisliked: false)
            await updateChatLikes(chatId: socialChat.id, likeCount: socialChat.likes + 1)
            fetchSocialChats()
        }
        
        if !interactions.isEmpty,interactions[0].isDisliked {
            await updateChatDislikes(chatId: socialChat.id, dislikeCount: socialChat.dislikes - 1)
            likeOrDislikePost(chatId: socialChat.id, isLiked: true, isDisliked: false)
            await updateChatLikes(chatId: socialChat.id, likeCount: socialChat.likes + 1)
            fetchSocialChats()
        }
        await fetchPostInteractions()
    }
    
    func onDislikeClicked(socialChat:SocialChat) async{
        
        let interactions = interactionCheck(chatId: socialChat.id)
        
        if !interactions.isEmpty, interactions[0].isDisliked{
            await deleteInteraction(interactionId: interactions[0].id)
            await updateChatDislikes(chatId: socialChat.id, dislikeCount: socialChat.dislikes - 1)
            fetchSocialChats()
        }else{
            likeOrDislikePost(chatId: socialChat.id, isLiked: false, isDisliked: true)
            await updateChatDislikes(chatId: socialChat.id, dislikeCount: socialChat.dislikes + 1)
            fetchSocialChats()
        }
        
        if !interactions.isEmpty , interactions[0].isLiked{
            await updateChatLikes(chatId: socialChat.id, likeCount: socialChat.likes - 1)
            likeOrDislikePost(chatId: socialChat.id, isLiked: false, isDisliked: true)
            await updateChatDislikes(chatId: socialChat.id, dislikeCount: socialChat.dislikes + 1)
            fetchSocialChats()
        }
        await fetchPostInteractions()
    }
    
}
