//
//  TickerQuote.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 28.08.24.
//

import Foundation

struct TickerQuote:Codable{

    let symbol:String?
    let name:String?
    let price:Double?
    let changesPercentage:Double?
    let change:Double?
    let dayLow:Double?
    let dayHigh:Double?
    let yearHigh:Double?
    let yearLow:Double?
    let marketCap:Int?
    let priceAvg50:Double?
    let priceAvg200:Double?
    let exchange:String?
    let previousClose:Double?
    let eps:Double?
    let pe:Double?
    let sharesOutstanding:Int?
    
}
