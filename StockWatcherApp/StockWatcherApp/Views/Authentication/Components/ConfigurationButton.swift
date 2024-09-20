//
//  ConfigurationButton.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 12.09.24.
//

import SwiftUI

struct ConfigurationButton: View {
    
    @ObservedObject var viewModel:AuthenticationViewModel
    @Binding var loginMode : Bool
    
    var body: some View {
        HStack{
            Button {
                if loginMode{
                    viewModel.loginUser()
                    print(viewModel.authenticationUser?.email ?? "")
                    
                }else{
                    viewModel.registerUser()
                    loginMode = true
                }
            } label: {
                Text(loginMode ? "Login" : "Register")
                    .monospacedStyle(size: 20, weight: .semibold)
                    .foregroundStyle(.mainApp)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.horizontal, 40)
        }
    }
}

#Preview {
    ConfigurationButton(viewModel: AuthenticationViewModel(), loginMode: .constant(false))
}
