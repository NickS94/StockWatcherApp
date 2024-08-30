//
//  GainersList.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 29.08.24.
//

import SwiftUI

struct GainersList: View {
    let gainersList:[TickerQuoteAv]
    var body: some View {
        Text("Gainers")
            .monospacedStyle(size: 22, weight: .bold)
        List{
            ForEach(gainersList,id:\.ticker){ ticker in
                
                TickerAvQuoteRow(tickerQuoteAv: ticker)
                
            }
        }
        .listStyle(.inset)
    }
}

#Preview {
    GainersList(gainersList: [])
}
