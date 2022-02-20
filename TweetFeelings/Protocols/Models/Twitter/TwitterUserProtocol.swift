import Foundation

protocol TwitterUserProtocol: Codable {
    var id: String { get set }
    var name: String { get set }
    var username: String { get set }
    var profileImageUrl: URL? { get }
    var profileImageString: String { get set }
    var isVerified: Bool { get set }
}
