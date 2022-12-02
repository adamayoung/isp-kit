import Foundation

public struct Credential: Encodable {

    public let userId: String
    public let password: String
    public let pin: String?
    public let installId: String

    public init(userId: String, password: String, pin: String? = nil, installId: String) {
        self.userId = userId
        self.password = password
        self.pin = pin
        self.installId = installId
    }

}
