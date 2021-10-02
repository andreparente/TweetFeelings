import Foundation

protocol SentimentResponseProtocol: Codable {
    var documentSentiment: SentimentValueProtocol { get set }
}
