//
//  SignInToggleText.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 12.09.24.
//

import SwiftUI

struct SignInToggleText: View {
    
    @Binding var loginMode:Bool
    @ObservedObject var viewModel:AuthenticationViewModel
    
    var body: some View {
        HStack{
            if loginMode{
                Text("Not registered yet?")
                
                Text("Register HERE")
                    .foregroundStyle(.blue)
                    .underline(color:.blue)
                    .onTapGesture {
                        loginMode = false
                    }
            }else{
                Button(action: {
                    loginMode = true
                }, label: {
                    HStack{
                        Image(systemName: "arrow.left")
                        Text("Back")
                    }
                })
            }
            
        }
        .padding()
    }
}


#Preview {
    SignInToggleText(loginMode: .constant(false), viewModel: AuthenticationViewModel())
}
