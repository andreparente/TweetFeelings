import UIKit

extension UIViewController {
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
