import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var networkManager = NetworkManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TweetsFeedViewController(viewModel: TweetsFeedViewModel(service: TwitterService(networkManager: networkManager)))
        window?.makeKeyAndVisible()
        return true
    }
}

