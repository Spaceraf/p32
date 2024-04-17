import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                NavigationLink(destination: TrackListView()) {
                    Text("View Tracks")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: ArticleListView()) {
                    Text("View Articles")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    do {
                        try authManager.signOut()
                        presentationMode.wrappedValue.dismiss()
                    } catch {
                        print("Error signing out: \(error)")
                    }
                }) {
                    Text("Logout")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(10)
                }
            }
            .padding()
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .navigationTitle("Home")
        }
    }
}