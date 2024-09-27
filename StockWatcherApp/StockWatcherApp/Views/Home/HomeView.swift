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
                    MyList(myTickersList: homeViewModel.myTickersList, tickerProfileViewModel: tickerProfileViewModel, detailsViewModel: detailsViewModel, newsViewModel: newsViewModel, homeViewModel: homeViewModel, showSearchSheet: $showSearchSheet)
                    
                    SociaFeedList(socialFeedViewModel: socialFeedViewModel, showNewPostSheet: $showNewPostSheet)
                    
                }
                .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .sheet(isPresented: $showSearchSheet){
            SearchView(homeViewModel: homeViewModel, tickerProfileViewModel: tickerProfileViewModel, detailsViewModel: detailsViewModel, newsViewModel: newsViewModel, showSearchSheet: $showSearchSheet)
        }
        .onChange(of: homeViewModel.tickerListInput) {
            homeViewModel.fetchFmpTickersList()
        }
        .task{
            homeViewModel.fetchFmpTickersList()
            socialFeedViewModel.fetchSocialChats()
            homeViewModel.fetchWatchListFromDatabase()
            await socialFeedViewModel.fetchPostInteractions()
        }
        .sheet(isPresented: $showNewPostSheet) {
            NewPostSheet(showNewPostSheet: $showNewPostSheet, socialFeedViewModel: socialFeedViewModel)
        }
    }
}

#Preview {
    HomeView(homeViewModel: HomeViewModel(repository: MockRepository()), tickerProfileViewModel: TickerProfileViewModel(repository: MockRepository()), detailsViewModel: DetailsViewModel(repository: MockRepository()), newsViewModel: NewsViewModel(repository: MockRepository()))
}
