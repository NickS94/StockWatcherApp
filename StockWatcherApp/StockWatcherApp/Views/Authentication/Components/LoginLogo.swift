//
//  LoginLogo.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 12.09.24.
//

import SwiftUI

struct LoginLogo: View {
    var body: some View {
        VStack{
            Image("AppLogo")
                .resizable()
                .scaledToFill()
                .frame(width: 150,height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .shadow(color:.mainApp,radius: 15)
            Text("Stock Watcher")
                .monospacedStyle(size: 30, weight: .heavy)
        }
        .padding()
    }
}

#Preview {
    LoginLogo()
}
