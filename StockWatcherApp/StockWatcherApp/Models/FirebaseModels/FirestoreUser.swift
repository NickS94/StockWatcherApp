//
//  FirestoreUser.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 17.09.24.
//

import Foundation
import FirebaseAuth
// Model for the user in Firestore.
struct FirestoreUser:Codable{
    let id:String
    let username:String
    let userEmail:String
    let userProfileIcon:String
}
