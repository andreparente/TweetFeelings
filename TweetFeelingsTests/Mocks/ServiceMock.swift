@testable import TweetFeelings

class ServiceMock: TwitterServiceInterface {
    var fetchUserCase: FetchUserByIDCase
    var fetchTweetsFromUserCase: FetchTweetsFromUserCase
    var score: Double
    
    init(fetchUserCase: FetchUserByIDCase,
         fetchTweetsFromUserCase: FetchTweetsFromUserCase,
         score: Double = 0) {
        self.fetchUserCase = fetchUserCase
        self.fetchTweetsFromUserCase = fetchTweetsFromUserCase
        self.score = score
    }
    
    func fetchUserIDBy(username: String, completion: @escaping (UserResponseProtocol?, Error?) -> Void) {
        switch fetchUserCase {
        case .success:
            completion(UserResponseMock(), nil)
        case .error:
            completion(nil, ErrorType.parsing)
        }
    }
    
    func fetchTweetsFrom(userID: String, completion: @escaping ([TweetProtocol]?, Error?) -> Void) {
        switch fetchTweetsFromUserCase {
        case .success:
            completion(TweetsMock().tweets, nil)
        case .error:
            completion(nil, ErrorType.parsing)
        }
    }
    
    func analyze(text: String, completion: @escaping (String?, Error?) -> Void) {
        completion(Sentiment(score).emoji, nil)
    }
}

enum FetchUserByIDCase {
    case success, error
}

enum FetchTweetsFromUserCase {
    case success, error
}
