import SwiftUI
import Firebase
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

struct loginPage: View {
    @State private var email = ""
    @State private var password = ""
    @State private var loginError = ""
    @State private var isLoggedIn = false
    @State private var vm = AuthenticationView()
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("Welcome Back!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)

                    Text("Login to continue")
                        .foregroundColor(.gray)
                        .font(.title3)
                    VStack(spacing: 16) {
                        TextField("Email", text: $email)
                            .font(.system(size: 20))
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color("TextFieldBackground"))
                            .cornerRadius(12)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color("BorderColor"), lineWidth: 1)
                            )
                            .shadow(color: .gray.opacity(0.15), radius: 5, x: 0, y: 2)

                        SecureField("Password", text: $password)
                            .padding()
                            .font(.system(size: 20))
                            .background(Color("TextFieldBackground"))
                            .cornerRadius(12)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color("BorderColor"), lineWidth: 1)
                            )
                            .shadow(color: .gray.opacity(0.15), radius: 5, x: 0, y: 2)
                    }
                    .background(Color(red: 243/255, green: 244/255, blue: 246/255)) // gray-100
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(red: 209/255, green: 213/255, blue: 219/255), lineWidth: 1) // gray-300
                    )



                    Button(action: login) {
                        Text("Login")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(radius: 4)
                    }
                    .padding(.top)

                    NavigationLink(destination: ForgotPasswordView()) {
                        Text("Forgot Password?")
                            .foregroundColor(.blue)
                            .font(.footnote)
                            .underline()
                    }

                    Divider()
                        .padding(.vertical, 10)

                    GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .light)) {
                        vm.signInWithGoogle()
                    }
                    .frame(height: 50)
                    .padding(.horizontal)

                    if !loginError.isEmpty {
                        Text(loginError)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .padding(.top)
                    }

                    NavigationLink(value: isLoggedIn) {
                        EmptyView()
                    }
                    .navigationDestination(isPresented: $isLoggedIn) {
                        ContentView()
                            .navigationBarBackButtonHidden(true)
                    }

                    Spacer()
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.white.opacity(0.9))
                        .shadow(radius: 10)
                )
                .padding()
            }
        }
    }

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                loginError = error.localizedDescription
                return
            }
            isLoggedIn = true
        }
    }
}

#Preview {
    loginPage()
}
