//
//  TickerAvQuoteRow.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 29.08.24.
//

import SwiftUI

struct TickerAvQuoteRow: View {
    
    let tickerQuoteAv:TickerQuoteAv
    
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: ImageUrls.fmpTickerImage(ticker:tickerQuoteAv.ticker).urlString)){ image in
                ZStack(alignment:.center){
                    Rectangle()
                        .frame(width: 55,height: 55)
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
                        .shadow(radius: 10)
                        .opacity(0.25)
                    Text(tickerQuoteAv.ticker)
                        .frame(width: 36,height: 36)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            
            VStack(alignment:.leading,spacing: 8){
                Text(tickerQuoteAv.ticker)
                    .roundedStyle(size: 16, weight: .bold)
            }
            
            Spacer()
            
            VStack(alignment:.trailing,spacing: 8){
                Text(String(tickerQuoteAv.price)+"$")
                    .roundedStyle(size: 14, weight: .semibold)
                HStack {
                    Text(tickerQuoteAv.changeAmount)
                        .roundedStyle(size: 12, weight: .regular)
                        .colouredValuesStrings(input: tickerQuoteAv.changeAmount)
                    Text("(\(tickerQuoteAv.changePercentage))")
                        .roundedStyle(size: 12, weight: .regular)
                        .colouredValuesStrings(input: tickerQuoteAv.changePercentage)
                }
            }
        }
        .padding()
        Divider()
    }
}
    
#Preview {
    TickerAvQuoteRow(tickerQuoteAv: TickerQuoteAv(ticker: "NKLA", price: "215.0", changeAmount: "1.40", changePercentage: "0.82%", volume: "2039035"))
}
