import Foundation

protocol TwitterServiceInterface {
    func fetchUserIDBy(username: String, completion: @escaping (UserIDResponse?, Error?) -> Void)
}

class TwitterService: TwitterServiceInterface {
    let networkManager: NetworkManager
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchUserIDBy(username: String, completion: @escaping (UserIDResponse?, Error?) -> Void) {
        networkManager.call(route: TwitterAPI.getUserBy(username: username)) { result in
            switch result {
            case let .error(errorData):
                print(errorData)
                completion(nil, errorData)
            case let .success(data):
                do {
                    let userID = try JSONDecoder().decode(UserIDResponse.self, from: data)
                    completion(userID, nil)
                } catch {
                    completion(nil, ErrorType.parsing)
                }
            }
        }
    }
}
