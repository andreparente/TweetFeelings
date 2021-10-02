import Foundation

struct SentimentValue: SentimentValueProtocol {
    var score: Double
    
    var sentiment: Sentiment {
        Sentiment(score)
    }
}
