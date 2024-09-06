//
//  ContentView.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 26.08.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var hotListsViewModel = HotTickersViewModel(repository: MockRepository())
    @StateObject var newsViewModel = NewsViewModel(repository: MockRepository())
    @StateObject var tickerProfileViewModel = TickerProfileViewModel(repository: MainRepository())
    @StateObject var homeViewModel = HomeViewModel(repository: MainRepository())
    var body: some View {
        TabsView(hotListsViewModel: hotListsViewModel, newsViewModel: newsViewModel, tickerProfileViewModel: tickerProfileViewModel, homeViewModel: homeViewModel)
    }
}


#Preview {
    ContentView()
}

