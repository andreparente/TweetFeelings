import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var networkManager = NetworkManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupProject()
        return true
    }
    
    private func setupProject() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let feedService = TwitterService(networkManager: networkManager)
        let viewModel = TweetsFeedViewModel(service: feedService)
        let feedViewController = TweetsFeedViewController(viewModel: viewModel)
        viewModel.controllerDelegate = feedViewController
        window?.rootViewController = feedViewController
        window?.makeKeyAndVisible()
    }
}

