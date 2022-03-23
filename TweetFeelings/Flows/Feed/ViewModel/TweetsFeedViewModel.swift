import Foundation

protocol TweetsFeedViewModelInterface: AnyObject {
    func fetchTweetsFrom(username: String)
    
    //MARK: TableView Variants
    var numberOfTweets: Int { get }
    func tweet(at index: Int) -> String?
    
    var profileData: TwitterUserProtocol? { get set }
}

class TweetsFeedViewModel: TweetsFeedViewModelInterface {
    var service: TwitterServiceInterface
    weak var controllerDelegate: TweetsFeedViewControllerInterface?
    
    var profileData: TwitterUserProtocol?
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
                self?.profileData = user.data
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
}
