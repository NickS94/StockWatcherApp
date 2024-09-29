//
//  ProfileIconPick.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 26.09.24.
//

import SwiftUI

struct ProfileIconPick: View {
    @Binding var profileIcons:ProfileIcons
    var body: some View {
        VStack{
            Image(systemName: profileIcons.iconName)
                .font(.system(size: 70))
                .overlay {
                    Circle()
                        .frame(width: 150,height: 150)
                        .shadow(color: .mainApp, radius: 15)
                        .foregroundStyle(.mainApp.opacity(0.2))
                }
                .padding(.vertical,50)
            Picker(selection: $profileIcons) {
                ForEach(ProfileIcons.allCases,id:\.self){ icon in
                    HStack {
                        Image(systemName: icon.iconName).tag(icon)
                            .font(.title)
                            .frame(width: 60,height: 60)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                        Text(icon.rawValue.capitalized)
                    }
                }
            } label: {
                HStack{
                    Text("Pick an icon")
                        .monospacedStyle(size: 20, weight: .semibold)
                        .foregroundStyle(.mainApp)
                    Spacer()
                    Image(systemName: "arrow.right")
                        .monospacedStyle(size: 20, weight: .semibold)
                        .foregroundStyle(.mainApp)
                }
            }
            .pickerStyle(.navigationLink)
            Divider()
                .frame(height: 1)
                .background(.mainApp.opacity(0.7))
        }
        .padding(.horizontal)
    }
}

#Preview {
    ProfileIconPick(profileIcons:.constant(.ant) )
}
