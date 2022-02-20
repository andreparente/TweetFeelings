@testable import TweetFeelings
import Foundation

struct TwitterUserMock: TwitterUserProtocol {
    var profileImageUrl: URL? {
        URL(string: profileImageString)
    }
    var profileImageString: String
    var isVerified: Bool
    
    var id: String
    var name: String
    var username: String
    
    init() {
        id = "11"
        name = "Andre Parente"
        username = "andreparente"
        isVerified = true
        profileImageString = "profileImage.jpeg"
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
