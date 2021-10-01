import Foundation

public enum ErrorType: Error {
    case parsing
    case fetching
    case missingUrl
}

protocol Route {
    func urlRequest() -> URLRequest?
}

enum Result<T> {
    case success(T)
    case error(Error)
    
    func get() -> Any {
        switch self {
        case .success(let value):
            return value
        case .error(let error):
            return error
        }
    }
}

protocol NetworkManagerProtocol: AnyObject {
    func call(route: Route, completion: @escaping ((Result<Data>) -> Void))
}
