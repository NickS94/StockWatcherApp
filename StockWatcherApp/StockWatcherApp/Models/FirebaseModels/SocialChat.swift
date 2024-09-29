//
//  SocialChat.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 23.09.24.
//

import Foundation


struct SocialChat:Codable,Identifiable{
    var id : String = UUID().uuidString
    let userId:String
    let publisherName:String
    let publisherProfileIcon:String
    let title:String
    let content:String
    let likes:Int
    let dislikes:Int
    var createdAt:Date = Date.now
}
