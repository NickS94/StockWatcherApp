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
    @Published var chatLikes = 0
    @Published var chatDislikes = 0
    @Published var chatContent = ""
    @Published var chatTitle = ""
    
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
    
    
    func createNewPost(){
        do{
            guard let user else{
                return
            }
            try firebaseClient.createSocialChat(user: user, content: chatContent, title: chatTitle, likes: chatLikes, dislikes: chatDislikes)
        }catch{
            print(error.localizedDescription)
        }
    }
    
}
