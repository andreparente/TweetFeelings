import Foundation

struct TwitterUser: TwitterUserProtocol {
    var profileImageUrl: URL? {
        URL(string: profileImageString)
    }
    var profileImageString: String
    var isVerified: Bool
    var id: String
    var name: String
    var username: String
}

extension TwitterUser: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case profileImageUrl
        case profileImageString = "profile_image_url"
        case isVerified = "verified"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        username = try container.decode(String.self, forKey: .username)
        profileImageString = try container.decode(String.self, forKey: .profileImageString)
        isVerified = try container.decode(Bool.self, forKey: .isVerified)
    }
}

extension TwitterUser: Encodable {
    func encode(to encoder: Encoder) throws {}
}
