import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol,
         navigationController: UINavigationController) {
        self.networkManager = networkManager
        self.navigationController = navigationController
    }

    func start() {
        let feedService = TwitterService(networkManager: networkManager)
        let viewModel = TweetsFeedViewModel(service: feedService)
        let feedViewController = TweetsFeedViewController(viewModel: viewModel)
        viewModel.controllerDelegate = feedViewController
        navigationController.setViewControllers([feedViewController], animated: false)
    }
}
