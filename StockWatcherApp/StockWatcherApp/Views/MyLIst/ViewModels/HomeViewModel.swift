//
//  MyListViewModel.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 28.08.24.
//

import Foundation

@MainActor
class HomeViewModel:ObservableObject{
    //MARK: Properties
    
    private let apiClient = ApiClient.shared
    
    
    @Published var myTickersList:[TickerQuote] = []
    
    @Published var tickerQuote = TickerQuote(
        symbol: "AAPL",
        name: "Apple Inc.",
        price: 229.97,
        changesPercentage: 0.0783,
        change: 0.18,
        dayLow: 229.345,
        dayHigh: 230.4,
        yearHigh: 237.23,
        yearLow: 164.08,
        marketCap: 3496486877000,
        priceAvg50: 221.2112,
        priceAvg200: 193.88576,
        exchange: "NASDAQ",
        eps: 6.57,
        pe: 35,
        sharesOutstanding: 15204100000
    )
    
    @Published var tickerListInput:[String] = []
    
    let repository:RepositoryProtocol
    
    init(repository:RepositoryProtocol) {
        self.repository = repository
    }
    
    //MARK: Methods
    
    func fetchFmpTickersList(tickerSymbol:String){
        Task{
            do{
                let results = try await repository.fetchQuoteList(tickerListInput)
                
                if let results = results{
                    myTickersList = results
                    
                    tickerListInput.append(tickerSymbol)
                    
                    let filteredTickers = results.filter { ticker in
                        ticker.symbol == tickerSymbol
                    }
                    
                    if let resultFilter = filteredTickers.first{
                        tickerQuote = resultFilter
                    }
                    
                }
            }catch{
                print(error)
            }
        }
    }
}
