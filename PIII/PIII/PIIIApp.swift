import SwiftUI
import Firebase

@main
struct PIIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authentication = AuthenticationManager()
    
     var body: some Scene {
        WindowGroup {
            if authentication.isUserAuthenticated {
                NavigationView {
                    HomePageView()
                        .environmentObject(authentication)
                }
            } else {
                NavigationStack {
                    AuthenticationView()
                }
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
