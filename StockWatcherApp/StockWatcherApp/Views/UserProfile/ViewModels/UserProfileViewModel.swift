//
//  UserProfileViewModel.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 18.09.24.
//

import Foundation
import FirebaseAuth


class UserProfileViewModel:ObservableObject{
    
    //MARK: Properties
    
    private let firebaseClient = FirebaseRepository.shared
    
    @Published var fireuser:FirestoreUser?
    @Published var content = ""
    @Published var isPublic = false
    
    var user:User?
    
    init(){
        self.user = firebaseClient.checkAuth()
    }
    
    //MARK: Methods
    
    func getFireUser(){
        Task{
            do{
                let userResults = try await firebaseClient.getFirestoreUser()
                fireuser = userResults
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchUser(){
        Task{
            do{
                let result = firebaseClient.checkAuth()
                
                if let result = result{
                    user = result
                }
            }
        }
    }
    
    func deleteUser(){
        Task{
            do{
                if let authUser = user{
                    try await firebaseClient.deleteUsersCollection(user: authUser)
                }
                try await firebaseClient.deleteUser()
                
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func logoutUser(){
        do{
            try firebaseClient.logout()
        }catch{
            print(error.localizedDescription)
        }
    }
}
