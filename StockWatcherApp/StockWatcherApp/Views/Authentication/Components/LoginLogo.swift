//
//  LoginLogo.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 12.09.24.
//

import SwiftUI

struct LoginLogo: View {
    var body: some View {
        Image("AppLogo")
            .resizable()
            .scaledToFill()
            .frame(width: 150,height: 150)
            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
            .shadow(color:.mainApp,radius: 15)
    }
}

#Preview {
    LoginLogo()
}
