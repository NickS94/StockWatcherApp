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
    @Binding var username:String
    @Binding var email:String
    @Binding var password:String
    
    var body: some View {
        VStack{
            if !loginMode{
                TextField("Username",text: $username)
                    .padding()
                    .background(.gray.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            TextField("Email",text: $email)
                .padding()
                .background(.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .textInputAutocapitalization(.never)
                .textContentType(.emailAddress)
            
  
                ZStack(alignment:.trailing) {
                    
                    if isHidden {
                        SecureField("Password", text: $password)
                            .textInputAutocapitalization(.never)
                    }else{
                        TextField("Password",text: $password)
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
    TextFields(loginMode: .constant(false), isHidden: .constant(false), username: .constant(""), email: .constant(""), password: .constant(""))
}
