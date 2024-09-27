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
    
    func createAndUpdatePost(chatLikes:Int = 0 , chatDislikes:Int = 0){
        do{
            guard let user else{
                return
            }
            try firebaseClient.createAndUpdateSocialChat(user: user, content: chatContent, title: chatTitle, likes: chatLikes, dislikes: chatDislikes)
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
    
    func fetchPostInteractions(){
        Task{
            do{
                let results = try await firebaseClient.fetchPostInteractions()
                chatInteractionsList = results
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func interactionCheck(chatId:String,userId:String){
        Task{
            do{
                let result = try await firebaseClient.fetchInteraction(for: chatId, from: userId)
                
            }catch{
                print(error.localizedDescription)
            }
        }
        
    }
    
}
