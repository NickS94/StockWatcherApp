//
//  ChatComment.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 23.09.24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct ChatComment:Codable,Identifiable{
    @DocumentID var id:String?
    let chatId:String
    let userId:String
    let publisherName:String
    let publisherProfileIcon:URL?
    let content:String
    let likes:Int
    let dislikes:Int
    var createdAt:Date = Date.now
    
    
}
