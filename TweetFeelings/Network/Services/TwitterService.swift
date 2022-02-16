import Foundation

protocol TwitterServiceInterface {
    func fetchUserIDBy(username: String,
                       completion: @escaping (UserResponseProtocol?, Error?) -> Void)
    func fetchTweetsFrom(userID: String,
                         completion: @escaping ([TweetProtocol]?, Error?) -> Void)
    func analyze(text: String,
                 completion: @escaping (String?, Error?) -> Void)
}

class TwitterService: TwitterServiceInterface {

    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchUserIDBy(username: String, completion: @escaping (UserResponseProtocol?, Error?) -> Void) {
        networkManager.call(route: TwitterAPI.getUserBy(username: username)) { result in
            switch result {
            case let .error(errorData):
                completion(nil, errorData)
            case let .success(data):
                do {
                    let userID = try JSONDecoder().decode(UserResponse.self, from: data)
                    completion(userID, nil)
                } catch {
                    completion(nil, ErrorType.parsing)
                }
            }
        }
    }
    
    func fetchTweetsFrom(userID: String, completion: @escaping ([TweetProtocol]?, Error?) -> Void) {
        networkManager.call(route: TwitterAPI.getTweetsBy(id: userID)) { result in
            switch result {
            case let .error(errorData):
                completion(nil, errorData)
            case let .success(data):
                do {
                    let tweets = try JSONDecoder().decode(TweetsResponse.self, from: data)
                    completion(tweets.data, nil)
                } catch {
                    completion(nil, ErrorType.parsing)
                }
            }
        }
    }
    
    func analyze(text: String, completion: @escaping (String?, Error?) -> Void) {
        networkManager.call(route: GoogleAPI.analyze(text: text)) { result in
            switch result {
            case let .error(errorData):
                completion(nil, errorData)
            case let .success(data):
                do {
                    let sentiment = try JSONDecoder().decode(SentimentResponse.self, from: data)
                    completion(sentiment.documentSentiment.sentiment.emoji, nil)
                } catch {
                    completion(nil, ErrorType.parsing)
                }
            }
        }
    }
}
