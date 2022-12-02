import Foundation

enum EnvironmentVariable {

    static var applicationID: String {
        guard let value = environment["GBP_APPLICATION_ID"] else {
            fatalError("Missing GBP_APPLICATION_ID environment variable")
        }

        return value
    }

    static var apiKey: String {
        guard let value = environment["GBP_API_KEY"] else {
            fatalError("Missing GBP_API_KEY environment variable")
        }

        return value
    }

}

extension EnvironmentVariable {

    private static var environment: [String: String] {
        ProcessInfo.processInfo.environment
    }

}
