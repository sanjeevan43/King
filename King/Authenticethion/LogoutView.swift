//
//  LogoutView.swift
//  Gauth
//
//  Created by sanjeev on 6/2/25.
//

import SwiftUI
import FirebaseAuth

struct LogoutView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isUserLoggedIn") var isUserLoggedIn = true 

    var body: some View {
        VStack(spacing: 20) {
            Text("Are you sure you want to log out?")
                .font(.title2)

            Button(action: {
                logOut()
            }) {
                Text("Log Out")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
            }

            Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .padding()
    }

    func logOut() {
        do {
            try Auth.auth().signOut()
            isUserLoggedIn = false // Navigate back to login
        } catch {
            print("Logout failed: \(error.localizedDescription)")
        }
    }
}
