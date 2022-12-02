import Foundation

enum EnvironmentVariable {

    static var userID: String {
        guard let value = environment["ACCOUNT_USER_ID"] else {
            fatalError("Missing ACCOUNT_USER_ID environment variable")
        }

        return value
    }

    static var password: String {
        guard let value = environment["ACCOUNT_PASSWORD"] else {
            fatalError("Missing ACCOUNT_PASSWORD environment variable")
        }

        return value
    }

}

extension EnvironmentVariable {

    private static var environment: [String: String] {
        ProcessInfo.processInfo.environment
    }

}
