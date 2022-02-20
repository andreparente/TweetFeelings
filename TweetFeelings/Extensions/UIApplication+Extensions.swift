import UIKit

extension UIApplication {
    
    public var statusBarView: UIView? {
        if #available(iOS 13, *) {
            guard let frame = keyWindow?.windowScene?.statusBarManager?.statusBarFrame,
                let visibleViewController = keyWindow?.visibleViewController else {
                    return nil
            }
            
            let filteredSubview = visibleViewController.view.subviews.filter {
                $0.tag == visibleViewController.address()
            }
            
            if let view = filteredSubview.first {
                return view
            }
            
            let statusBar = UIView()
            statusBar.tag = visibleViewController.address()
            statusBar.frame = frame
            
            visibleViewController.view.addSubview(statusBar)
            
            return statusBar
        } else {
            guard let visibleViewController = keyWindow?.visibleViewController else {
                return nil
            }
            
            if let currentStatusBarView = getCurrentStatusBarView(from: visibleViewController) {
                return currentStatusBarView
            }
            return createNewStatusBarView(from: visibleViewController)
        }
    }
    
    public var localStatusBar: UIView? {
        if #available(iOS 13.0, *) {
            guard let frame = keyWindow?.windowScene?.statusBarManager?.statusBarFrame else { return nil }
            let local = UIView(frame: frame)
            local.tag = HeaderConstants.LocalStatusBar.tag
            return local
        } else if let local = value(forKey: HeaderConstants.LocalStatusBar.key) as? UIView {
            local.frame = statusBarFrame
            return local
        }

        return nil
    }
    
    private func getCurrentStatusBarView(from viewController: UIViewController) -> UIView? {
        let filteredSubview = viewController.view.subviews.filter {
            $0.tag == viewController.address()
        }
        
        if let currentView = filteredSubview.first {
            return currentView
        }
        
        return nil
    }
    
    private func createNewStatusBarView(from viewController: UIViewController) -> UIView? {
        guard let frame = (value(forKey: HeaderConstants.LocalStatusBar.key) as? UIView)?.frame else {
                return nil
        }
        
        let statusBar = UIView()
        statusBar.tag = viewController.address()
        statusBar.frame = frame
        
        viewController.view.addSubview(statusBar)
        
        return statusBar
    }
}
