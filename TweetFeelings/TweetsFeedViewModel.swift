import Foundation

protocol TweetsFeedViewModelInterface: AnyObject {
    func fetchTweetsFrom(username: String)
}

class TweetsFeedViewModel: TweetsFeedViewModelInterface {
    var service: TwitterServiceInterface
    
    init(service: TwitterServiceInterface) {
        self.service = service
    }
    
    func fetchTweetsFrom(username: String) {
        service.fetchUserIDBy(username: username) { userResponse, error in
            if let user = userResponse {
                print(user.data.id)
            } else if let error = error {
                print(error)
            }
        }
    }
}
