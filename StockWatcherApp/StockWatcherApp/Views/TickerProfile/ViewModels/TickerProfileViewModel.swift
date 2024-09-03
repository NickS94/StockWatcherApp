//
//  TickerProfileViewModel.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 03.09.24.
//

import Foundation

class TickerProfileViewModel:ObservableObject{
    //MARK: Properties
    
    @Published var tickerProfile:TickerProfile?
    
    let repository:RepositoryProtocol
    
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    //MARK: Methods
    
    func fetchTickerProfile(_ tickerInput:String){
        
        Task{
            do{
                
                let result = try await repository.fetchCompanyProfile(tickerInput)
                
                if let result = result {
                    for ticker in result{
                        if ticker.symbol == tickerInput{
                            tickerProfile = ticker
                        }
                    }
                }
                
            }catch{
                print(error)
            }
        }
    }
}
