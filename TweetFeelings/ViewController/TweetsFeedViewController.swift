import UIKit

class TweetsFeedViewController: UIViewController {
    
    weak var viewModel: TweetsFeedViewModelInterface?
    private var feedView = FeedView()
    
    init(viewModel: TweetsFeedViewModelInterface) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    override func loadView() {
        super.loadView()
        view = feedView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
