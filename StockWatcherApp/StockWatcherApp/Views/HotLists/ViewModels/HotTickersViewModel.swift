//
//  HotTickersViewModel.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 29.08.24.
//

import Foundation

@MainActor
class HotTickersViewModel:ObservableObject{
    //MARK: Properties
    
    @Published var hotList:[TickerQuoteAv] = []
    @Published var listSelection:HotListsPickerItems = .mostActivelyTraded
    
    // Repository constant which get initiallised from outside so we are able to make a dependency injection and use mock data for our view creation and testing.
    let repository:RepositoryProtocol
    init(repository:RepositoryProtocol){
        self.repository = repository
    }
    //MARK: Methods
    
    /**
     Use this method to fetch the hot lists from API in the hotList variable when the value of listSelection changes using a switch statement.
     */
    func getHotLists(){
        Task{
            do{
                let results = try await repository.fetchHotLists()
                if let results = results{
                    switch listSelection {
                    case .mostActivelyTraded:
                        hotList = results.mostActivelyTraded
                    case .gainers:
                        hotList = results.topGainers
                    case .losers:
                        hotList = results.topLosers
                    }
                }
            }catch{
                print(error)
            }
        }
    }
}
