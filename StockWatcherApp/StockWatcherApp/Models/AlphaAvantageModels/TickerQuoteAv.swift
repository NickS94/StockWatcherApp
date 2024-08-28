//
//  TickerQuoteAv.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 29.08.24.
//

import Foundation

struct TickerQuoteAv:Codable{
    let ticker:String
    let price:String
    let changeAmount:String
    let changePercentage:String
    let volume:String
}
