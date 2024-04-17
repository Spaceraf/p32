import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
    }
}

final class AuthenticationManager: ObservableObject {
    
    @Published var isUserAuthenticated: Bool
    static let shared = AuthenticationManager()
    
    private init() {
        // Initialize the authentication state based on whether we have a current user
        self.isUserAuthenticated = Auth.auth().currentUser != nil
    }
    
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        // Update authentication state upon user creation
        DispatchQueue.main.async {
            self.isUserAuthenticated = true
        }
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func signIn(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        // Update authentication state upon sign in
        DispatchQueue.main.async {
            self.isUserAuthenticated = true
        }
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
        // Update authentication state upon sign out
        DispatchQueue.main.async {
            self.isUserAuthenticated = false
        }
    }
}
