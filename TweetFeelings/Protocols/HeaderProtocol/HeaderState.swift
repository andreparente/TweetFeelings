import UIKit

public enum HeaderState {
    case opaque
    case translucent
    case none
    
    var tintColor: UIColor {
        switch self {
        case .opaque:
            return HeaderStyle().tintColor
        case .translucent:
            return HeaderColors.lightColor
        case .none:
            return .clear
        }
    }
    
    var titleColor: UIColor {
        switch self {
        case .opaque:
            return HeaderStyle().titleColor
        case .translucent:
            return HeaderColors.lightColor
        case .none:
            return .clear
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .opaque:
            return HeaderColors.defaultBarColor
        case .translucent:
            return HeaderColors.clearColor
        case .none:
            return .clear
        }
    }
    
    var statusBarStyle: UIStatusBarStyle {
        switch self {
        case .opaque:
            return HeaderStyle().statusBarsStyle
        case .translucent, .none:
            return .lightContent
        }
    }
}

extension HeaderState: Equatable {
    public static func == (lhs: HeaderState, rhs: HeaderState) -> Bool {
        switch (lhs, rhs) {
        case (.opaque, .opaque), (.translucent, .translucent):
            return true
        default:
            return false
        }
    }
}
