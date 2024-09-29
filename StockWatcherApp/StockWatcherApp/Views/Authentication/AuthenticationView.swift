//
//  RegistrationView.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 12.09.24.
//

import SwiftUI

struct AuthenticationView: View {
    
    @State var loginMode = true
    @State var isHidden = true   
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    
    var body: some View {
        NavigationStack{
            VStack(spacing:20){
                LoginLogo(isLoginMode: $loginMode, profileIcons: $authenticationViewModel.userIconPick)
                TextFields(loginMode: $loginMode, isHidden: $isHidden, viewModel: authenticationViewModel)
                ConfigurationButton(viewModel: authenticationViewModel, loginMode: $loginMode)
                Text(loginMode ? "Or" : "")
                GoogleSignInButton(authenticationViewModel: authenticationViewModel, loginMode: $loginMode)
                SignInToggleText(loginMode: $loginMode, viewModel: authenticationViewModel)
            }
            .navigationTitle(loginMode ? "Login" : "Register")
        }
        .onAppear{
            authenticationViewModel.resetFields()
        }
        .onChange(of: loginMode) {
            authenticationViewModel.resetFields()
        }
        .onChange(of: authenticationViewModel.showMainView){
            authenticationViewModel.resetFields()
        }
        .alert(authenticationViewModel.errorMessage, isPresented: $authenticationViewModel.showAlert){}
        
        .fullScreenCover(isPresented: $authenticationViewModel.showMainView){
            ContentView( authenticationViewModel: authenticationViewModel)
            
        }
    }
}

#Preview {
    AuthenticationView()
}
