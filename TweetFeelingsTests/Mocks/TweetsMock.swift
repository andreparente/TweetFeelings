@testable import TweetFeelings

struct TweetMock: TweetProtocol {
    var id: String
    var text: String
    
    init(id: String, text: String) {
        self.id = id
        self.text = text
    }
}

struct TweetsMock {
    let maxIndex = 10
    var tweets: [TweetProtocol] = []
    
    init() {
        for i in 0..<maxIndex {
            tweets.append(TweetMock(id: "\(i)", text: "Texto \(i)"))
        }
    }
}
