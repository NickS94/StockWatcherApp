//
//  TickerQuote.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 28.08.24.
//

import Foundation

struct TickerQuote:Codable{
    let symbol:String
    let name:String
    let price:Double
    let changesPercentage:Double
    let change:Double
}
