//
//  ContentView.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 26.08.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var hotListsViewModel = HotTickersViewModel(repository: MainRepository())
    @StateObject var newsViewModel = NewsViewModel(repository: MainRepository())
    var body: some View {
        TabsView(hotListsViewModel: hotListsViewModel, newsViewModel: newsViewModel)
    }
}

#Preview {
    ContentView()
}

