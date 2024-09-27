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
    
    var user:User?{
        return firebaseClient.checkAuth()
    }
    
    private let firebaseClient = FirebaseRepository.shared
    
    //MARK: - Methods
    
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
    
    func createAndUpdatePost(id:String = UUID().uuidString , content:String = "", title:String = "", chatLikes:Int = 0 , chatDislikes:Int = 0) {
        do{
            guard let user else{
                return
            }
            let chat = SocialChat(
                id: id,
                userId:user.uid ,
                publisherName: user.displayName ?? "",
                publisherProfileIcon: user.photoURL,
                title: title.isEmpty ? chatTitle : title,
                content: content.isEmpty ? chatContent : content,
                likes: chatLikes,
                dislikes: chatDislikes)
            
            try firebaseClient.createAndUpdateSocialChat(socialChat: chat)
            fetchSocialChats()
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
    
    func onLikeClicked(socialChat:SocialChat) async{
        
        let interactions = interactionCheck(chatId: socialChat.id)
        
        if !interactions.isEmpty , interactions[0].isLiked {
            await deleteInteraction(interactionId: interactions[0].id)
            createAndUpdatePost(id:socialChat.id,content: socialChat.content, title: socialChat.title, chatLikes: socialChat.likes  - 1 , chatDislikes: socialChat.dislikes )
            
        }else{
            likeOrDislikePost(chatId: socialChat.id, isLiked: true, isDisliked: false)
            createAndUpdatePost(id:socialChat.id,content: socialChat.content, title: socialChat.title,chatLikes: socialChat.likes  + 1 , chatDislikes: socialChat.dislikes )
        }
        await fetchPostInteractions()
        
    }
    
}
