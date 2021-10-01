import Foundation

protocol TweetsFeedViewModelInterface: AnyObject {
    func fetchTweetsFrom(username: String)
}

class TweetsFeedViewModel {
    var service: TwitterServiceInterface
    
    init(service: TwitterServiceInterface) {
        self.service = service
    }
}
