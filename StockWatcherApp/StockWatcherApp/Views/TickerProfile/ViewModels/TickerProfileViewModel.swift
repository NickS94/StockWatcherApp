//
//  TickerProfileViewModel.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 03.09.24.
//

import Foundation

@MainActor
class TickerProfileViewModel:ObservableObject{
    //MARK: Properties
    
    @Published var tickerProfile:TickerProfile = TickerProfile(
        symbol: "",
        price: 0,
        beta: 0,
        volAvg: 0,
        lastDiv: 0,
        range: "",
        changes: 0,
        companyName: "",
        currency: "",
        cik: "",
        isin: "",
        cusip: "",
        exchange: "",
        exchangeShortName: "",
        industry: "",
        website: "",
        description: "",
        ceo: "",
        sector: "",
        country: "",
        fullTimeEmployees: "",
        phone: "",
        address: "",
        city: "",
        state: "",
        zip: "",
        dcfDiff: 0,
        dcf: 0,
        image: "",
        ipoDate: "")
        
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
                    let filteredResults = result.filter{
                        $0.symbol == tickerInput
                    }
                    if let resultFilter = filteredResults.first{
                        tickerProfile = resultFilter
                    }
                }
            }catch{
                print(error)
            }
        }
    }
    
    /**
     Use this method to create an array from tuples to use it for the table in the details view to show the general information of the company.
     */
    func generateInformationTable(tickerProfile:TickerProfile)->[(String,String)]{
        
        var resultArray :[(String,String)] = []
        
        resultArray.append(("CEO", tickerProfile.ceo ?? ""))
        resultArray.append(("EXCHANGE", tickerProfile.exchangeShortName ?? ""))
        resultArray.append(("EMPLOYEES", tickerProfile.fullTimeEmployees ?? ""))
        resultArray.append(("COUNTRY", tickerProfile.country ?? ""))
        resultArray.append(("ADDRESS", tickerProfile.address ?? ""))
        resultArray.append(("CITY", tickerProfile.city ?? ""))
        resultArray.append(("STATE", tickerProfile.state ?? ""))
        resultArray.append(("ZIP CODE", tickerProfile.zip ?? ""))
        resultArray.append(("PHONE", tickerProfile.phone ?? ""))
        resultArray.append(("IPO DATE", tickerProfile.ipoDate ?? ""))
        
       return resultArray
    }
    
}
