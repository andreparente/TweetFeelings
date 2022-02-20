import Foundation

struct UserErrorResponse: Codable {
    var errors: [TwitterError]
}

struct TwitterError: Codable {
    var detail: String?
    var title: String?
}

extension TwitterError: Error, CustomStringConvertible {
    public var description: String {
        detail ?? "Não foi possível achar o usuário, tente novamente mais tarde"
    }
}

extension TwitterError: LocalizedError {
    public var errorDescription: String? {
        detail ?? "Não foi possível achar o usuário, tente novamente mais tarde"
    }
}
