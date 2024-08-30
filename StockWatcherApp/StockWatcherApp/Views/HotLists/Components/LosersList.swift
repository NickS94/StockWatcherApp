//
//  LosersList.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 29.08.24.
//

import SwiftUI

struct LosersList: View {
    let losersList:[TickerQuoteAv]
    var body: some View {
        Text("Losers")
            .monospacedStyle(size: 22, weight: .bold)

        List{
            ForEach(losersList,id:\.ticker){ ticker in
                
                    TickerAvQuoteRow(tickerQuoteAv: ticker)
                }
            
        }
        .listStyle(.inset)
        
    }
}

#Preview {
    LosersList(losersList: [TickerQuoteAv(ticker: "AAPL", price: "23", changeAmount: "12", changePercentage: "3423", volume: "123")])
}
