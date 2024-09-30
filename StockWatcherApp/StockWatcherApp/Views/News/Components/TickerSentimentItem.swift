//
//  TickerSentimentItem.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 02.09.24.
//

import SwiftUI

struct TickerSentimentItem: View {
    let tickerSentiment:TickerSentiment
    let size:CGFloat
 
    var body: some View {
        VStack{
            Text(tickerSentiment.ticker)
                .roundedStyle(size: size, weight: .regular)
                .padding(4)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 2)
                .foregroundStyle(.gray)
        }
        .padding(5)
    }
}


#Preview {
    TickerSentimentItem(tickerSentiment: TickerSentiment(ticker: "AAPL"), size: 9)
}
