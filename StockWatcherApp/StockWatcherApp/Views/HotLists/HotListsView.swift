//
//  GainersList.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 29.08.24.
//

import SwiftUI

struct HotListsView: View {
    @ObservedObject var hotListViewModel:HotTickersViewModel
    var body: some View {
        NavigationStack{
            VStack {
                VStack(alignment:.leading){
                    GainersList(gainersList: hotListViewModel.gainersList)
                    LosersList(losersList: hotListViewModel.losersList)
                    MostTradedList(mostTradedList: hotListViewModel.mostTradedList)
                }
                .onAppear{
                  
                }
            }
            .navigationTitle("Todays Hot")
            .padding()
            
        }
    }
}

#Preview {
    HotListsView(hotListViewModel: HotTickersViewModel(repository: MockRepository()))
}
