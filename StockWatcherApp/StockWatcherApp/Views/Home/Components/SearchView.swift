//
//  SearchView.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 11.09.24.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var homeViewModel:HomeViewModel
    @Binding var showSearchSheet:Bool
    var body: some View {
        NavigationStack {
            VStack{
                List {
                    ForEach(homeViewModel.searchList, id:\.symbol){ticker in
                        SearchTickerRow(tickerSearch: ticker, homeViewModel: homeViewModel)
                    }
                }
                .listStyle(.inset)
            }
            .searchable(text: $homeViewModel.userSearchInput, prompt: "Search Ticker")
            .toolbar{
                ToolbarItem {
                    Button("Done") {
                        showSearchSheet = false
                    }
                }
            }
        }
        .onChange(of: homeViewModel.userSearchInput) {
            homeViewModel.fetchSearchList()
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
    SearchView(homeViewModel: HomeViewModel(repository: MockRepository()), showSearchSheet: .constant(false))
}
