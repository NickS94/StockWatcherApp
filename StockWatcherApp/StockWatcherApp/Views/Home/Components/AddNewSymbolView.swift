//
//  AddNewSymbolView.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 30.09.24.
//

import SwiftUI

struct AddNewSymbolView: View {
    @ObservedObject var homeViewModel:HomeViewModel
    @ObservedObject var tickerProfileViewModel:TickerProfileViewModel
    @ObservedObject var detailsViewModel:DetailsViewModel
    @ObservedObject var newsViewModel:NewsViewModel
    @Binding var showAddToWatchlistView:Bool
    var body: some View {
        NavigationStack{
            VStack(spacing: 30){
                TextField("Search symbol here...", text: $homeViewModel.userSearchInput)
                    .padding(8)
                    .background(.gray.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(lineWidth: 1)
                    }
                    .padding(.vertical)
                
                Picker("Select Stock Exchange", selection: $homeViewModel.exchangeInput) {
                    ForEach(StockExchange.allCases, id: \.self) { exchange in
                        Text(exchange.rawValue).tag(exchange)
                            .font(.title2)
                            .foregroundStyle(.mainApp)
                    }
                }
                .pickerStyle(.navigationLink)
                
                Button{
                    homeViewModel.fetchSearchList(userExchangeInput: homeViewModel.exchangeInput.rawValue)
                }label:{
                    Text("Search")
                        .font(.title2)
                        .foregroundStyle(.mainApp)
                }
                .frame(width: 200,height: 55)
                .background(.gray.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                
                List {
                    ForEach(homeViewModel.searchList,id:\.symbol){ ticker in
                        NavigationLink {
                            TickerDetailsView(tickerProfileViewModel: tickerProfileViewModel, detailsViewModel: detailsViewModel, newsViewModel: newsViewModel, homeViewModel: homeViewModel, tickerSymbol: ticker.symbol)
                        } label: {
                            SearchTickerRow(tickerSearch: ticker, homeViewModel: homeViewModel)
                        }
                    }
                }
                .listStyle(.inset)
            }
            .padding(20)
            .toolbar{
                ToolbarItem {
                    Button {
                     showAddToWatchlistView = false
                    } label: {
                     Image(systemName: "xmark")
                            .font(.title2.bold())
                            .tint(.mainApp)
                    }
                }
            }
            .navigationTitle("Add To Watchlist")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddNewSymbolView(homeViewModel: HomeViewModel(repository: MockRepository()), tickerProfileViewModel: TickerProfileViewModel(repository: MockRepository()), detailsViewModel: DetailsViewModel(repository: MockRepository()), newsViewModel: NewsViewModel(repository: MockRepository()), showAddToWatchlistView: .constant(false))
}
