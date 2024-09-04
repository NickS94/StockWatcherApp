//
//  TickerDetailsView.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 04.09.24.
//

import SwiftUI

struct TickerDetailsView: View {
    
    //This view is created like this only for testing because i had some problems with the information table i wanted to implement.
    @ObservedObject var tickerProfileViewModel : TickerProfileViewModel
    @ObservedObject var homeViewModel : HomeViewModel
    @State var showFullDescription = false
    @State var lineLimit = 6
    let tickerSymbol:String
    
    var body: some View {
        ScrollView{
            ProfileHeaderItems(tickerQuote: homeViewModel.tickerQuote)
            
            CompanyProfileView(tickerProfileViewModel: tickerProfileViewModel, showFullDescription: $showFullDescription, lineLimit: $lineLimit)
        }
        .onAppear{
            tickerProfileViewModel.fetchTickerProfile(tickerSymbol)
            homeViewModel.fetchFmpTickersList(tickerSymbol: tickerSymbol)
        }
    }
}

#Preview {
    TickerDetailsView(tickerProfileViewModel: TickerProfileViewModel(repository: MockRepository()), homeViewModel: HomeViewModel(repository: MockRepository()), tickerSymbol: "")
}
