struct UserIDResponse: Codable {
    var data: TwitterUser
}

struct TwitterUser: Codable {
    var id: String
    var name: String
    var username: String
}
