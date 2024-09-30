//
//  ProfileHeaderItems.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 04.09.24.
//

import SwiftUI

struct ProfileHeaderItems: View {
    
    let tickerQuote:TickerQuote
    @ObservedObject var homeViewModel:HomeViewModel
    var body: some View {
       
            HStack(alignment:.bottom){
            
            VStack(alignment:.leading,spacing: 20){
                    Text(tickerQuote.name ?? "")
                        .roundedStyle(size: 25, weight: .semibold)
                        .padding(.bottom,40)
                VStack(alignment:.leading){
                    Text("\(String(tickerQuote.price ?? 0))$")
                        .roundedStyle(size: 25, weight: .semibold)
                    HStack {
                        Text(String(format:"%.2f",tickerQuote.change ?? 0))
                            .roundedStyle(size: 16, weight: .regular)
                            .colouredValue(value: tickerQuote.change ?? 0)
                        
                        Text("(\(String(format:"%.2f",tickerQuote.changesPercentage ?? 0)) %)")
                            .roundedStyle(size: 16, weight: .regular)
                            .colouredValue(value: tickerQuote.changesPercentage ?? 0)
                    }
                }
            }
            Spacer()
                VStack{
                    
                    FavoriteButton(homeViewModel: homeViewModel, tickerSymbol: tickerQuote.symbol ?? "")
                        .padding(.bottom,40)
                 
                    AsyncImage(url: URL(string:ImageUrls.fmpTickerImage(ticker: tickerQuote.symbol ?? "").urlString)){ image in
                        ZStack(alignment:.center){
                            Rectangle()
                                .frame(width: 64,height: 64)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .opacity(0.25)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 15 )
                                        .stroke(lineWidth: 0.5)
                                }
                            
                            image
                                .resizable()
                                .frame(width: 42,height: 42)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }placeholder: {
                        ZStack(alignment:.center){
                            Rectangle()
                                .frame(width: 55,height: 55)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .opacity(0.25)
                            Text(tickerQuote.symbol ?? "")
                                .frame(width: 40,height: 40)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }
           
        }
        .padding()
    }
}


#Preview {
    ProfileHeaderItems(tickerQuote: TickerQuote(
        symbol: "AAPL",
        name: "Apple Inc.",
        price: 229.97,
        changesPercentage: 0.0783,
        change: 0.18,
        dayLow: 229.345,
        dayHigh: 230.4,
        yearHigh: 237.23,
        yearLow: 164.08,
        marketCap: 3496486877000,
        priceAvg50: 221.2112,
        priceAvg200: 193.88576,
        exchange: "NASDAQ",
        previousClose: 226.5,
        eps: 6.57,
        pe: 35,
        sharesOutstanding: 15204100000
    ), homeViewModel: HomeViewModel(repository: MockRepository()))
}
