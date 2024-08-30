//
//  ContentView.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 26.08.24.
//

import SwiftUI

struct ContentView: View {	
//    @StateObject var viewModel = MyListViewModel()
//    @StateObject var hotListsViewModel = HotTickersViewModel()
    var body: some View {
       NavigationStack{
           HotListsView()
       }
        .onAppear{
            
//            viewModel.fetchMyTickerList()
            
            
        }
        .padding(5)
    }
}

#Preview {
    ContentView()
}
    
