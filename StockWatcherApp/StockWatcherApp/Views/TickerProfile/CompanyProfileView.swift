//
//  TickerProfileView.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 03.09.24.
//

import SwiftUI

struct CompanyProfileView: View {
    @ObservedObject var tickerProfileViewModel : TickerProfileViewModel
    @Binding var showFullDescription :Bool
    @Binding var lineLimit :Int
    var body: some View {
        VStack(alignment:.leading){
            GeneralInformation(tickerProfile: tickerProfileViewModel.tickerProfile , tickerProfileViewModel: tickerProfileViewModel, showFullDescription: $showFullDescription, lineLimit: $lineLimit)
        }
    }
    
}

#Preview {
    CompanyProfileView(tickerProfileViewModel: TickerProfileViewModel(repository: MockRepository()),showFullDescription: .constant(false),lineLimit: .constant(6))
}
