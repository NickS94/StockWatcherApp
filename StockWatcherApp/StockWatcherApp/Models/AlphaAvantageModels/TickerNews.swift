//
//  TickerNews.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 30.08.24.
//

import Foundation

struct TickerNews:Codable{
    let title:String
    let url:String
    let timePublished:String
    let authors:[String]
    let summary:String
    let bannerImage:String?
    let source:String
    let sourceDomain:String
    let tickerSentiment:[TickerSentiment]
}

