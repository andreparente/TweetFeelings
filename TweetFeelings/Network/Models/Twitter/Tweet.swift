protocol TweetsResponseProtocol: Codable {
    var data: [TweetProtocol] { get set }
}

protocol TweetProtocol: Codable {
    var id: String { get set }
    var text: String { get set }
}

struct TweetsResponse: TweetsResponseProtocol {
    var data: [TweetProtocol]
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    func encode(to encoder: Encoder) throws {}
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decode([Tweet].self, forKey: .data)
    }
}

struct Tweet: TweetProtocol {
    var id: String
    var text: String
}
