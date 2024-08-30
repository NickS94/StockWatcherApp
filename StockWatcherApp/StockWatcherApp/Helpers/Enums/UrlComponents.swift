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
    case fmpLimit = "limit"
    case fmpExchange = "exchange"
    case avQuery = "function"
    case avTickers = "tickers"
    case apiKey = "apikey"
}

enum QueryValues:String{
    case avGainersAndLosers = "TOP_GAINERS_LOSERS"
    case avNews = "NEWS_SENTIMENT"
}

enum ImageUrls{
    case fmpTickerImage(ticker:String)
    
    
    var urlString:String{
        switch self{
        case.fmpTickerImage(let ticker):
            return "https://financialmodelingprep.com/image-stock/\(ticker).png"
        }
    }
}


enum MockEndpoints:String{
    // Hot list
    case mockHostHotList = "http://localhost:3001/TOP_GAINERS_LOSERS"

    // News
    case mockHostNews = " http://localhost:3002/NEWS_SENTIMENT"

    // Quote list
    case mockHostQuoteList = "http://localhost:3003/api/v3/quote/AAPL,MSFT"

    // Search ticker
    case mockHostSearchTicker = "http://localhost:3004/api/v3/search-ticker"

    // Company profile
    case mockHostCompanyProfile = "http://localhost:3005/api/v3/profile/AAPL"

    // Ticker Chart
    case mockHostChart = "http://localhost:3006/api/v3/historical-chart/5min/AAPL"
}
