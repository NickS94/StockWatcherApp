//
//  MyListView.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 28.08.24.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var homeViewModel: HomeViewModel
    @ObservedObject var tickerProfileViewModel:TickerProfileViewModel
    @ObservedObject var detailsViewModel:DetailsViewModel
    @ObservedObject var newsViewModel:NewsViewModel
    @StateObject var socialFeedViewModel = SocialFeedViewModel()
    @State var showSearchSheet = false
    @State var showNewPostSheet = false
    @State var showAddToWatchlistSheet = false
    
    var body: some View {
        NavigationStack{
            VStack{
                Button {
                    showSearchSheet = true
                } label: {
                    HStack{
                        Text("Search")
                        Image(systemName: "magnifyingglass")
                    }
                    .foregroundStyle(.mainApp)
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.mainApp).opacity(0.3)
                .padding()
                ScrollView{
                    MyList(myTickersList: homeViewModel.myTickersList, tickerProfileViewModel: tickerProfileViewModel, detailsViewModel: detailsViewModel, newsViewModel: newsViewModel, homeViewModel: homeViewModel, showAddToWatchlistSheet:$showAddToWatchlistSheet)
                    SociaFeedList(socialFeedViewModel: socialFeedViewModel, showNewPostSheet: $showNewPostSheet)
                }
                .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.inline)
                .scrollIndicators(.hidden)
            }
        }
        .sheet(isPresented: $showSearchSheet){
            SearchView(homeViewModel: homeViewModel, tickerProfileViewModel: tickerProfileViewModel, detailsViewModel: detailsViewModel, newsViewModel: newsViewModel, showSearchSheet: $showSearchSheet)
        }
        .sheet(isPresented: $showNewPostSheet) {
            NewPostSheet(showNewPostSheet: $showNewPostSheet, socialFeedViewModel: socialFeedViewModel)
        }
        .sheet(isPresented: $showAddToWatchlistSheet) {
            AddNewSymbolView(homeViewModel: homeViewModel, tickerProfileViewModel: tickerProfileViewModel, detailsViewModel: detailsViewModel, newsViewModel: newsViewModel, showAddToWatchlistView: $showAddToWatchlistSheet)
        }
        .onChange(of: homeViewModel.tickerListInput) {
            homeViewModel.fetchFmpTickersList()
        }
        .onAppear{
            homeViewModel.fetchFireusers()
            homeViewModel.fetchFmpTickersList()
            socialFeedViewModel.fetchSocialChats()
            homeViewModel.fetchWatchListFromDatabase()
            homeViewModel.fetchFmpTickersList()
            socialFeedViewModel.fetchPostInteractions()
        }
        .padding(10)
    }
}

#Preview {
    HomeView(homeViewModel: HomeViewModel(repository: MockRepository()), tickerProfileViewModel: TickerProfileViewModel(repository: MockRepository()), detailsViewModel: DetailsViewModel(repository: MockRepository()), newsViewModel: NewsViewModel(repository: MockRepository()))
}
