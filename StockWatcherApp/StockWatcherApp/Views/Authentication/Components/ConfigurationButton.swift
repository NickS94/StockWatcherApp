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
                  
                    
                }else{
              
                    loginMode = true
                }
            } label: {
                    Text(loginMode ? "Login" : "Register")
                .font(.title2)
                .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
        }
        .padding()
    }
}

#Preview {
    ConfigurationButton(viewModel: AuthenticationViewModel(), loginMode: .constant(false))
}
