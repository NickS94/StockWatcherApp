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
    @ObservedObject var homeViewModel: HomeViewModel
    @State var showFullDescription = false
    @State var lineLimit = 6
    let tickerSymbol:String
    
    var body: some View {
        NavigationStack{
            ScrollView{
               
                ProfileHeaderItems(tickerQuote: detailsViewModel.tickerQuote, homeViewModel: homeViewModel)
                
                Picker("", selection: $detailsViewModel.chartRange) {
                    ForEach(ChartTimeframes.allCases,id:\.rawValue){ frame in
                        Text(frame.buttonLabels).tag(frame)
                    }
                }
                .pickerStyle(.segmented)

                TickerChart(detailsViewModel: detailsViewModel, chartTimeStampList: detailsViewModel.chartTimestampsList, lastClose: detailsViewModel.tickerQuote.previousClose ?? 0)
                
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
            .scrollIndicators(.hidden)
        }
        .padding()
        .onAppear{
            tickerProfileViewModel.fetchTickerProfile(tickerSymbol)
            detailsViewModel.getTickerQuote(tickerSymbol: tickerSymbol)
            detailsViewModel.fetchTickerChart(tickerSymbol: tickerSymbol)
            homeViewModel.fetchWatchListFromDatabase()
        }
        .onChange(of: detailsViewModel.chartRange, {
            detailsViewModel.fetchTickerChart(tickerSymbol: tickerSymbol)
        })
        .onChange(of: tickerProfileViewModel.detailsPickerSelection) {
            if tickerProfileViewModel.detailsPickerSelection == .news{
                newsViewModel.fetchNews(ticker: tickerSymbol)
            }else{
                tickerProfileViewModel.fetchTickerProfile(tickerSymbol)
            }
        }
    }
}

#Preview {
    TickerDetailsView(tickerProfileViewModel: TickerProfileViewModel(repository: MockRepository()), detailsViewModel: DetailsViewModel(repository: MockRepository()), newsViewModel: NewsViewModel(repository: MockRepository()), homeViewModel: HomeViewModel(repository: MockRepository()), tickerSymbol: "AAPL")
}
