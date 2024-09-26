//
//  ChatCommentsViewModel.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 25.09.24.
//

import Foundation

@MainActor
class ChatCommentsViewModel:ObservableObject{
    
    //MARK: - Properties
    
    private let firebaseClient = FirebaseRepository.shared
    
    @Published var chatComments:[ChatComment] = []
    @Published var commentLikes = 0
    @Published var commentDislikes = 0
    @Published var commentContent = ""
    @Published var commentTitle = ""
    
    
    
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
}
