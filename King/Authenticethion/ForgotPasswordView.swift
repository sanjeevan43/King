import SwiftUI
import FirebaseAuth

struct ForgotPasswordView: View {
    @State private var email: String = ""
    @State private var message: String = ""
    @State private var showAlert = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Reset Password")
                .font(.title)
                .bold()
            
            TextField("Enter your email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)

            Button(action: {
                resetPassword()
            }) {
                Text("Send Reset Link")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }

            Spacer()
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Password Reset"), message: Text(message), dismissButton: .default(Text("OK")))
        }
    }

    func resetPassword() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                message = error.localizedDescription
            } else {
                message = "A password reset link has been sent to your email."
            }
            showAlert = true
        }
    }
}
