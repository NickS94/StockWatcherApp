//
//  ChartQuote.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 30.08.24.
//

import Foundation

struct ChartQuote:Codable{
    let date:String
    let open:Double
    let low:Double
    let high:Double
    let close:Double
    let volume:Int
}
