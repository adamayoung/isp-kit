import Foundation

enum EnvironmentVariable {

    static var applicationID: String {
        guard let value = environment["CMS_APPLICATION_ID"] else {
            fatalError("Missing CMS_APPLICATION_ID environment variable")
        }

        return value
    }

    static var apiKey: String {
        guard let value = environment["CMS_API_KEY"] else {
            fatalError("Missing CMS_API_KEY environment variable")
        }

        return value
    }

}

extension EnvironmentVariable {

    private static var environment: [String: String] {
        ProcessInfo.processInfo.environment
    }

}
