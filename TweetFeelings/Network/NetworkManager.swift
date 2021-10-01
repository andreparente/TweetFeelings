import Foundation

class NetworkManager: NetworkManagerProtocol {
    
    private lazy var session: URLSession = {
        URLSession(configuration: URLSession.shared.configuration)
    }()

    public init() {}
    
    func call(route: Route, completion: @escaping (Result<Data>) -> Void) {
        if let urlRequest = route.urlRequest {
            session.dataTask(with: urlRequest) { data, _, error in
                if let data = data {
                    completion(.success(data))
                    return
                }
                
                if let error = error {
                    completion(.error(error))
                    return
                }
            }.resume()
        }
    }
}
