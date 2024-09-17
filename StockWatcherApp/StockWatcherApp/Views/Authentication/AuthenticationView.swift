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
    @StateObject var viewModel = AuthenticationViewModel()
    
    var body: some View {
        NavigationStack{
            VStack(spacing:20){
                LoginLogo()
                
                TextFields(loginMode: $loginMode, isHidden: $isHidden, viewModel: viewModel)
                ConfigurationButton(viewModel: viewModel, loginMode: $loginMode)
                Text("Or")
                GoogleSignInButton(authenticationViewModel: viewModel)
                Spacer()
                SignInToggleText(loginMode: $loginMode, viewModel: viewModel)
               
            }
            .navigationTitle(loginMode ? "Login" : "Register")
        }
        .onAppear{
            viewModel.resetFields()
        }
        .onChange(of: loginMode) {
            viewModel.resetFields()
        }
        .onChange(of: viewModel.showMainView){
            viewModel.resetFields()
        }
        .alert(viewModel.errorMessage, isPresented: $viewModel.showAlert){}
        .fullScreenCover(isPresented: $viewModel.showMainView){
                ContentView()
        }
    }
}

#Preview {
    AuthenticationView()
}
