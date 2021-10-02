import Foundation

protocol TweetsFeedViewModelInterface: AnyObject {
    func fetchTweetsFrom(username: String)
    func analyzeText(at index: Int)
    
    //MARK: TableView Variants
    var numberOfTweets: Int { get }
    func tweet(at index: Int) -> String?
}

class TweetsFeedViewModel: TweetsFeedViewModelInterface {
    var service: TwitterServiceInterface
    var controllerDelegate: TweetsFeedViewControllerInterface?
    private var tweets: [TweetProtocol] = [] {
        didSet {
            controllerDelegate?.updateFeed()
        }
    }
    
    init(service: TwitterServiceInterface) {
        self.service = service
    }
    
    func fetchTweetsFrom(username: String) {
        service.fetchUserIDBy(username: username) { [weak self] userResponse, error in
            if let user = userResponse {
                self?.fetchTweetsFrom(user.data.id)
            } else if let error = error {
                self?.tweets.removeAll()
                self?.controllerDelegate?.showError(error.localizedDescription)
            }
        }
    }
    
    private func fetchTweetsFrom(_ id: String) {
        self.service.fetchTweetsFrom(userID: id) { [weak self] tweets, error in
            if let tweets = tweets {
                self?.tweets = tweets
            } else if let error = error {
                self?.tweets.removeAll()
                self?.controllerDelegate?.showError(error.localizedDescription)
            }
        }
    }
    
    var numberOfTweets: Int {
        tweets.count
    }
    
    func tweet(at index: Int) -> String? {
        tweets.element(at: index)?.text
    }
    
    func analyzeText(at index: Int) {
        service.analyze(text: tweets.element(at: index)?.text ?? "") { [weak self] sentimentText, error in
            if let text = sentimentText {
                self?.controllerDelegate?.showSentiment(text)
            } else if let error = error {
                self?.controllerDelegate?.showError(error.localizedDescription)
            }
        }
    }
}
