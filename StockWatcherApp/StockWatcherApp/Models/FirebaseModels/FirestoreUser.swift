//
//  FirestoreUser.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 17.09.24.
//

import Foundation
import FirebaseAuth

struct FirestoreUser:Codable{
    let id:String
    let username:String
    let userEmail:String
    let userProfileIcon:String
    init(user:User,userProfileIcon:String){
        self.id = user.uid
        self.userEmail = user.email ?? ""
        self.username = user.displayName ?? ""
        self.userProfileIcon = userProfileIcon
    }
}
