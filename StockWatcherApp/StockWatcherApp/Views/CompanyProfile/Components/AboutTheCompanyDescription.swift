//
//  CompanyInfo.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 03.09.24.
//

import SwiftUI

struct AboutTheCompanyDescription: View {
    
    @ObservedObject var tickerProfileViewModel:TickerProfileViewModel
    @Binding var showFullDescription :Bool
    @Binding var lineLimit :Int
    
    var body: some View {
        
        VStack(alignment:.leading,spacing: 15){
            Text("About the company")
                .font(.title2.bold())
            Text(tickerProfileViewModel.tickerProfile.description ?? "")
                .monospacedStyle(size: 14, weight: .regular)
                .lineLimit(lineLimit)
            
            Text(showFullDescription ? "Read less" : "Read more")
                .underline()
                .onTapGesture {
                    showFullDescription.toggle()
                    
                    if showFullDescription {
                        lineLimit = 200
                    }else{
                        lineLimit = 6
                    }
                }
        }
        .padding()
    }
}



#Preview {
    AboutTheCompanyDescription(tickerProfileViewModel: TickerProfileViewModel(repository: MockRepository()),showFullDescription:.constant(false),lineLimit: .constant(6))
}
