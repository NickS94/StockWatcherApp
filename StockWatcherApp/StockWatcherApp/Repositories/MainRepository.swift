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
                    queryItemFirst: QueriesNames.apiKey.rawValue,
                    userFirstInput: ApiKeys.fmpApiKey)
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
                    queryItemFirst: QueriesNames.fmpSearch.rawValue,
                    queryItemSecond: QueriesNames.fmpLimit.rawValue,
                    queryItemThird: QueriesNames.fmpExchange.rawValue,
                    queryItemFourth: QueriesNames.apiKey.rawValue,
                    userFirstInput: searchQuery,
                    userSecondInput: limit,
                    userThirdInput: exchange,
                    userFourthInput: ApiKeys.fmpApiKey)
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
                    queryItemFirst: QueriesNames.apiKey.rawValue,
                    userFirstInput: ApiKeys.fmpApiKey)
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
                    queryItemFirst: QueriesNames.fmpFromDate.rawValue,
                    queryItemSecond: QueriesNames.fmpToDate.rawValue,
                    queryItemThird: QueriesNames.apiKey.rawValue,
                    userFirstInput: from,
                    userSecondInput: to,
                    userThirdInput: ApiKeys.fmpApiKey)
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
                    queryItemFirst: QueriesNames.avQuery.rawValue,
                    queryItemSecond: QueriesNames.apiKey.rawValue,
                    userFirstInput: QueryValues.avGainersAndLosers.rawValue,
                    userSecondInput: ApiKeys.avApiKey
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
                    queryItemFirst: QueriesNames.avQuery.rawValue,
                    queryItemSecond: QueriesNames.avTickers.rawValue,
                    queryItemThird: QueriesNames.apiKey.rawValue,
                    userFirstInput: QueryValues.avNews.rawValue,
                    userSecondInput: ticker,
                    userThirdInput: ApiKeys.avApiKey
                )
        }catch{
            throw error
        }
    }
}
