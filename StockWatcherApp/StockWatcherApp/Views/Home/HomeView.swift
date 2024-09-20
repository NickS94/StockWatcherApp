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
    @Binding var showSearchSheet:Bool
    
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
                    MyList(myTickersList: homeViewModel.myTickersList, tickerProfileViewModel: tickerProfileViewModel, detailsViewModel: detailsViewModel, newsViewModel: newsViewModel, showSearchSheet: $showSearchSheet)
                }
                .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .sheet(isPresented: $showSearchSheet){
            SearchView(homeViewModel: homeViewModel, showSearchSheet: $showSearchSheet)
        }
        .onAppear{
            homeViewModel.fetchFmpTickersList()
            
        }
    }
}

#Preview {
    HomeView(homeViewModel: HomeViewModel(repository: MockRepository()), tickerProfileViewModel: TickerProfileViewModel(repository: MockRepository()), detailsViewModel: DetailsViewModel(repository: MockRepository()), newsViewModel: NewsViewModel(repository: MockRepository()),showSearchSheet: .constant(false))
}
