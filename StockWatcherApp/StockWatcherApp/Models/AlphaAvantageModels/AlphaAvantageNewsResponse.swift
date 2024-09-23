//
//  AlphaAvantageNewsResponse.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 02.09.24.
//

import Foundation

struct AlphaAvantageNewsResponse:Codable{
    let feed:[TickerNews]?
}
