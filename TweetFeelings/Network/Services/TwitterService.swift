import Foundation

protocol TwitterServiceInterface {
    func fetchUserIDBy(username: String,
                       completion: @escaping (UserResponseProtocol?, Error?) -> Void)
    func fetchTweetsFrom(userID: String,
                         completion: @escaping ([TweetProtocol]?, Error?) -> Void)
}

class TwitterService: TwitterServiceInterface {

    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchUserIDBy(username: String,
                       completion: @escaping (UserResponseProtocol?, Error?) -> Void) {
        networkManager.call(route: TwitterAPI.getUserBy(username: username)) { result in
            switch result {
            case let .error(errorData):
                completion(nil, errorData)
            case let .success(data):
                do {
                    let userID = try JSONDecoder().decode(UserResponse.self, from: data)
                    completion(userID, nil)
                } catch {
                    do {
                        let errorResponse = try JSONDecoder().decode(UserErrorResponse.self, from: data)
                        completion(nil, errorResponse.errors.first)
                    }
                    catch {
                        completion(nil, ErrorType.parsing)
                    }
                }
            }
        }
    }
    
    func fetchTweetsFrom(userID: String,
                         completion: @escaping ([TweetProtocol]?, Error?) -> Void) {
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
}
