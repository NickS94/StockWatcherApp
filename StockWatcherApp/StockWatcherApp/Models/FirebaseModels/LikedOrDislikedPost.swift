//
//  LikedOrDislikedPost.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 25.09.24.
//

import Foundation

struct LikedOrDislikedPost:Codable{
    let id:String
    let chatId:String
    let userId:String
    let isLiked:Bool
    let isDisliked:Bool
    
}
