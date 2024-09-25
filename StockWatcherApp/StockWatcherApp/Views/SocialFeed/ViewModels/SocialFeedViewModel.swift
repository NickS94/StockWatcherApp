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

    var user:User{
        
        guard firebaseClient.checkAuth() != nil else{return}
        
        return
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
        
    }
    
}
