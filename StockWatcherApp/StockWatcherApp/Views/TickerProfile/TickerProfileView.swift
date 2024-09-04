//
//  TickerProfileView.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 03.09.24.
//

import SwiftUI

struct TickerProfileView: View {
    @ObservedObject var tickerProfileViewModel : TickerProfileViewModel
    let tickerQuote:TickerQuote
    @Binding var showFullDescription :Bool
    @Binding var lineLimit :Int
    let tickerSymbol:String
    var body: some View {
        ScrollView {
            VStack(alignment:.leading){
                ProfileHeaderItems( tickerQuote: tickerQuote)
                // this will going to be the chart.!
                Rectangle()
                
                GeneralInformation(tickerProfile: tickerProfileViewModel.tickerProfile , tickerProfileViewModel: tickerProfileViewModel, showFullDescription: $showFullDescription, lineLimit: $lineLimit)
            }
        }
        .onAppear{
            tickerProfileViewModel.fetchTickerProfile(tickerSymbol)
        }
    }
}

#Preview {
    TickerProfileView(tickerProfileViewModel: TickerProfileViewModel(repository: MainRepository()), tickerQuote: TickerQuote(
        
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
    ),showFullDescription: .constant(false),lineLimit: .constant(6), tickerSymbol: "")
}
