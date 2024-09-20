//
//  DeleteAccountButton.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 19.09.24.
//

import SwiftUI

struct DeleteAccountButton: View {
    var deleteAction:()->Void
    @Binding var showMainView:Bool
    var body: some View {
        Button {
            deleteAction()
            showMainView = false
        } label: {
            Text("Delete Account")
                .monospacedStyle(size: 18, weight: .semibold)
                .foregroundStyle(.red)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 55)
        .background(.gray.opacity(0.6))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.horizontal, 40)
        .padding()
    }
}

#Preview {
    DeleteAccountButton(deleteAction: {}, showMainView: .constant(false))
}
