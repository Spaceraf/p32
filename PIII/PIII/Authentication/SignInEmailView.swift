import SwiftUI

@MainActor
final class SignUpEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Binding var isUserAuthenticated: Bool
    
    init(isUserAuthenticated: Binding<Bool>) {
        self._isUserAuthenticated = isUserAuthenticated
    }
    
    func signUp() {
        guard !email.isEmpty, !password.isEmpty else {
            print("No Email or Password found.")
            return
        }
        
        Task {
            do {
                let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password:password)
                //login
                let returnedUserData = try await AuthenticationManager.shared.signIn(email: email, password: password)
                print("success")
                print(returnedUserData)
                DispatchQueue.main.async {
                    self.isUserAuthenticated = true
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

struct SignUpEmailView: View {
    @StateObject private var viewmodel: SignUpEmailViewModel
    
    init(isUserAuthenticated: Binding<Bool>) {
        _viewmodel = StateObject(wrappedValue: SignUpEmailViewModel(isUserAuthenticated: isUserAuthenticated))
    }
    
    var body: some View {
        VStack {
            TextField("Email...", text: $viewmodel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("Password...", text: $viewmodel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            Button(action: {viewmodel.signUp()}, label: {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            })
        }
        .padding()
        .navigationTitle("Sign Up With Email")
    }
}

#Preview {
    NavigationStack {
        SignUpEmailView(isUserAuthenticated: .constant(false))
    }
}
