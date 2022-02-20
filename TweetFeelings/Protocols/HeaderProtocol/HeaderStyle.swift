import UIKit

enum HeaderStyle {
    case light
    case dark
    
    init() {
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                self = .dark
            } else {
                self = .light
            }
        } else {
            self = .light
        }
    }
    
    var tintColor: UIColor {
        HeaderColors.grayColor
    }
    
    var titleColor: UIColor {
        .black
    }
    
    var statusBarsStyle: UIStatusBarStyle {
        .default
    }
}
