@testable import TweetFeelings
import UIKit

class FeedViewControllerMock: UIViewController, TweetsFeedViewControllerInterface {
    
    var didUpdateFeed: Bool = false
    var didShowSentiment: Bool = false
    var didShowError: Bool = false
    
    var viewModel: TweetsFeedViewModelInterface
    
    init(viewModel: TweetsFeedViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateFeed() {
        didUpdateFeed = true
    }
    
    func showSentiment(_ text: String) {
        didShowSentiment = true
    }
    
    func showError(_ description: String) {
        didShowError = true
    }
}
