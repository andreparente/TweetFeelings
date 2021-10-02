import Foundation

public enum GoogleAPI: Route {
    
    case analyze(text: String)

    private var baseURL: String {
        "https://language.googleapis.com/v1/documents:analyzeSentiment?key=AIzaSyBH7koCAq2AVKy-9AXEBe876fA0bpCYWJs"
    }

    private var body: Data? {
        switch self {
        case let .analyze(text):
            let json = [
                "document":[
                    "type":"PLAIN_TEXT",
                    "content":"\(text)"
                ],
                "encodingType":"UTF8"
            ] as [String : Any]
            return try? JSONSerialization.data(withJSONObject: json)
        }
    }
    
    var urlRequest: URLRequest? {
        guard let url = URL(string: baseURL) else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = body
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
}
