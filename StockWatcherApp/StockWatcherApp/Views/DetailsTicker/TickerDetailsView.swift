//
//  TickerDetailsView.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 04.09.24.
//

import SwiftUI

struct TickerDetailsView: View {
    
    @ObservedObject var tickerProfileViewModel: TickerProfileViewModel
    @ObservedObject var detailsViewModel: DetailsViewModel
    @ObservedObject var newsViewModel: NewsViewModel
    @State var showFullDescription = false
    @State var lineLimit = 6
    let tickerSymbol:String
    
    var body: some View {
        NavigationStack{
            ScrollView{
                ProfileHeaderItems(tickerQuote: detailsViewModel.tickerQuote)
                
                TickerChart(chartTimeStampList: detailsViewModel.chartTimestampsList, lastClose: detailsViewModel.tickerQuote.previousClose ?? 0)
                KeyRatiosTable(dividend: tickerProfileViewModel.tickerProfile.lastDiv ?? 0, beta: tickerProfileViewModel.tickerProfile.beta ?? 0, detailsViewModel: detailsViewModel)
                
                PriceRangeTable(tickerQuote: detailsViewModel.tickerQuote)
                
                Picker("", selection: $tickerProfileViewModel.detailsPickerSelection) {
                    ForEach(DetailsViewPickerItems.allCases,id:\.rawValue){ selection in
                        Text(selection.rawValue).tag(selection)
                    }
                }
                .pickerStyle(.segmented)
                
                if tickerProfileViewModel.detailsPickerSelection == .profile{
                    CompanyProfileView(tickerProfileViewModel: tickerProfileViewModel, showFullDescription: $showFullDescription, lineLimit: $lineLimit)
                }else {
                    ScrollView{
                        ForEach(newsViewModel.newsList,id:\.summary){ article in
                            NavigationLink {
                                NewsDetails(tickerNews: article)
                            } label: {
                                TickersNewsRow(tickerNews: article)
                            }
                        }
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .padding()
        .onAppear{
            tickerProfileViewModel.fetchTickerProfile(tickerSymbol)
            detailsViewModel.getTickerQuote(tickerSymbol: tickerSymbol)
            detailsViewModel.fetchTickerChart(tickerSymbol: tickerSymbol)
        }
        .onChange(of: tickerProfileViewModel.detailsPickerSelection) {
            if tickerProfileViewModel.detailsPickerSelection == .profile{
                tickerProfileViewModel.fetchTickerProfile(tickerSymbol)
            }else{
                newsViewModel.fetchNews(ticker: tickerSymbol)
            }
        }
    }
}

#Preview {
    TickerDetailsView(tickerProfileViewModel: TickerProfileViewModel(repository: MockRepository()), detailsViewModel: DetailsViewModel(repository: MockRepository()), newsViewModel: NewsViewModel(repository: MockRepository()), tickerSymbol: "AAPL")
}
