//
//  Firstpage.swift
//  Gauth
//
//  Created by sanjeevan on 03/06/25.
//


import SwiftUI
import connect
import SwiftUI

struct Firstpage: View {
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                               startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    NavigationLink(destination: SignInView()) {
                        Text("Sign In")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 120, height: 40)
                            .background(Color.blue.opacity(0.8))
                            .cornerRadius(40)
                    }
                    
                    NavigationLink(destination:   loginPage()) {
                        Text("Login")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 120, height: 40)
                            .background(Color.green.opacity(0.8))
                            .cornerRadius(40)
                    }
                }
            }
        }
    }
}

struct SignInView: View {
    var body: some View {
        Text("Sign In Page")
    }
}

#Preview {
    Firstpage()
}
