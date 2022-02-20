import UIKit

extension UIWindow {
    var visibleViewController: UIViewController? {
        getVisibleViewControllerFrom(rootViewController)
    }
    
    private func getVisibleViewControllerFrom(_ viewController: UIViewController?) -> UIViewController? {
        if let navController = viewController as? UINavigationController {
            return getVisibleViewControllerFrom(navController.visibleViewController)
        } else if let tabController = viewController as? UITabBarController {
            return getVisibleViewControllerFrom(tabController.selectedViewController)
        } else {
            if let presentedController = viewController?.presentedViewController {
                return getVisibleViewControllerFrom(presentedController)
            } else {
                return viewController
            }
        }
    }
    
    func getRootNavigationController() -> UINavigationController? {
        rootViewController as? UINavigationController
    }
}
