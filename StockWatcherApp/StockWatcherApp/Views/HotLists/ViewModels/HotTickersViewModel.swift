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
    
    @Published var gainersList:[TickerQuoteAv] = []
    @Published var losersList:[TickerQuoteAv] = []
    @Published var mostTradedList:[TickerQuoteAv] = []
    
    let repository:RepositoryProtocol
    
    init(repository:RepositoryProtocol){
        self.repository = repository
    }
    
    //MARK: Methods
}
