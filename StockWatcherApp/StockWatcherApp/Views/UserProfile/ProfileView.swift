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
    var body: some View {
        NavigationStack{
            VStack{
                ProfileHeader(userProfile: userProfileViewModel.user, fireuser: userProfileViewModel.fireuser)
                Spacer()
                DeleteAccountButton(deleteAction: userProfileViewModel.deleteUser, showMainView: $authenticationViewModel.showMainView)
                LogoutButton(profileViewModel: userProfileViewModel, showMainView: $authenticationViewModel.showMainView)
            }
            .onAppear{
                userProfileViewModel.fetchUser()
                userProfileViewModel.getFireUser()
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProfileView(authenticationViewModel: AuthenticationViewModel())
}
