//
//  ChatComment.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 23.09.24.
//

import Foundation
//Model for the ChatComment item.
struct ChatComment:Codable,Identifiable,Equatable{
    var id:String = UUID().uuidString
    let chatId:String
    let userId:String
    let publisherName:String
    let publisherProfileIcon:String
    let content:String
    let likes:Int
    let dislikes:Int
    var createdAt:Date = Date.now
    
    
}
