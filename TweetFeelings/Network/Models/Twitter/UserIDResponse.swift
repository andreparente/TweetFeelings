struct UserIDResponse: Codable {
    var data: TwitterUser
}

struct TwitterUser: Codable {
    var id: Int
    var name: String
    var username: String
}
