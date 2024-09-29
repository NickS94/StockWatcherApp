//
//  LikeOrDislikeAComment.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 29.09.24.
//

import Foundation

struct LikeOrDislikeAComment:Codable{
    let id:String
    let commentId:String
    let userId:String
    let isLiked:Bool
    let isDisliked:Bool
}
