//
//  SignInEmailView.swift
//  PIII
//
//  Created by builder on 3/7/24.
//

import SwiftUI
@MainActor
final class SignInEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func signIn() {
        guard !email.isEmpty, !password.isEmpty else {
            print("No Email or Password found.")
            return
        }
        Task {
            do {
                let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password:password)
                print("success")
                print(returnedUserData)
            } catch {
                print("Error: \(error)")
            }
            
        }
    }
}

struct SignInEmailView: View {
    @StateObject private var viewmodel = SignInEmailViewModel()
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
            
            Button(action: {viewmodel.signIn()}, label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            })
                
            }
        
        .padding()
        .navigationTitle("Sign In With Email")
    }
}

#Preview {
    NavigationStack {
        SignInEmailView()
    }
}
