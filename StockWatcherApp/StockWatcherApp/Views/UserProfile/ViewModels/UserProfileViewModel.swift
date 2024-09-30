//
//  UserProfileViewModel.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 18.09.24.
//

import Foundation
import FirebaseAuth

@MainActor
class UserProfileViewModel:ObservableObject{
    
    //MARK: Properties
    
    private let firebaseClient = FirebaseRepository.shared
    
    @Published var fireuser:FirestoreUser?
    @Published var profileIcons:ProfileIcons = .lizard
    @Published var username = ""
    
    var user:User?{
        return firebaseClient.checkAuth()
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
    
    func updateUserInformation(){
        Task{
            do{
                try await firebaseClient.updateFireuserInformation(username: username, userProfileIcon: profileIcons.iconName)
            }catch{
                
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
}
