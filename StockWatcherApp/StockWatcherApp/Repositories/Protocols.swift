//
//  Protocols.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 30.08.24.
//

import Foundation

protocol RepositoryProtocol {
    
    func fetchQuoteList(_ tickersList:[String]) async throws ->[TickerQuote]?
    
    func fetchSearchTickers(_ searchQuery:String,_ limit:String,_ exchange:String) async throws ->[TickerSearch]?
    
    func fetchCompanyProfile(_ ticker:String) async throws ->[TickerProfile]?
    
    func fetchChart(_ range:String,_ ticker:String,_ from:String,_ to:String) async throws  ->[ChartQuote]?
    
    func fetchHotLists() async throws  ->AlphaAvantageResponse?
    
    func fetchNews(_ ticker:String) async throws ->AlphaAvantageResponse?
    
}
