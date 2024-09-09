//
//  GainersList.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 29.08.24.
//

import SwiftUI

struct HotListsView: View {
    @ObservedObject var hotListViewModel:HotTickersViewModel
    @ObservedObject var tickerProfileViewModel:TickerProfileViewModel
    @ObservedObject var detailsViewModel:DetailsViewModel
    @ObservedObject var newsViewModel:NewsViewModel
    var body: some View {
        
        NavigationStack{
            // Picker to change the hotList value when the listSelection variable changes value.
            Picker("List Selection", selection: $hotListViewModel.listSelection) {
                ForEach(HotListsPickerItems.allCases,id:\.rawValue){listItem in
                    Text(listItem.rawValue).tag(listItem)
                }
            }
            .pickerStyle(.segmented)
            .padding()
    
            VStack(alignment:.leading){
                // Set the header text depending on the rawValue of the listSelection.
                Text(hotListViewModel.listSelection.rawValue)
                    .monospacedStyle(size: 22, weight: .bold)
                // Used one list component and set the hotList from view model inside,
                //so the outcome is what the hotList have as a value.
                HotListComponent(tickerProfileViewModel: tickerProfileViewModel, detailsViewModel: detailsViewModel, newsViewModel: newsViewModel, hotList: hotListViewModel.hotList)
            }
            .onAppear{
                // on appear of this view we load the list that is set as default . In this case is the most traded tickers.
                hotListViewModel.getHotLists()
            }
            .onChange(of: hotListViewModel.listSelection){
                // on change of listSelection value we load again the lists to set the new values of the hotList in our view.
                hotListViewModel.getHotLists()
            }
            .navigationTitle("Todays Hot")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
            
        }
    }
}

#Preview {
    // Using mock repository in our view so we are efficient with our API calls and not overloading the server for no reason .
    HotListsView(hotListViewModel: HotTickersViewModel(repository: MockRepository()), tickerProfileViewModel: TickerProfileViewModel(repository: MockRepository()), detailsViewModel:DetailsViewModel(repository:MockRepository()), newsViewModel: NewsViewModel(repository: MockRepository()))
}
