import Foundation

public struct UserSession: Decodable {

    public let userIntId: Int
    public let token: String
    public let signature: String
    public let account: Account

    public init(userIntId: Int, token: String, signature: String, account: Account) {
        self.userIntId = userIntId
        self.token = token
        self.signature = signature
        self.account = account
    }

}
