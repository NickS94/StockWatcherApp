//
//  SearchTicker.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 28.08.24.
//

import Foundation

struct TickerSearch:Codable{
    let symbol:String
    let name:String
    let exchangeShortName:String?
}
