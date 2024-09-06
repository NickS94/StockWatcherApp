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
        symbol: "",
        name: "",
        price: 0,
        changesPercentage: 0,
        change: 0,
        dayLow: 0,
        dayHigh: 0,
        yearHigh: 0,
        yearLow: 0,
        marketCap: 0,
        priceAvg50: 0,
        priceAvg200: 0,
        exchange: "",
        eps: 0,
        pe: 0,
        sharesOutstanding: 0
    )
    
    @Published var tickerListInput:[String] = []
    
    let repository:RepositoryProtocol
    
    init(repository:RepositoryProtocol) {
        self.repository = repository
    }
    
    //MARK: Methods
    
    func fetchFmpTickersList(){
        Task{
            do{
                let results = try await repository.fetchQuoteList(tickerListInput)
                
                if let results = results{
                    myTickersList = results
                }
            }catch{
                print(error)
            }
        }
    }
    
    
    
    
    func getTickerQuote(tickerSymbol:String){
        Task{
            do{
                let temporaryList = [tickerSymbol]
                let results = try await repository.fetchQuoteList(temporaryList)
                
                if let results = results{
                    
                    if let ticker = results.first{
                        tickerQuote = ticker
                    }
                }
            }catch{
                print(error)
            }
        }
    }
}
