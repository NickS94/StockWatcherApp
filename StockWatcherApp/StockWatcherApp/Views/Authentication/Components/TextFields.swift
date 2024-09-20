//
//  TextFields.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 12.09.24.
//

import SwiftUI

struct TextFields: View {
    
    @Binding var loginMode:Bool
    @Binding var isHidden:Bool
    
    @ObservedObject var viewModel:AuthenticationViewModel
    
    var body: some View {
        VStack{
            if !loginMode{
                TextField("Username",text: $viewModel.username)
                    .padding()
                    .background(.gray.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            TextField("Email",text: $viewModel.email)
                .padding()
                .background(.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .textInputAutocapitalization(.never)
            
  
                ZStack(alignment:.trailing) {
                    
                    if isHidden {
                        SecureField("Password", text: $viewModel.password)
                            .textInputAutocapitalization(.never)
                    }else{
                        TextField("Password",text: $viewModel.password)
                            .textInputAutocapitalization(.never)
                }
                    Image(systemName: isHidden ? "eye.slash.fill" : "eye.fill")
                        .onTapGesture {
                            isHidden.toggle()
                        }
      
                }
                .padding()
                .background(.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
        }
        .padding()
    }
}

#Preview {
    TextFields(loginMode: .constant(false), isHidden: .constant(true), viewModel: AuthenticationViewModel())
}
