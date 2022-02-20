protocol TweetsResponseProtocol: Codable {
    var data: [TweetProtocol] { get set }
}
