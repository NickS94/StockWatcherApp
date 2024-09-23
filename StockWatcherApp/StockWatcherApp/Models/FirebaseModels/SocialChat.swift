//
//  SocialChat.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 23.09.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct SocialChat:Codable{
   @DocumentID  var id:String?
    let userId:String
    let publisherName:String
    let publisherProfileIcon:URL?
    let content:String
    let likes:Int
    let dislikes:Int
    var createdAt:Date = Date.now
    
    init(user:User,content:String,likes:Int,dislikes:Int){
        self.userId = user.uid
        self.publisherName = user.displayName ?? "Anonymous"
        self.publisherProfileIcon = user.photoURL
        self.content = content
        self.likes = likes
        self.dislikes = dislikes
    }
}
