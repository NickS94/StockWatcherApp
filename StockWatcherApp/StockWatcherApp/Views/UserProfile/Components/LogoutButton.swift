//
//  LogoutButton.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 19.09.24.
//

import SwiftUI

struct LogoutButton: View {
    @ObservedObject var profileViewModel:UserProfileViewModel
    @Binding var showMainView:Bool
    var body: some View {
        Button {
            profileViewModel.logoutUser()
            showMainView = false
        } label: {
            Text("Logout")
                .monospacedStyle(size: 18, weight: .semibold)
                .foregroundStyle(.mainApp)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 55)
        .background(.red.opacity(0.6))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.horizontal, 40)
        .padding()
    }
}

#Preview {
    LogoutButton(profileViewModel: UserProfileViewModel(), showMainView: .constant(false))
}
