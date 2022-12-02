import Foundation
import Logging
import StarsCore

public final class PSA {

    private static let sessionPath = "/api/v1-preview/auth/session"

    private let client: StarsClient
    private let logger: Logger

    public init(client: StarsClient, logger: Logger = Logger(label: "isp-kit.psa")) {
        self.client = client
        self.logger = logger
    }

    public func signIn(with credential: Credential) async throws -> UserSession {
        try await client.execute(path: Self.sessionPath, input: credential)
    }

    public func userInfo(token: String) async throws -> Account {
        Account(userId: "1", totalBalance: 1, totalBalanceInUsd: 1, email: "a", firstName: "a", lastName: "a",
                fullName: "a", selfExcluded: false)
    }

}
