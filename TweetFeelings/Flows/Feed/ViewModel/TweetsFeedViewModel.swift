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
    private var tweets: [Tweet] = [] {
        didSet {
            controllerDelegate?.updateFeed()
        }
    }
    
    init(service: TwitterServiceInterface) {
        self.service = service
    }
    
    func fetchTweetsFrom(username: String) {
        service.fetchUserIDBy(username: username) { userResponse, error in
            if let user = userResponse {
                print(user.data.id)
                self.fetchTweetsFrom(user.data.id)
            } else if let error = error {
                print(error)
            }
        }
    }
    
    private func fetchTweetsFrom(_ id: String) {
        self.service.fetchTweetsFrom(userID: id) { tweets, error in
            if let tweets = tweets {
                self.tweets = tweets
                print(tweets)
            } else if let error = error {
                print(error)
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
        service.analyze(text: tweets.element(at: index)?.text ?? "")
    }
}
