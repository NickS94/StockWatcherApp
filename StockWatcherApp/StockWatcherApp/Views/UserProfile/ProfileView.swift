//
//  ProfileView.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 18.09.24.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var authenticationViewModel:AuthenticationViewModel
    @StateObject var userProfileViewModel = UserProfileViewModel()
    @State var showUpdateProfileSheet = false
    var body: some View {
        NavigationStack{
            VStack{
                ProfileHeader(showUpdateProfileSheet:$showUpdateProfileSheet , fireuser: userProfileViewModel.fireuser)
                Spacer()
                DeleteAccountButton(deleteAction: userProfileViewModel.deleteUser, showMainView: $authenticationViewModel.showMainView)
                LogoutButton(profileViewModel: userProfileViewModel, showMainView: $authenticationViewModel.showMainView)
            }
            .onAppear{
                userProfileViewModel.getFireUser()
            }
            .sheet(isPresented: $showUpdateProfileSheet) {
                UpdateUserInformationView(userProfileViewModel:userProfileViewModel,showUpdateProfileSheet: $showUpdateProfileSheet)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProfileView(authenticationViewModel: AuthenticationViewModel())
}
