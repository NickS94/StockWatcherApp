//
//  TickerProfileView.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 03.09.24.
//

import SwiftUI

struct TickerProfileView: View {
    @ObservedObject var tickerProfileViewModel:TickerProfileViewModel
    let tickerSymbol:String
    var body: some View {
        ScrollView {
            VStack(alignment:.leading){
                HStack{
                    Text(tickerProfileViewModel.tickerProfile?.symbol ?? "nodata")
                        .monospacedStyle(size: 18, weight: .semibold)
                    
                    Spacer()
                    AsyncImage(url: URL(string:tickerProfileViewModel.tickerProfile?.image ?? "")){ image in
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
                            Text(tickerProfileViewModel.tickerProfile?.symbol?.prefix(2).uppercased() ?? "GB")
                                .frame(width: 36,height: 36)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }
                .padding()
                // this will going to be the chart.!
                Rectangle()
                    
                
                Text(String(tickerProfileViewModel.tickerProfile?.price ?? 0.0))
                    .monospacedStyle(size: 18, weight: .semibold)
                    .padding()
                
                
            }
        }
    }
}

#Preview {
    TickerProfileView(tickerProfileViewModel: TickerProfileViewModel(repository: MockRepository()), tickerSymbol: "")
}
