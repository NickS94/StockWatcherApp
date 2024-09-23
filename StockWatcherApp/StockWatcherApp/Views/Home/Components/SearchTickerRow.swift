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
                    .monospacedStyle(size: 16, weight: .semibold)
                Text("\(tickerSearch.name) \(tickerSearch.exchangeShortName?.uppercased() ?? "")")
                    .monospacedStyle(size: 14, weight: .light)
            }
            Spacer()
            
            if true {
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
        .padding()
        
    }
}

#Preview {
    SearchTickerRow(tickerSearch: TickerSearch(symbol: "AAPL", name: "Apple Inc.", exchangeShortName: "Nasdaq"), homeViewModel: HomeViewModel(repository: MockRepository()))
}
