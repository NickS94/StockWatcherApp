//
//  LikedOrDislikedPost.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 25.09.24.
//

import Foundation
//Model to save the like or dislike interaction in post.
struct LikedOrDislikedPost:Codable{
    let id:String
    let chatId:String
    let userId:String
    let isLiked:Bool
    let isDisliked:Bool
    
}
