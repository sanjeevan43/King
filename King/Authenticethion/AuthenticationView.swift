import FirebaseAuth
import GoogleSignIn
import Firebase
import FBSDKLoginKit

class AuthenticationView: ObservableObject {
    @Published var isLoginSuccessed = false

    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("Missing clientID from Firebase configuration.")
            return
        }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: Application_utility.rootViewController) { result, error in
            if let error = error {
                print("Google Sign-In error: \(error.localizedDescription)")
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken else {
                print("Missing user or ID token from Google Sign-In result.")
                return
            }

            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)

            Auth.auth().signIn(with: credential) { res, error in
                if let error = error {
                    print("Firebase sign-in with Google failed: \(error.localizedDescription)")
                    return
                }
                DispatchQueue.main.async {
                    self.isLoginSuccessed = true
                }
            }
        }
    }

    func signInWithFacebook() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: Application_utility.rootViewController) { result, error in
            if let error = error {
                print("Facebook login error: \(error.localizedDescription)")
                return
            }

            guard let token = AccessToken.current?.tokenString else {
                print("Missing Facebook access token.")
                return
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: token)

            Auth.auth().signIn(with: credential) { res, error in
                if let error = error {
                    print("Firebase sign-in with Facebook failed: \(error.localizedDescription)")
                    return
                }
                DispatchQueue.main.async {
                    self.isLoginSuccessed = true
                }
            }
        }
    }

    func signInAnonymously() {
        Auth.auth().signInAnonymously { authResult, error in
            if let error = error {
                print("Anonymous sign-in error: \(error.localizedDescription)")
                return
            }
            DispatchQueue.main.async {
                self.isLoginSuccessed = true
            }
        }
    }

    func logout() async throws {
        GIDSignIn.sharedInstance.signOut()
        LoginManager().logOut()
        try Auth.auth().signOut()
    }
}
