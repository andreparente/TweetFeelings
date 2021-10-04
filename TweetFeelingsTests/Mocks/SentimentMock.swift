@testable import TweetFeelings

struct SentimentResponseMock: SentimentResponseProtocol {
    var documentSentiment: SentimentValueProtocol
    
    init(_ sentiment: SentimentCaseMock) {
        documentSentiment = SentimentValueMock(sentiment)
    }
    
    init(from decoder: Decoder) throws {
        documentSentiment = SentimentValueMock(.neutral)
    }
    
    func encode(to encoder: Encoder) throws {}
}

struct SentimentValueMock: SentimentValueProtocol {
    var score: Double
    
    var sentiment: Sentiment {
        Sentiment(score)
    }
    
    init(_ sentimentCase: SentimentCaseMock) {
        switch sentimentCase {
        case .sadness:
            score = -0.4
        case .happiness:
            score = 0.4
        case .neutral:
            score = 0
        }
    }
}

enum SentimentCaseMock {
    case sadness
    case happiness
    case neutral
}
