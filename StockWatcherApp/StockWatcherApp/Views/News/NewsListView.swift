//
//  NewsListView.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 02.09.24.
//

import SwiftUI

struct NewsListView: View {
    @ObservedObject var newsViewModel:NewsViewModel
    let ticker:String
    var body: some View {
        NavigationStack{
            List{
                ForEach(newsViewModel.newsList,id:\.summary){ newsItem in
                    NavigationLink {
                        NewsDetails(tickerNews: newsItem)
                    } label: {
                        TickersNewsRow(tickerNews: newsItem)

                    }
                }
            }
            .listStyle(.inset)
            .navigationTitle(ticker == "" ? " Latest news" : "\(ticker)'s news")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear{
            newsViewModel.fetchNews(ticker: ticker)
        }
    }
}


#Preview {
    NewsListView(newsViewModel: NewsViewModel(repository: MockRepository()), ticker: "NKLA")
}
