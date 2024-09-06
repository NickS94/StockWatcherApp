//
//  KeyRatiosTable.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 06.09.24.
//

import SwiftUI

struct KeyRatiosTable: View {
    let tickerQuote:TickerQuote
    let dividend:Double
    let beta:Double
    @ObservedObject var homeViewModel:HomeViewModel
    
    
    var body: some View {
        VStack(alignment:.leading,spacing: 10){
            Text("Key Ratios")
                .font(.title2.bold())
                .padding(.bottom)
            
            ForEach(homeViewModel.generateTickerKeyRatios(ticker: tickerQuote, divident: dividend,beta: beta),id: \.0){ label , value in
                HStack{
                    Text(label)
                        .monospacedStyle(size: 12, weight: .regular)
                        .foregroundStyle(.gray)
                    Spacer()
                    Text("\(NumberFormatterToString.formattedNumber(number:Int(value)))")
                        .monospacedStyle(size: 16, weight: .regular)
                    
                }
            }
        }
    }
}


#Preview {
    KeyRatiosTable(tickerQuote: TickerQuote(
        symbol: "AAPL",
        name: "Apple Inc.",
        price: 229.30,
        changesPercentage: 0.0783,
        change: 0.18,
        dayLow: 199.5,
        dayHigh: 285.3,
        yearHigh: 237.23,
        yearLow: 164.08,
        marketCap: 3496486877000,
        priceAvg50: 221.2112,
        priceAvg200: 193.88576,
        exchange: "NASDAQ",
        eps: 6.57,
        pe: 35,
        sharesOutstanding: 15204100000
    ),dividend: 2,beta: 6 , homeViewModel: HomeViewModel(repository: MockRepository()))
}
