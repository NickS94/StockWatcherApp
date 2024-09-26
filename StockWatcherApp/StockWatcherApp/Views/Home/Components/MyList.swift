//
//  MyList.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 11.09.24.
//

import SwiftUI

struct MyList: View {
    let myTickersList:[TickerQuote]
    @ObservedObject var tickerProfileViewModel:TickerProfileViewModel
    @ObservedObject var detailsViewModel:DetailsViewModel
    @ObservedObject var newsViewModel:NewsViewModel
    @ObservedObject var homeViewModel:HomeViewModel
    @Binding var showSearchSheet:Bool
    
    var body: some View {
        VStack(alignment:.leading){
            HStack{
                Text("My Watchlist")
                    .monospacedStyle(size: 22, weight: .bold)
                Spacer()
                Button{
                    showSearchSheet = true
                }label: {
                    Image(systemName: "plus")
                        .font(.title.bold())
                        .padding(5)
                        .background(.gray.opacity(0.6))
                        .clipShape(Circle())
                }
            }
            if myTickersList.isEmpty{
                Text("Your list is empty Add Symbol")
                    .monospacedStyle(size: 16, weight: .semibold)
                    .foregroundStyle(.mainApp)
            }else{
                ForEach(myTickersList,id:\.symbol) { ticker in
                    NavigationLink {
                        TickerDetailsView(tickerProfileViewModel: tickerProfileViewModel, detailsViewModel: detailsViewModel, newsViewModel: newsViewModel, homeViewModel: homeViewModel, tickerSymbol: ticker.symbol ?? "")
                    } label: {
                        TickerQuoteRow(tickerQuote: ticker)
                            .padding(8)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

#Preview {
    MyList(myTickersList: [],tickerProfileViewModel: TickerProfileViewModel(repository: MockRepository()),detailsViewModel: DetailsViewModel(repository: MockRepository()),newsViewModel: NewsViewModel(repository: MockRepository()), homeViewModel: HomeViewModel(repository: MockRepository()), showSearchSheet: .constant(false))
}
