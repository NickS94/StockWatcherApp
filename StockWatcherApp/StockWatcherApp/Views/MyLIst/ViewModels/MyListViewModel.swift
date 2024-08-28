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
    
    @Published var profileInput = "NKLA"
    
    //MARK: Api Fetching Methods
    
    
    func fetchTickerProfile(){
        Task{
            do{
                let profilePath = Paths.fmpProfile(ticker: profileInput).urlString
                
                print (profilePath)
                
                let results:[TickerProfile]? = try await apiClient
                    .makeRequest(
                        scheme: Schemas.https.rawValue,
                        host: Hosts.fmp.rawValue,
                        path:profilePath,
                        queryItemFirst: QueriesNames.apiKey.rawValue,
                        userInput: ApiKeys.fmpApiKey)
                
                print(results ?? "")
                
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}
