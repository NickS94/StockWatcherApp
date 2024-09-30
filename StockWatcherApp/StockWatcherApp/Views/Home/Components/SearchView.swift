//
//  SearchView.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 11.09.24.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var homeViewModel:HomeViewModel
    @ObservedObject var tickerProfileViewModel:TickerProfileViewModel
    @ObservedObject var detailsViewModel:DetailsViewModel
    @ObservedObject var newsViewModel:NewsViewModel
    @Binding var showSearchSheet:Bool
    var body: some View {
        
        NavigationStack {
            VStack{
                HStack{
                    TextField("Search Ticker", text:$homeViewModel.userSearchInput )
                        .padding(9)
                        .background(.gray.opacity(0.4))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .textInputAutocapitalization(.never)
                    Button{
                        homeViewModel.userSearchInput = ""
                        showSearchSheet = false
                    }label: {
                        Text(homeViewModel.userSearchInput.isEmpty ? "Cancel" : "Done")
                    }
                   
                }
                .padding(20)
                List {
                    ForEach(homeViewModel.searchList, id:\.symbol){ticker in
                        NavigationLink {
                            TickerDetailsView(tickerProfileViewModel: tickerProfileViewModel, detailsViewModel: detailsViewModel, newsViewModel: newsViewModel, homeViewModel: homeViewModel, tickerSymbol: ticker.symbol)
                        } label: {
                            SearchTickerRow(tickerSearch: ticker, homeViewModel: homeViewModel)
                        }
                    }
                }
                .listStyle(.inset)
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear{
            homeViewModel.fetchWatchListFromDatabase()
        }
        .onChange(of: homeViewModel.userSearchInput) {
            homeViewModel.fetchSearchList()
        }
        .onChange(of: homeViewModel.tickerListInput) {
            homeViewModel.fetchWatchListFromDatabase()
        }
        .onDisappear {
            homeViewModel.fetchWatchListFromDatabase()
            homeViewModel.fetchFmpTickersList()
        }
        .overlay {
            if homeViewModel.userSearchInput.isEmpty,homeViewModel.searchList.isEmpty{
                ContentUnavailableView.init("Type something to search", systemImage: "magnifyingglass")
                
            }else if !homeViewModel.userSearchInput.isEmpty,homeViewModel.searchList.isEmpty{
                ContentUnavailableView.search
            }
        }
    }
}

#Preview {
    SearchView(homeViewModel: HomeViewModel(repository: MockRepository()),tickerProfileViewModel: TickerProfileViewModel(repository: MockRepository()),detailsViewModel: DetailsViewModel(repository: MockRepository()),newsViewModel: NewsViewModel(repository: MockRepository()), showSearchSheet: .constant(false))
}
