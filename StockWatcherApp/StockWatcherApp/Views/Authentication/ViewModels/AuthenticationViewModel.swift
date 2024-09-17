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
    
    
    private let firebaseRepository = FirebaseRepository.shared
    
    //MARK: Properties
    
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var showMainView = false
    @Published var showAlert = false
    @Published var authenticationUser:User?
    
    
    init(){
        showMainView = firebaseRepository.checkAuth() != nil
    }
    
    //MARK: Methods
    
    func signInWithGoogle(){
        Task{
            do{
                let result =  await firebaseRepository.signInWithGoogle()
                
                showMainView = result != nil
                print(showMainView)
            }
        }
    }
    
    
    func resetFields(){
        username = ""
        email = ""
        password = ""
    }
}
