//
//  AlphaAvantageResponse.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 29.08.24.
//

import Foundation

struct AlphaAvantageResponse:Codable{
    let metadata:String
    let lastUpdated:String
    let topGainers:[TickerQuoteAv]
    let topLosers:[TickerQuoteAv]
    let mostActivelyTraded:[TickerQuoteAv]
}
