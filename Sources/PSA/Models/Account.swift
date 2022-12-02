import Foundation

public struct Account: Decodable {

    public let userId: String
    public let totalBalance: Int
    public let totalBalanceInUsd: Int
    public let email: String
    public let firstName: String
    public let middleName: String?
    public let lastName: String
    public let fullName: String
    public let selfExcluded: Bool

    public init(userId: String, totalBalance: Int, totalBalanceInUsd: Int, email: String, firstName: String,
                middleName: String? = nil, lastName: String, fullName: String, selfExcluded: Bool) {
        self.userId = userId
        self.totalBalance = totalBalance
        self.totalBalanceInUsd = totalBalanceInUsd
        self.email = email
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
        self.fullName = fullName
        self.selfExcluded = selfExcluded
    }

}
