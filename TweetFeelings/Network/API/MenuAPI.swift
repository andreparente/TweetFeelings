import Foundation

public enum TwitterAPI: Route {
    
    case getUserBy(username: String)
    case getTweetsBy(id: String)
    
    var endpoint: String {
        switch self {
        case let .getUserBy(username):
            return "users/by/username/\(username)"
        case let .getTweetsBy(id):
            return "users/\(id)/tweets"
        }
    }
    
    private var baseURL: String {
        "https://api.twitter.com/2/"
    }
    
    func urlRequest() -> URLRequest? {
        guard let url = URL(string: baseURL+endpoint) else { return nil }
        return URLRequest(url: url)
    }
    
}
