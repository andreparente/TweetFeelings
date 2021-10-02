import Foundation

struct SentimentResponse: Codable {
    var documentSentiment: SentimentValue
}

struct SentimentValue: Codable {
    var score: Double
    
    var sentiment: Sentiment {
        Sentiment(score)
    }
}
