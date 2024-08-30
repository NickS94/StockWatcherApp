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
    
    private let apiClient = ApiClient.shared
    
    
    //MARK: Methods
    
    
//    func fetchHotTickers (){
//        Task{
//            do{
//                let results:AlphaAvantageResponse? = try await apiClient
//                    .makeRequest(
//                        scheme: Schemas.https.rawValue,
//                        host: Hosts.av.rawValue,
//                        path: Paths.avQuery.urlString,
//                        queryItemFirst: QueriesNames.avQuery.rawValue,
//                        queryItemSecond: QueriesNames.apiKey.rawValue,
//                        userFirstInput: QueryValues.avGainersAndLosers.rawValue,
//                        userSecondInput: ApiKeys.avApiKey
//                    )
//                if let results = results{
//                    
//
//                    gainersList = results.topGainers
//                    losersList = results.topLosers
//                    mostTradedList = results.mostActivelyTraded
//               
//                }
//              
//            }catch{
//                print(error)
//            }
//        }
//    }
    
    
    func fetchMock (){
        Task{
            do{
                let results:AlphaAvantageResponse? = try await apiClient
                    .makeMockRequest(url: MockEndpoints.mockHostHotList.rawValue)
                if let results = results{
                    gainersList = results.topGainers
                    losersList = results.topLosers
                    mostTradedList = results.mostActivelyTraded
               
                }
              
            }catch{
                print(error)
            }
        }
    }
    
}
