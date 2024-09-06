//
//  TickerDetailsView.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 04.09.24.
//

import SwiftUI

struct TickerDetailsView: View {
    
    @ObservedObject var tickerProfileViewModel : TickerProfileViewModel
    @ObservedObject var detailsViewModel : DetailsViewModel
    @State var showFullDescription = false
    @State var lineLimit = 6
    let tickerSymbol:String
    
    var body: some View {
        ScrollView{
            
            ProfileHeaderItems(tickerQuote: detailsViewModel.tickerQuote)
            
            KeyRatiosTable(dividend: tickerProfileViewModel.tickerProfile.lastDiv ?? 0, beta: tickerProfileViewModel.tickerProfile.beta ?? 0, detailsViewModel: detailsViewModel)
            
            PriceRangeTable(tickerQuote: detailsViewModel.tickerQuote)
            
            CompanyProfileView(tickerProfileViewModel: tickerProfileViewModel, showFullDescription: $showFullDescription, lineLimit: $lineLimit)
        }
        .padding()

        .onAppear{
            tickerProfileViewModel.fetchTickerProfile(tickerSymbol)
            detailsViewModel.getTickerQuote(tickerSymbol: tickerSymbol)
        }
    }
}

#Preview {
    TickerDetailsView(tickerProfileViewModel: TickerProfileViewModel(repository: MockRepository()), detailsViewModel: DetailsViewModel(repository: MockRepository()), tickerSymbol: "AAPL")
}
