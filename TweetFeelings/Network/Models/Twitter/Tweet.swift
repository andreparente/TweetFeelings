import Foundation

class TweetsResponse: Codable {
    var data: [Tweet]
}

class Tweet: Codable {
    var id: String
    var text: String
}
