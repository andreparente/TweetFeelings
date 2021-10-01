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
    
    private var bearerToken: String {
        "AAAAAAAAAAAAAAAAAAAAAP0bUQEAAAAAO2meJd1yCGIPwI7VTqioL88Jqus%3DMmxgBHyOlhxCbJvOu3MWJkZA6EERNzviJrj9Jzf7E7RdBiu4BK"
    }
    
    var urlRequest: URLRequest? {
        guard let url = URL(string: baseURL+endpoint) else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        return urlRequest
    }
}
