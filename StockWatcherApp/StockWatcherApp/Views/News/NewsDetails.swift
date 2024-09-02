//
//  NewsDetails.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 02.09.24.
//

import SwiftUI

struct NewsDetails: View {
    let tickerNews:TickerNews
    var body: some View {
        ScrollView{
            VStack(alignment:.leading){
                AsyncImage(url: URL(string: tickerNews.bannerImage ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                } placeholder: {
                    EmptyView()
                }
                
                Link(tickerNews.source, destination: URL(string: tickerNews.sourceDomain)!)
                    .font(.title2.bold())
                    .foregroundStyle(.mainApp)
                    .padding(.leading,10)
                    .padding(.top,10)
                
                Text(tickerNews.title)
                    .monospacedStyle(size: 22, weight: .bold)
                    .padding()
                
                
                ForEach(tickerNews.authors,id:\.count){author in
                    Text("By \(author)")
                        .monospacedStyle(size: 14, weight: .semibold)
                        .padding(.leading,10)
                }
                
                Text(DateFormatterHelper.formattedDate(from: tickerNews.timePublished,with: "yyyyMMdd'T'HHmmss"))
                    .monospacedStyle(size: 10, weight: .regular)
                    .foregroundStyle(.mainApp.opacity(0.5))
                    .padding(.leading,10)
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(tickerNews.tickerSentiment, id: \.ticker) { ticker in
                            TickerSentimentItem(tickerSentiment: ticker, size: 15)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .padding()
                
                Text(tickerNews.summary)
                    .monospacedStyle(size: 16, weight: .regular)
                    .padding()
                Link(destination: URL(string: tickerNews.url)!, label: {
                    HStack{
                        Spacer()
                        Text("Read more")
                        Image(systemName: "arrow.right")
                    }
                })
                .padding()
                Spacer()
            }
        }
    }
}

#Preview {
    NewsDetails(tickerNews: TickerNews(title: "Why I Think Warren Buffett Made the Right Move by Selling Apple -- Even Though I Love the Company", url: "https://www.fool.com/investing/2024/08/30/why-i-think-warren-buffett-made-the-right-move-by/", timePublished: "20240830T102100", authors: [ "Matt Frankel and Dan Caplinger"], summary: "Berkshire Hathaway sold about half of its Apple stock in the second quarter and now has a mountain of cash.", bannerImage: "https://g.foolcdn.com/editorial/images/788276/buffett6-tmf.jpg", source: "Motley Fool", sourceDomain: "www.fool.com", tickerSentiment: [TickerSentiment(ticker: "AAPL"),TickerSentiment(ticker: "BRK-A")]))
}
