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
    @ObservedObject var tickerProfileViewModel:TickerProfileViewModel
    @ObservedObject var detailsViewModel:DetailsViewModel
    @ObservedObject var homeViewModel:HomeViewModel
    @ObservedObject var authenticationViewModel:AuthenticationViewModel
    @State var showSearchSheet = false
    var body: some View {
        TabView{
            HomeView(homeViewModel: homeViewModel, tickerProfileViewModel: tickerProfileViewModel, detailsViewModel: detailsViewModel, newsViewModel: newsViewModel, showSearchSheet: $showSearchSheet)
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                    }
                }
                .onAppear{
                    homeViewModel.fetchFmpTickersList()
                    homeViewModel.fetchWatchListFromDatabase()
                }
            HotListsView(hotListViewModel: hotListsViewModel, tickerProfileViewModel: tickerProfileViewModel, detailsViewModel: detailsViewModel, newsViewModel: newsViewModel)
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
            
            ProfileView(authenticationViewModel: authenticationViewModel)
                .tabItem {
                    VStack{
                        Image(systemName: "person")
                        Text("Profile")
                    }
                }
        }
    }
}

#Preview {
    TabsView(hotListsViewModel: HotTickersViewModel(repository: MockRepository()), newsViewModel: NewsViewModel(repository: MockRepository()), tickerProfileViewModel: TickerProfileViewModel(repository: MockRepository()), detailsViewModel: DetailsViewModel(repository: MockRepository()), homeViewModel: HomeViewModel(repository: MockRepository()), authenticationViewModel: AuthenticationViewModel())
}
