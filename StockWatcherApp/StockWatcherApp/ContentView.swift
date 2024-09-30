//
//  ContentView.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 26.08.24.
//

import SwiftUI
// In ContentView are all the views packed with the MainRepository so i will have real data only when i start the App.
struct ContentView: View {
    
    @StateObject var hotListsViewModel = HotTickersViewModel(repository: MainRepository())
    @StateObject var newsViewModel = NewsViewModel(repository: MainRepository())
    @StateObject var tickerProfileViewModel = TickerProfileViewModel(repository: MainRepository())
    @StateObject var detailsViewModel = DetailsViewModel(repository: MainRepository())
    @StateObject var homeViewModel = HomeViewModel(repository: MainRepository())
    @ObservedObject var authenticationViewModel : AuthenticationViewModel
    
    var body: some View {
        
        TabsView(hotListsViewModel: hotListsViewModel, newsViewModel: newsViewModel, tickerProfileViewModel: tickerProfileViewModel, detailsViewModel: detailsViewModel, authenticationViewModel: authenticationViewModel, homeViewModel: homeViewModel)
    }
}
#Preview {
    ContentView( authenticationViewModel: AuthenticationViewModel())
}

