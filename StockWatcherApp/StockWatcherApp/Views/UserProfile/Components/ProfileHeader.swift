//
//  ProfileHeader.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 18.09.24.
//

import SwiftUI
import FirebaseAuth

struct ProfileHeader: View {
    let userProfile :User?
   
    var body: some View {
        VStack{
            AsyncImage(url: userProfile?.photoURL){ image in
               image
                    .resizable()
                    .frame(width: 150,height: 150)
                    .clipShape(Circle())
            }placeholder: {
                ZStack{
                    Circle()
                        .frame(width: 150)
                    Text(userProfile?.email?.prefix(2) ?? "")
                        .monospacedStyle(size: 20, weight: .semibold)
                        .foregroundStyle(.black)
                }
            }
            Text(userProfile?.displayName ?? "")
                .font(.title2)
                .bold()
                .italic()
            Text(userProfile?.email ?? "")
        }
        .padding()
    }
}


