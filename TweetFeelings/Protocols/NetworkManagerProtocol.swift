import Foundation

public enum ErrorType: Error {
    case parsing
    case fetching
    case missingUrl
}

protocol Route {
    var urlRequest: URLRequest? { get }
}

enum Result<T> {
    case success(T)
    case error(Error)
    
    func get() -> Any {
        switch self {
        case let .success(value):
            return value
        case let .error(error):
            return error
        }
    }
}

protocol NetworkManagerProtocol: AnyObject {
    func call(route: Route, completion: @escaping ((Result<Data>) -> Void))
}
