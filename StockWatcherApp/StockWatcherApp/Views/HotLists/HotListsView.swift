//
//  GainersList.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 29.08.24.
//

import SwiftUI

struct HotListsView: View {
    @StateObject var hotTickersViewModel = HotTickersViewModel()
    
    var body: some View {
        NavigationStack{
            VStack {
                VStack(alignment:.leading){
                    GainersList(gainersList: hotTickersViewModel.gainersList)
                    LosersList(losersList: hotTickersViewModel.losersList)
                    MostTradedList(mostTradedList: hotTickersViewModel.mostTradedList)
                }
                .onAppear{
                    hotTickersViewModel.fetchMock()
                }
            }
            .navigationTitle("Todays Hot")
            .padding()
            
        }
    }
}

#Preview {
    HotListsView(hotTickersViewModel: HotTickersViewModel())
}
