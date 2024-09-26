//
//  AuthenticationViewModel.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 12.09.24.
//

import Foundation
import FirebaseAuth

@MainActor
class AuthenticationViewModel:ObservableObject{
    
    
    private let firebaseClient = FirebaseRepository.shared
    
    //MARK: Properties
    
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var showMainView = true
    @Published var showAlert = false
    @Published var authenticationUser:User?
    
    
    init(){
        showMainView = firebaseClient.checkAuth() != nil
    }
    
    //MARK: Methods
    
    
    func registerUser(){
        Task{
            do{
                let results = try await firebaseClient.newUserRegister(email, password, username)
                authenticationUser = results
                if let authUser =  authenticationUser   {
                    try  firebaseClient.createNewFirestoreUser(user: authUser)
                }
                showMainView = true
            }catch{
                errorMessage = error.localizedDescription
                showAlert = true
            }
        }
    }
    
    func loginUser(){
        Task{
            do{
                let result = try await firebaseClient.userSignIn(email, password)
                authenticationUser = result
                showMainView = true
            }catch{
                errorMessage = error.localizedDescription
                showAlert = true
            }
        }
    }
    
    func signInWithGoogle() {
        Task{
            let result =  await firebaseClient.signInWithGoogle()
            authenticationUser = result
            if let authUser =  authenticationUser   {
                try  firebaseClient.createNewFirestoreUser(user: authUser)
            }
            showMainView = result != nil
        }
    }
    
    func resetFields(){
        username = ""
        email = ""
        password = ""
    }
}
