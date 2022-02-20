import UIKit

public protocol HeaderStateProtocol: AnyObject {
    var headerState: HeaderState { get }
    func setupHeaderState()
    func updateHeaderState()
}

extension HeaderStateProtocol where Self: UIViewController {
    
    public var headerState: HeaderState {
        .opaque
    }
    
    public func setupHeaderState() {
        update(animated: false)
    }
    
    public func updateHeaderState() {
        update()
    }
    
}

extension HeaderStateProtocol where Self: UIViewController {
    
    private func update(animated: Bool = true) {
        let state = headerState
        
        if animated {
            UIView.animate(withDuration: HeaderConstants.Layout.colorTransitionDuration) {
                self.updateColors(tint: state.tintColor,
                                  background: state.backgroundColor,
                                  title: state.titleColor)
            }
        } else {
            updateColors(tint: state.tintColor,
                         background: state.backgroundColor,
                         title: state.titleColor)
        }
        
        applyChanges()
    }
    
    private func updateColors(tint: UIColor,
                              background: UIColor,
                              title: UIColor) {
        
        if let view = navigationItem.titleView as? HeaderContentView {
            view.updateTitle(color: title)
        }
        
        navigationItem.rightBarButtonItems?.forEach { item in
            item.customView?.tintColor = nil
            item.tintColor = nil
        }
        
        navigationController?.navigationBar.tintColor = tint
        navigationController?.navigationBar.barTintColor = background
        navigationController?.navigationBar.backgroundColor = background
        localStatusBarColor = background
    }
    
    private func applyChanges() {
        navigationController?.setNeedsStatusBarAppearanceUpdate()
        setNeedsStatusBarAppearanceUpdate()
    }
    
}
