//
//  TickerRow.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 28.08.24.
//

import SwiftUI

struct TickerQuoteRow: View {
    let tickerQuote:TickerQuote
    
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: ImageUrls.fmpTickerImage(ticker:tickerQuote.symbol).urlString)){ image in
                ZStack(alignment:.center){
                    Rectangle()
                        .frame(width: 55,height: 55)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(radius: 10)
                        .opacity(0.25)
                        
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
                        .shadow(radius: 10)
                        .opacity(0.25)
                    Text(tickerQuote.symbol.prefix(2).uppercased())
                        .frame(width: 36,height: 36)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            
            VStack(alignment:.leading,spacing: 8){
                Text(tickerQuote.symbol)
                    .monospacedStyle(size: 16, weight: .bold)
                Text(tickerQuote.name.prefix(12))
                    .monospacedStyle(size: 12, weight: .light)
            }
            
            Spacer()
            
            VStack(alignment:.trailing,spacing: 8){
                Text(String(tickerQuote.price)+"$")
                    .monospacedStyle(size: 14, weight: .semibold)
                
                HStack {
                    Text(String(format: "%.2f", tickerQuote.change))
                        .monospacedStyle(size: 12, weight: .regular)
                        .colouredValue(value: tickerQuote.change)
                    Text("(\(String(tickerQuote.changesPercentage))%)")
                        .monospacedStyle(size: 12, weight: .regular)
                        .colouredValue(value: tickerQuote.changesPercentage)
                }
            }
        }
        .padding()
        Divider()
    }
}

#Preview {
    TickerQuoteRow(tickerQuote: TickerQuote(
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
        eps: 6.57,
        pe: 35,
        sharesOutstanding: 15204100000
    ))
}
