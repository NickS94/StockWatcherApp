//
//  FavoriteButton.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 23.09.24.
//

import SwiftUI

struct FavoriteButton: View {
    @ObservedObject var homeViewModel:HomeViewModel
    let tickerSymbol:String
    var body: some View {
        Button {
            if homeViewModel.checkList(tickerSymbol: tickerSymbol){
                homeViewModel.deleteFromWatchlist(ticker: tickerSymbol)
            }else{
                homeViewModel.addToWatchlist(ticker: tickerSymbol)
            }
        } label: {
            if !homeViewModel.checkList(tickerSymbol: tickerSymbol){
                Image(systemName: "star")
                    .resizable()
                    .frame(width: 40,height: 40)
                    .foregroundStyle(.yellow)
            }else{
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 48,height: 48)
                    .foregroundStyle(.yellow)
            }
        }
    }
}

#Preview {
    FavoriteButton(homeViewModel: HomeViewModel(repository: MockRepository()), tickerSymbol: "AAPL")
}
