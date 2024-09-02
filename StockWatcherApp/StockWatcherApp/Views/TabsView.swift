//
//  Tabs.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 29.08.24.
//

import SwiftUI

struct TabsView: View {
    @ObservedObject var hotListsViewModel:HotTickersViewModel
    @ObservedObject var newsViewModel:NewsViewModel
    var body: some View {
        TabView{
            HotListsView(hotListViewModel: hotListsViewModel)
                .tabItem {
                    VStack {
                        Image(systemName: "flame")
                        Text("Hot")
                    }
                }
            
            NewsListView(newsViewModel: newsViewModel, ticker: "")
                .tabItem {
                    VStack {
                        Image(systemName: "newspaper")
                        Text("News")
                    }
                }
        }
    }
}

#Preview {
    TabsView(hotListsViewModel: HotTickersViewModel(repository: MockRepository()), newsViewModel: NewsViewModel(repository: MockRepository()))
}
