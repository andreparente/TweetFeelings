import UIKit

extension UIViewController {
    var navigationBarHeight: CGFloat {
        guard let navigationController = self.navigationController else {
            return 0
        }
        
        let barHeight = navigationController.navigationBar.frame.height
        let statusBarFrameHeight = UIApplication.shared.statusBarFrame.height
        let barIsHidden = UIApplication.shared.isStatusBarHidden
        let statusBarHeight: CGFloat = barIsHidden ? 0.0 : statusBarFrameHeight
        return barHeight + statusBarHeight
    }
    
    var tabBarHeight: CGFloat {
        tabBarController?.tabBar.frame.size.height ?? 0.0
    }
    
    var isVisibleViewController: Bool {
        UIApplication.shared.keyWindow?.visibleViewController ?? UIViewController() === self
    }
    
    public var localStatusBarColor: UIColor {
        get {
            view.viewWithTag(HeaderConstants.LocalStatusBar.tag)?.backgroundColor ?? .white
        }
        set {
            removeLocalStatusBar()
            guard let local = UIApplication.shared.localStatusBar else { return }
            local.backgroundColor = newValue
            view?.addSubview(local)
        }
    }
    
    private func removeLocalStatusBar() {
        view?.viewWithTag(HeaderConstants.LocalStatusBar.tag)?.removeFromSuperview()
    }
    
    func showAlert(title: String,
                   subtitle: String,
                   actions: [UIAlertAction]? = nil) {
        let alert = UIAlertController(title: title,
                                      message: subtitle,
                                      preferredStyle: .alert)
        if let actions = actions {
            for action in actions {
                alert.addAction(action)
            }
        } else {
            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil))
        }
        present(alert, animated: true, completion: nil)
    }
}
