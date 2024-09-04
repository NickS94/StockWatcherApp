//
//  TickerDetailsView.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 04.09.24.
//

import SwiftUI

struct TickerDetailsView: View {
    
    //This view is created like this only for testing because i had some problems with the information table i wanted to implement.
    @StateObject var tickerProfileViewModel = TickerProfileViewModel(repository: MockRepository())
    let tickerQuote:TickerQuote
    @State var showFullDescription = false
    @State var lineLimit = 6
    let tickerSymbol :String
    var body: some View {
    
        TickerProfileView(tickerProfileViewModel: tickerProfileViewModel, tickerQuote: tickerQuote, showFullDescription: $showFullDescription, lineLimit: $lineLimit, tickerSymbol: tickerSymbol)
    }
}

#Preview {
    TickerDetailsView(tickerQuote: TickerQuote(
        symbol: "AAPL",
        name: "Apple Inc.",
        price: 229.97,
        changesPercentage: 0.0783,
        change: 0.18,
        dayLow: 229.345,
        dayHigh: 230.4,
        yearHigh: 237.23,
        yearLow: 164.08,
        marketCap: 3496486877000,
        priceAvg50: 221.2112,
        priceAvg200: 193.88576,
        exchange: "NASDAQ",
        eps: 6.57,
        pe: 35,
        sharesOutstanding: 15204100000
    ), tickerSymbol: "AAPL")
}
