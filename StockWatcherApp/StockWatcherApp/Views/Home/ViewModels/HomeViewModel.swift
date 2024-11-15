//
//  MyListViewModel.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 28.08.24.
//

import Foundation
import FirebaseAuth

@MainActor
class HomeViewModel:ObservableObject{
    //MARK: - Properties
    
    private let firebaseClient = FirebaseRepository.shared
    
    @Published var searchList:[TickerSearch] = []
    @Published var myTickersList:[TickerQuote] = []
    @Published var userSearchInput = ""
    @Published var exchangeInput:StockExchange = .amex
    @Published var tickerListInput:[String] = []
    @Published var fireusers:[FirestoreUser] = []
    @Published var firestoreUser:FirestoreUser?
    
    let repository:RepositoryProtocol
    
    init(repository:RepositoryProtocol) {
        self.repository = repository
    }
    
    //MARK: - Methods
    
    func fetchFireUser(){
        Task{
            do{
                let result = try await firebaseClient.getFirestoreUser()
                firestoreUser = result
            }catch{
                print(error)
            }
        }
    }
    
    func fetchFireusers(){
        Task{
            do{
                let result = try await firebaseClient.fetchFirestoreUsers()
                fireusers = result
            }catch{
                print(error)
            }
        }
      
    }
    
    func fetchFmpTickersList(){
        Task{
            do{
                fetchWatchListFromDatabase()
                let results = try await repository.fetchQuoteList(tickerListInput)
                if let results = results{
                    myTickersList = results
                }
            }catch{
                print(error)
            }
        }
    }
    
    func fetchSearchList(userExchangeInput:String = ""){
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
            try firebaseClient.createAndUpdateWatchlist(ticker: ticker)
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
                tickerListInput = results
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
