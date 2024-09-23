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
    
    private let firebaseClient = FirebaseRepository.shared
    
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
    
    func addToWatchlist(ticker:String){
        do{
            try firebaseClient.createWatchlist(ticker: ticker)
            fetchWatchListFromDatabase()
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
    func deleteFromWatchlist(ticker:String){
        Task{
            do{
                try await firebaseClient.deleteFromWatchlist(ticker: ticker)
                fetchWatchListFromDatabase()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchWatchListFromDatabase() {
        Task{
            do{
                let results = try await firebaseClient.fetchUserWatchlist()
                let tickerList = results.compactMap{$0.tickerSymbol}
                
                tickerListInput = tickerList
                
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    
    func checkList(tickerSymbol:String)->Bool{
        
        return myTickersList.contains { tickerQuote in
            tickerQuote.symbol == tickerSymbol
        }
        
    }
    
    
    
}
