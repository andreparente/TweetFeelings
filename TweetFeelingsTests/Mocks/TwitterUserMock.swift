@testable import TweetFeelings

struct TwitterUserMock: TwitterUserProtocol {
    var id: String
    var name: String
    var username: String
    
    init() {
        id = "11"
        name = "Andre Parente"
        username = "andreparente"
    }
}

struct UserResponseMock: UserResponseProtocol {
    var data: TwitterUserProtocol
    
    init() {
        data = TwitterUserMock()
    }
    
    init(from decoder: Decoder) throws {
        data = TwitterUserMock()
    }
    
    func encode(to encoder: Encoder) throws {}
}
