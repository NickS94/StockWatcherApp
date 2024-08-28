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
    
    /**
     Use this method to call the ticker PROFILE data from API
     */
//    func fetchTickerProfile(){
//        Task{
//            do{
//                let profilePath = Paths.fmpProfile(ticker: profileInput).urlString
//                
//                print (profilePath)
//                
//                let results:[TickerProfile]? = try await apiClient
//                    .makeRequest(
//                        scheme: Schemas.https.rawValue,
//                        host: Hosts.fmp.rawValue,
//                        path:profilePath,
//                        queryItemFirst: QueriesNames.apiKey.rawValue,
//                        userFirstInput: ApiKeys.fmpApiKey)
//                
//                print(results ?? "")
//                
//            }catch{
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    /**
     Use this method to call the ticker SEARCH results from API
     */
    func fetchSearchTickers(){
        Task{
            do{
                let results:[TickerSearch]? = try await apiClient
                    .makeRequest(
                        scheme: Schemas.https.rawValue,
                        host: Hosts.fmp.rawValue,
                        path: Paths.fmpSearchTicker.urlString,
                        queryItemFirst: QueriesNames.fmpSearch.rawValue,
                        queryItemSecond: QueriesNames.fmpLimit.rawValue,
                        queryItemThird: QueriesNames.fmpExchange.rawValue,
                        queryItemFourth: QueriesNames.apiKey.rawValue,
                        userFirstInput: "a",
                        userSecondInput: "",
                        userThirdInput: "AMEX",
                        userFourthInput: ApiKeys.fmpApiKey)
                
                
                print(results ?? "")
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    /**
     Use this method to call tha Butch ticker quote list so you can create your watchlist just 
     */
    func fetchMyTickerList(){
        Task{
            do{
                
                let quotePath = Paths.fmpQuote(tickersList: ["AAPL","TSLA","META"])
                
                let results:[TickerQuote]? = try await apiClient
                    .makeRequest(
                        scheme: Schemas.https.rawValue,
                        host: Hosts.fmp.rawValue, 
                        path:quotePath.urlString,
                        queryItemFirst: QueriesNames.apiKey.rawValue,
                        userFirstInput: ApiKeys.fmpApiKey)
                
                print(results ?? "")
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}
