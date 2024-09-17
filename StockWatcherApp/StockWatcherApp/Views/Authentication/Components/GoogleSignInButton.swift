//
//  GoogleSignInButton.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 17.09.24.
//

import SwiftUI

struct GoogleSignInButton: View {
    @ObservedObject var authenticationViewModel:AuthenticationViewModel
    var body: some View {
        Button("Google") {
            authenticationViewModel.signInWithGoogle()
        }
    }
}

#Preview {
    GoogleSignInButton(authenticationViewModel: AuthenticationViewModel())
}
