import SwiftUI
import FirebaseAuth

struct InitialView: View {
    @State private var userLoggedIn = (Auth.auth().currentUser != nil)

    var body: some View {
        Group {
            if userLoggedIn {
                MainMenu()
            } else {
                Firstpage()
            }
        }
        .onAppear {
            Auth.auth().addStateDidChangeListener { _, user in
                userLoggedIn = (user != nil)
            }
        }
    }
}
