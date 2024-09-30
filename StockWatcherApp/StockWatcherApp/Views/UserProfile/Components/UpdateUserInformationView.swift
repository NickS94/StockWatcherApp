//
//  UpdateUserInformationView.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 30.09.24.
//

import SwiftUI

struct UpdateUserInformationView: View {
    
    @ObservedObject var userProfileViewModel:UserProfileViewModel
    @Binding var showUpdateProfileSheet:Bool
    
    var body: some View {
        NavigationStack{
            VStack(alignment:.leading){
                ProfileIconPick(profileIcons: $userProfileViewModel.profileIcons)
                
                TextField("Username here..", text: $userProfileViewModel.username)
                    .padding(8)
                    .background(.gray.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.vertical)
                HStack{
                    Button {
                        userProfileViewModel.updateUserInformation()
                        showUpdateProfileSheet = false
                    } label: {
                        Group{
                            Text("Update")
                            Image(systemName: "checkmark")
                        }
                        .foregroundStyle(.mainApp)
                    }
                    .frame(width: 150,height: 48)
                    .background(.gray.opacity(0.6))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    Spacer()
                    Button{
                        showUpdateProfileSheet = false
                    }label: {
                        Group{
                            Text("Cancel")
                            Image(systemName: "xmark")
                        }
                        .foregroundStyle(.mainApp)
                    }
                    .frame(width: 150,height: 48)
                    .background(.red.opacity(0.6))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .navigationTitle("Update profile")
                .navigationBarTitleDisplayMode(.inline)
            }
            .onDisappear {
                userProfileViewModel.getFireUser()
            }
            .padding()
        }
    }
}

#Preview {
    UpdateUserInformationView(userProfileViewModel: UserProfileViewModel(), showUpdateProfileSheet: .constant(false))
}
