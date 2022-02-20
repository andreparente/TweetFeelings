import UIKit

public protocol HeaderProtocol: HeaderStateProtocol {
    var headerType: HeaderType { get }
    var hasSeparator: Bool { get }
    var rightBarButton: UIBarButtonItem? { get }
    func setupHeader()
}

extension HeaderProtocol where Self: UIViewController {
    
    public var rightBarButton: UIBarButtonItem? { nil }
    public var hasSeparator: Bool { true }
}

extension HeaderProtocol where Self: UIViewController {
    
    public func setupHeader() {
        setupHeaderBackground()
        setupHeaderContent()
        setupHeaderState()
    }
    
    public func updateHeader() {
        setupHeaderContent()
        setupHeaderState()
    }
    
    public func setupDismissButton(withAction action: Selector) {
        let dismissButon = UIBarButtonItem(title: "Fechar",
                                           style: .plain,
                                           target: self,
                                           action: action)
        dismissButon.tintColor = .gray
        navigationItem.rightBarButtonItem = dismissButon
    }
}

extension HeaderProtocol where Self: UIViewController {
    
    private func setupHeaderContent() {
        switch headerType {
        case let .title(text, logo):
            setNavigation(hidden: false)
            setNavigation(title: text, logo: logo)
        case .empty:
            setNavigation(hidden: false)
            setNavigation(title: nil, logo: nil)
        case .none:
            setNavigation(hidden: true)
        }
        
        setBackButton()
        setRightButton()
    }
    
    private func setupHeaderBackground() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        if hasSeparator {
            navigationController?.navigationBar.shadowImage = nil
        } else {
            navigationController?.navigationBar.shadowImage = UIImage()
        }
    }
    
    private func setNavigation(hidden: Bool) {
        if hidden {
            navigationItem.title = ""
        }
        navigationController?.setNavigationBarHidden(hidden, animated: true)
    }
    
    private func setNavigation(title: String?, logo: UIImage?) {
        if let headerTitle = title {
            set(title: headerTitle, logo: logo)
        } else {
            navigationItem.title = ""
        }
    }
    
    private func setBackButton() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    private func setRightButton() {
        
        guard let rightButton = rightBarButton else { return }
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.gray as Any,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold)
        ]
        
        rightButton.setTitleTextAttributes(titleAttributes, for: .normal)
        navigationItem.rightBarButtonItem = rightButton
    
    }

    private func set(title: String, logo: UIImage?) {
        navigationItem.titleView = HeaderContentView(type: .title(text: title, logo: logo))
    }
    
}
