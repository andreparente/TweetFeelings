struct UserResponse: UserResponseProtocol {
    var data: TwitterUserProtocol
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    func encode(to encoder: Encoder) throws {}
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decode(TwitterUser.self, forKey: .data)
    }
}
