//
//  MyListViewModel.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 28.08.24.
//

import Foundation

@MainActor
class MyListViewModel:ObservableObject{
    //MARK: Properties
    
    private let apiClient = ApiClient.shared
    
    @Published var myTickersList:[TickerQuote] = []
    
    //MARK: Api Fetching Methods
    
}
