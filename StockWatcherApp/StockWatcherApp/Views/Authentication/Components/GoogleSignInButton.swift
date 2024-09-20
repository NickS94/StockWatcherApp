//
//  GoogleSignInButton.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 17.09.24.
//

import SwiftUI

struct GoogleSignInButton: View {
    @ObservedObject var authenticationViewModel:AuthenticationViewModel
    @Binding var loginMode:Bool
    var body: some View {
        if loginMode{
            Button{
                authenticationViewModel.signInWithGoogle()
            }label: {
                HStack{
                    Text("Login with")
                        .monospacedStyle(size: 20, weight: .semibold)
                        .foregroundStyle(.mainApp)
                    Image("google")
                        .resizable()
                        .frame(width: 42,height: 42)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(.gray.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding(.horizontal, 40)
        }
      
        }
    }
}

#Preview {
    GoogleSignInButton(authenticationViewModel: AuthenticationViewModel(), loginMode: .constant(false))
}
