//
//  MyListView.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 28.08.24.
//

import SwiftUI

struct MyListView: View {
    
    @ObservedObject var homeViewModel:HomeViewModel
    
    var body: some View {
        List {
            ForEach(homeViewModel.myTickersList, id:\.symbol){ticker in
                NavigationLink {
                    Text("This will be detail view")
                } label: {
                    TickerQuoteRow(tickerQuote: ticker)
                }
            }
        }
        .listStyle(.inset)
    }
}

#Preview {
    MyListView(homeViewModel: HomeViewModel(repository: MockRepository()))
}
