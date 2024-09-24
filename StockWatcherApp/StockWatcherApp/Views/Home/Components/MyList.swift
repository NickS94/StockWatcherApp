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
            Text("My Watchlist")
                .monospacedStyle(size: 22, weight: .bold)
            VStack{
                if myTickersList.isEmpty{
                    Button{
                        showSearchSheet = true
                    }label: {
                        VStack(spacing:10){
                            Text("Your list is empty Add Symbol")
                                .foregroundStyle(.mainApp)
                            Image(systemName: "plus")
                        }
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 0.2)
                                .opacity(0.2)
                        }
                        .frame(width: 150,height: 150)
                    }
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
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    MyList(myTickersList: [],tickerProfileViewModel: TickerProfileViewModel(repository: MockRepository()),detailsViewModel: DetailsViewModel(repository: MockRepository()),newsViewModel: NewsViewModel(repository: MockRepository()), homeViewModel: HomeViewModel(repository: MockRepository()), showSearchSheet: .constant(false))
}
