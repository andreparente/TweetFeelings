import UIKit

public struct HeaderConstants {
    
    public struct Layout {
        
        public static let letterSpacing: CGFloat = -0.72
        public static let lineHeight: CGFloat = 20
        
        public static let cornerRadius: CGFloat = 10.0
        public static let colorTransitionDuration: TimeInterval = 0.05
        public static let transparencyOffset: CGFloat = 0.6
        public static let spacing: CGFloat = 8
    }
    
    public struct LocalStatusBar {
        public static let tag: Int = 111
        public static let key: String = "statusBar"
    }
    
}

extension HeaderConstants.Layout {
    
    public struct Logo {
        public static let size = CGSize(width: 36, height: 21)
    }
    
    public struct Title {
        public static let logoHeight: CGFloat = 13
        public static let logoWidth: CGFloat = 22
        public static let badgeSize = CGSize(width: logoWidth, height: logoHeight)
        public static let fontSize: CGFloat = 20
        public static let margin: CGFloat = 3
    }
    
}
