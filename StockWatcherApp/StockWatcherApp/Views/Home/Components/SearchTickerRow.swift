//
//  SearchTickerRow.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 11.09.24.
//

import SwiftUI

struct SearchTickerRow: View {
    let tickerSearch:TickerSearch
    @ObservedObject var homeViewModel:HomeViewModel
    var body: some View {
        HStack{
            VStack(alignment:.leading,spacing: 10){
                Text(tickerSearch.symbol)
                    .roundedStyle(size: 16, weight: .semibold)
                Text("\(tickerSearch.name) \(tickerSearch.exchangeShortName?.uppercased() ?? "")")
                    .roundedStyle(size: 14, weight: .light)
            }
            Spacer()
            
            if !homeViewModel.checkList(tickerSymbol: tickerSearch.symbol) {
                Image(systemName: "plus.circle.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color.accentColor,Color.secondary.opacity(0.5))
                    .imageScale(.large)
                    .onTapGesture {
                        homeViewModel.addToWatchlist(ticker: tickerSearch.symbol)
                    }
            }else{
                Image(systemName: "checkmark.circle.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color.white,Color.accentColor)
                    .imageScale(.large)
                    .onTapGesture {
                        homeViewModel.deleteFromWatchlist(ticker: tickerSearch.symbol)
                    }
            }
            
        }
        .onAppear{
            homeViewModel.fetchWatchListFromDatabase()
        }
        .padding()
        
    }
}

#Preview {
    SearchTickerRow(tickerSearch: TickerSearch(symbol: "AAPL", name: "Apple Inc.", exchangeShortName: "Nasdaq"), homeViewModel: HomeViewModel(repository: MockRepository()))
}
