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
    @StateObject var tickerProfileViewModel = TickerProfileViewModel(repository: MockRepository())
    @StateObject var detailsViewModel = DetailsViewModel(repository: MockRepository())
    @StateObject var homeViewModel = HomeViewModel(repository: MockRepository())
    @ObservedObject var authenticationViewModel : AuthenticationViewModel
    
    var body: some View {
        TabsView(hotListsViewModel: hotListsViewModel, newsViewModel: newsViewModel, tickerProfileViewModel: tickerProfileViewModel, detailsViewModel: detailsViewModel, authenticationViewModel: authenticationViewModel, homeViewModel: homeViewModel)
    }
}
#Preview {
    ContentView( authenticationViewModel: AuthenticationViewModel())
}

