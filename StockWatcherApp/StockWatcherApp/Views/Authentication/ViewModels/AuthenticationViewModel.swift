//
//  AuthenticationViewModel.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 12.09.24.
//

import Foundation


class AuthenticationViewModel:ObservableObject{
    //MARK: Properties
    
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var showMainView = false
    @Published var showAlert = false
    
    
    //MARK: Methods
    
    
    
    
    func resetFields(){
        username = ""
        email = ""
        password = ""
    }
}
