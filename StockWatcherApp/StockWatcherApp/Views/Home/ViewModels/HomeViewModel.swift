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
    
    @Published var searchList:[TickerSearch] = []
    
    @Published var myTickersList:[TickerQuote] = []
    
    @Published var tickerListInput:[String] = []
    
    @Published var userSearchInput = ""
    
    @Published var userExchangeInput = ""
    
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
    
    
    func fetchSearchList(){
        Task{
            do{
                let results = try await repository.fetchSearchTickers(userSearchInput, "15", userExchangeInput)
                
                if let results = results{
                    searchList = results
                }
            }catch{
                print(error)
            }
        }
    }
    
    func checkList(tickerSymbol:String)->Bool{
        
        return myTickersList.contains { tickerQuote in
            tickerQuote.symbol == tickerSymbol
        }
    }
    
    
    
}
