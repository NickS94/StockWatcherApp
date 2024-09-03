//
//  TickerProfile.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 28.08.24.
//

import Foundation

struct TickerProfile:Codable{
    let symbol:String?
    let price:Double?
    let beta:Double?
    let volAvg:Int?
    let lastDiv:Double?
    let range:String?
    let changes:Double?
    let companyName:String?
    let currency:String?
    let cik:String?
    let isin:String?
    let cusip:String?
    let exchange:String?
    let exchangeShortName:String?
    let industry:String?
    let website:String?
    let description:String?
    let ceo:String?
    let sector:String?
    let country:String?
    let fullTimeEmployees:String?
    let phone:String?
    let address:String?
    let city:String?
    let state:String?
    let zip:String?
    let dcfDiff:Double?
    let dcf:Double?
    let image:String?
    let ipoDate:String?
}
