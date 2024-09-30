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
        
        HStack(alignment:.bottom){
            AsyncImage(url: URL(string: ImageUrls.fmpTickerImage(ticker:tickerQuote.symbol ?? "").urlString)){ image in
                ZStack(alignment:.center){
                    Rectangle()
                        .frame(width: 55,height: 55)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .foregroundStyle(.mainApp)
                        .opacity(0.15)
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
                        .foregroundStyle(.mainApp)
                        .opacity(0.25)
                    Text(tickerQuote.symbol ?? "")
                        .frame(width: 36,height: 36)
                        .foregroundStyle(.mainApp)
                    
                }
            }
            VStack(alignment:.leading,spacing: 8){
                Text(tickerQuote.symbol ?? "")
                    .roundedStyle(size: 16, weight: .bold)
                Text(tickerQuote.name?.prefix(12) ?? "")
                    .roundedStyle(size: 12, weight: .light)
            }
            .foregroundStyle(.mainApp)
            
            Spacer()
           
            
            VStack(alignment:.trailing){
                Text(String(tickerQuote.price ?? 0)+"$")
                    .roundedStyle(size: 14, weight: .semibold)
                    .foregroundStyle(.mainApp)
                
                HStack {
                    Text(String(format: "%.2f", tickerQuote.change ?? 0))
                        .roundedStyle(size: 12, weight: .regular)
                        .colouredValue(value: tickerQuote.change ?? 0)
                    Text("(\(String(format: "%.2f",tickerQuote.changesPercentage ?? 0))%)")
                        .roundedStyle(size: 12, weight: .regular)
                        .colouredValue(value: tickerQuote.changesPercentage ?? 0)
                }
            }
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .opacity(0.15)
                .colouredValue(value: tickerQuote.changesPercentage ?? 0)
        }
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
        previousClose: 226.5,
        eps: 6.57,
        pe: 35,
        sharesOutstanding: 15204100000
    ))
}
