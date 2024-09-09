//
//  NewsRow.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 02.09.24.
//

import SwiftUI

struct TickersNewsRow: View {
    let tickerNews:TickerNews
    var body: some View {
        HStack(alignment:.top){
            VStack(alignment:.leading,spacing: 10){
                Group {
                    Text(tickerNews.title)
                        .monospacedStyle(size: 14, weight: .regular)
                    .lineLimit(3)
                    HStack{
                        Text(tickerNews.source)
                            .monospacedStyle(size: 12, weight: .bold)
                        
                        Text(DateFormatterHelper.formattedDate(from: tickerNews.timePublished,with: "yyyyMMdd'T'HHmmss"))
                            .monospacedStyle(size: 10, weight: .semibold)
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(tickerNews.tickerSentiment, id: \.ticker) { ticker in
                                TickerSentimentItem(tickerSentiment: ticker, size: 9)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                .foregroundStyle(.mainApp)
                .multilineTextAlignment(.leading) 
                
            }
            Spacer()
            AsyncImage(url: URL(string: tickerNews.bannerImage ?? "")){ image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80,height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }placeholder: {
                EmptyView()
            }
            
            
        }
        .padding()
        Divider()
    }
}

#Preview {
    TickersNewsRow(tickerNews: TickerNews(title: "Why I Think Warren Buffett Made the Right Move by Selling Apple -- Even Though I Love the Company", url: "https://www.fool.com/investing/2024/08/30/why-i-think-warren-buffett-made-the-right-move-by/", timePublished: "20240830T102100", authors: [ "Matt Frankel and Dan Caplinger"], summary: "Berkshire Hathaway sold about half of its Apple stock in the second quarter and now has a mountain of cash.", bannerImage: "https://g.foolcdn.com/editorial/images/788276/buffett6-tmf.jpg", source: "Motley Fool", sourceDomain: "www.fool.com", tickerSentiment: [TickerSentiment(ticker: "AAPL"),TickerSentiment(ticker: "BRK-A")]))
}
