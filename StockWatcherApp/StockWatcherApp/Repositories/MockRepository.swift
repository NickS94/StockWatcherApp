//
//  MockRepository.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 30.08.24.
//

import Foundation

//Mock repository for dependency injection
class MockRepository:RepositoryProtocol{

    private let apiClient = ApiClient.shared
    
    func fetchQuoteList(_ tickersList:[String]) async throws -> [TickerQuote]? {
         try await apiClient.makeMockRequest(url: MockEndpoints.mockHostQuoteList.rawValue)
    }
    
    
    func fetchSearchTickers(_ searchQuery:String,_ limit:String,_ exchange:String) async throws -> [TickerSearch]? {
        try await apiClient.makeMockRequest(url: MockEndpoints.mockHostSearchTicker.rawValue)
    }
    
    func fetchCompanyProfile(_ ticker:String) async throws -> [TickerProfile]? {
        try await apiClient.makeMockRequest(url: MockEndpoints.mockHostCompanyProfile.rawValue)
    }
    
    func fetchChart(_ range:String,_ ticker:String,_ from:String,_ to:String) async throws -> [ChartQuote]? {
        try await apiClient.makeMockRequest(url: MockEndpoints.mockHostChart.rawValue)
    }
    
    func fetchHotLists() async throws -> AlphaAvantageResponse? {
        try await apiClient.makeMockRequest(url: MockEndpoints.mockHostHotList.rawValue)
    }
    
    func fetchNews(_ ticker:String) async throws -> AlphaAvantageNewsResponse? {
        try await apiClient.makeMockRequest(url: MockEndpoints.mockHostNews.rawValue)
    }
}
