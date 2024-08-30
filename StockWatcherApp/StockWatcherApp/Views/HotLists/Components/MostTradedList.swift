//
//  MostTradedList.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 29.08.24.
//

import SwiftUI

struct MostTradedList: View {
    let mostTradedList:[TickerQuoteAv]
    var body: some View {
        Text("Most Traded")
            .monospacedStyle(size: 22, weight: .bold)
        List{
            ForEach(mostTradedList,id:\.ticker){ ticker in
               
                    TickerAvQuoteRow(tickerQuoteAv: ticker)
                }
            
        }
        .listStyle(.inset)
    }
}

#Preview {
    MostTradedList(mostTradedList: [])
}
