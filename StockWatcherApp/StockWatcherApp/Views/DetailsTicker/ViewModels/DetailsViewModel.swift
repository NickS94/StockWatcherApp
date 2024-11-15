//
//  DetailsViewModel.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 06.09.24.
//

import Foundation

@MainActor
class DetailsViewModel:ObservableObject{
    
    //MARK: Properties
    
    @Published var tickerQuote = TickerQuote(
        symbol: "",
        name: "",
        price: 0,
        changesPercentage: 0,
        change: 0,
        dayLow: 0,
        dayHigh: 0,
        yearHigh: 0,
        yearLow: 0,
        marketCap: 0,
        priceAvg50: 0,
        priceAvg200: 0,
        exchange: "",
        previousClose: 0,
        eps: 0,
        pe: 0,
        sharesOutstanding: 0
    )
    
    @Published var chartTimestampsList:[ChartQuote] = []
    
    @Published var chartRange:ChartTimeframes = .fiveMinutes
    
    @Published var fromDate = Date.now
    @Published var toDate = Date.now
    
    let repository:RepositoryProtocol
    
    init( repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    //MARK: Methods
    
    func getTickerQuote(tickerSymbol:String){
        Task{
            do{
                let temporaryList = [tickerSymbol]
                let results = try await repository.fetchQuoteList(temporaryList)
                
                if let results = results{
                    
                    if let ticker = results.first{
                        tickerQuote = ticker
                    }
                }
            }catch{
                print(error)
            }
        }
    }
    
    func generateTickerKeyRatios(divident:Double,beta:Double)->[(String,Double)]{
        
        var resultList:[(String,Double)] = []
        
        resultList.append(("MARKET CAP", Double(tickerQuote.marketCap ?? 0)))
        resultList.append(("EPS", tickerQuote.eps ?? 0))
        resultList.append(("P/E RATIO", tickerQuote.pe ?? 0))
        resultList.append(("DIVIDEND", divident))
        resultList.append(("BETA", beta))
        resultList.append(("SHARES OUTSTANDING", Double(tickerQuote.sharesOutstanding ?? 0)))
        
        return resultList
    }
    
    
    func fetchTickerChart(tickerSymbol:String){
        Task{
            do{
                let results = try await repository.fetchChart(chartRange.rawValue, tickerSymbol, fromDate.ISO8601Format(),toDate.ISO8601Format() )
                
                if let results = results{
                
                    chartTimestampsList = results
                }
            }catch{
                print(error)
            }
        }
    }
    
    
    func priceMapping()->[Double]{
        return chartTimestampsList.compactMap{ $0.close }
    }
    
    func dateMapping()->[Date]{
        return chartTimestampsList.compactMap{$0.date.toDate}
    }
}

