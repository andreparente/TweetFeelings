import Foundation

protocol SentimentValueProtocol: Codable {
    var score: Double { get set }
    var sentiment: Sentiment { get }
}
