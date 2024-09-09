//
//  GainersList.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 29.08.24.
//

import SwiftUI

struct HotListComponent: View {
    @ObservedObject var tickerProfileViewModel:TickerProfileViewModel
    @ObservedObject var detailsViewModel:DetailsViewModel
    @ObservedObject var newsViewModel:NewsViewModel
    let hotList:[TickerQuoteAv]
    var body: some View {
        List{
            ForEach(hotList,id:\.ticker){ ticker in
                NavigationLink {
                    TickerDetailsView( tickerProfileViewModel: tickerProfileViewModel, detailsViewModel:detailsViewModel, newsViewModel: newsViewModel ,tickerSymbol: ticker.ticker)
                } label: {
                    TickerAvQuoteRow(tickerQuoteAv: ticker)
                }
            }
        }
        .listStyle(.inset)
    }
}

#Preview {
    HotListComponent(tickerProfileViewModel: TickerProfileViewModel(repository: MockRepository()), detailsViewModel: DetailsViewModel(repository: MockRepository()), newsViewModel: NewsViewModel(repository: MockRepository()), hotList: [TickerQuoteAv(ticker: "AAPL", price: "23", changeAmount: "12", changePercentage: "3423", volume: "123"),TickerQuoteAv(ticker: "AAPL", price: "23", changeAmount: "12", changePercentage: "3423", volume: "123"),TickerQuoteAv(ticker: "AAPL", price: "23", changeAmount: "12", changePercentage: "3423", volume: "123")])
}
