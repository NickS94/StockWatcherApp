//
//  UrlComponents.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 27.08.24.
//

import Foundation

enum Schemas:String{
    case http,https
}

enum Hosts:String{
    case fmp = "financialmodelingprep.com"
    case av =  "www.alphavantage.co"
}

enum Paths{
    
    case fmpQuote(tickersList:[String] = [])
    case fmpSearchTicker
    case fmpProfile(ticker:String)
    case fmpCharts(range:String,ticker:String)
    case avQuery
    
    var urlString:String{
        switch self {
        case .fmpQuote(let tickersList):
            return "/api/v3/quote/\(tickersList.joined(separator: ","))"
        case .fmpSearchTicker:
           return "/api/v3/search-ticker"
        case .fmpProfile(let ticker):
            return "/api/v3/profile/\(ticker)"
        case .fmpCharts(let range,let ticker):
            return "/api/v3/historical-chart/\(range)/\(ticker)"
        case .avQuery:
            return "/query"
        }
    }
}

enum QueriesNames:String{
    case fmpSearch = "query"
    case fmpFromDate = "from"
    case fmpToDate = "to"
    case avQuery = "function"
    case avTickers = "tickers"
    case apiKey = "apikey"
}

enum QueryValues:String{
    case avGainersAndLosers = "TOP_GAINERS_LOSERS"
    case avNews = "NEWS_SENTIMENT"
}
