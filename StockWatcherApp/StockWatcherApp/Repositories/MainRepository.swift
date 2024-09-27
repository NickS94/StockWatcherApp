//
//  MainRepository.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 30.08.24.
//

import Foundation

class MainRepository:RepositoryProtocol{
    
    private let apiClient = ApiClient.shared
    
    /**
     Use this method to call the BULK ticker quote list so you can create your watchlist.
     */
    func fetchQuoteList(_ tickersList: [String]) async throws -> [TickerQuote]? {
        do{
            let quotePath = Paths.fmpQuote(tickersList: tickersList)
            
            return try await apiClient
                .makeRequest(
                    scheme: Schemas.https.rawValue,
                    host: Hosts.fmp.rawValue,
                    path:quotePath.urlString,
                    queriesAndInputs: [(QueriesNames.apiKey.rawValue,ApiKeys.fmpApiKey)])
                    
                     
        }catch{
            throw error
        }
    }
    
    /**
     Use this method to call the ticker SEARCH results from API.
     */
    func fetchSearchTickers(_ searchQuery: String, _ limit: String, _ exchange: String) async throws -> [TickerSearch]? {
        do{
            return try await apiClient
                .makeRequest(
                    scheme: Schemas.https.rawValue,
                    host: Hosts.fmp.rawValue,
                    path: Paths.fmpSearchTicker.urlString,
                    queriesAndInputs: [
                        (QueriesNames.fmpSearch.rawValue,searchQuery),
                        (QueriesNames.fmpLimit.rawValue,limit),
                        (QueriesNames.fmpExchange.rawValue,exchange),
                        (QueriesNames.apiKey.rawValue,ApiKeys.fmpApiKey)
                    ]
                   )
        }catch{
            throw error
        }
    }
    
    /**
     Use this method to call the ticker PROFILE data from API.
     */
    func fetchCompanyProfile(_ ticker: String) async throws -> [TickerProfile]? {
        do{
            let profilePath = Paths.fmpProfile(ticker: ticker)
            
            return try await apiClient
                .makeRequest(
                    scheme: Schemas.https.rawValue,
                    host: Hosts.fmp.rawValue,
                    path:profilePath.urlString,
                    queriesAndInputs: [(QueriesNames.apiKey.rawValue,ApiKeys.fmpApiKey)]
                    )
        }catch{
            throw error
        }
    }
    
    /**
     Use this method to call CHART QUOTE items from API so with little bit fantacy you can create your won chart! Good luck!!.
     */
    func fetchChart(_ range: String, _ ticker: String, _ from: String, _ to: String) async throws -> [ChartQuote]? {
        do {
            let chartPath = Paths.fmpCharts(range: range, ticker: ticker)
            return try await apiClient
                .makeRequest(
                    scheme:Schemas.https.rawValue,
                    host: Hosts.fmp.rawValue,
                    path:chartPath.urlString,
                    queriesAndInputs: [
                        (QueriesNames.fmpFromDate.rawValue,from),
                        (QueriesNames.fmpToDate.rawValue,to),
                        (QueriesNames.apiKey.rawValue,ApiKeys.fmpApiKey)
                    ]
                    )
        }catch{
            throw error
        }
    }
    
    /**
     Use this method to call HOT LISTS of 3 such as todays gainers, losers and most traded tickers.
     */
    func fetchHotLists() async throws -> AlphaAvantageResponse? {
        do{
            return try await apiClient
                .makeRequest(
                    scheme: Schemas.https.rawValue,
                    host: Hosts.av.rawValue,
                    path: Paths.avQuery.urlString,
                    queriesAndInputs: [
                        (QueriesNames.avQuery.rawValue,QueryValues.avGainersAndLosers.rawValue),
                        (QueriesNames.apiKey.rawValue,ApiKeys.fmpApiKey)
                    ]
                )
        }catch{
            throw error
        }
    }
    
    /**
     Use this method to call the NEWS list from API and also with a query parameter you can find the news that are relevant for a specific ticker.
     */
    func fetchNews(_ ticker: String) async throws -> AlphaAvantageNewsResponse? {
        do{
            return try await apiClient
                .makeRequest(
                    scheme: Schemas.https.rawValue,
                    host: Hosts.av.rawValue,
                    path:Paths.avQuery.urlString,
                    queriesAndInputs: [
                        (QueriesNames.avQuery.rawValue,QueryValues.avNews.rawValue),
                        (QueriesNames.avTickers.rawValue,ticker),
                        (QueriesNames.apiKey.rawValue,ApiKeys.avApiKey)
                    ]
                )
        }catch{
            throw error
        }
    }
}
