//
//  ChatComment.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 23.09.24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct ChatComment:Codable{
    @DocumentID var id:String?
    let chatId:String
    let userId:String
    let content:String
    let like:Int
    let dislike:Int
    var createdAt:Date = Date.now
    
    init(user:User,chat:SocialChat,content:String,like:Int,dislike:Int) {
        
        self.chatId = chat.id ?? ""
        self.userId = user.uid
        self.content = content
        self.like = like
        self.dislike = dislike
    }
    
}
