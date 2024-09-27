//
//  LoginLogo.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 12.09.24.
//

import SwiftUI

struct LoginLogo: View {
    @Binding var isLoginMode:Bool
    @Binding var profileIcons:ProfileIcons
    var body: some View {
        VStack{
            if isLoginMode{
                Image("AppLogo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150,height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .shadow(color:.mainApp,radius: 15)
                Text("Stock Watcher")
                    .monospacedStyle(size: 30, weight: .heavy)
            }else{
                ProfileIconPick(profileIcons: $profileIcons)
            }
           
        }
        .padding()
    }
}

#Preview {
    LoginLogo(isLoginMode: .constant(false), profileIcons: .constant(.ant))
}
