import Foundation

struct SentimentResponse: SentimentResponseProtocol {
    var documentSentiment: SentimentValueProtocol
    
    enum CodingKeys: String, CodingKey {
        case documentSentiment
    }
    
    func encode(to encoder: Encoder) throws {}
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        documentSentiment = try container.decode(SentimentValue.self, forKey: .documentSentiment)
    }
}
