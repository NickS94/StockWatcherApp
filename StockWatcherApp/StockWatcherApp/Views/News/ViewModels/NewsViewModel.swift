//
//  NewsViewModel.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 02.09.24.
//

import Foundation

@MainActor
class NewsViewModel:ObservableObject{
    //MARK: Properties
    
    @Published var newsList:[TickerNews] = []
    
    let repository:RepositoryProtocol
    
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    
    //MARK: Methods
    
    /**
     Use this method to call the news list from API.
     - Parameters:
        - ticker : Use this parameter to result in a list of news related on this ticker.
     */
    func fetchNews(ticker:String){
        Task{
            do{
                let results = try await repository.fetchNews(ticker)
                
                if let results = results{
                    newsList = results.feed ?? []
                }
            }catch{
                print(error)
            }
        }
    }
    
}
