import Foundation

enum EnvironmentVariable {

    static var gbpApplicationID: String {
        guard let value = environment["GBP_APPLICATION_ID"] else {
            fatalError("Missing GBP_APPLICATION_ID environment variable")
        }

        return value
    }

    static var gbpAPIKey: String {
        guard let value = environment["GBP_API_KEY"] else {
            fatalError("Missing GBP_API_KEY environment variable")
        }

        return value
    }

    static var cmsApplicationID: String {
        guard let value = environment["CMS_APPLICATION_ID"] else {
            fatalError("Missing CMS_APPLICATION_ID environment variable")
        }

        return value
    }

    static var cmsAPIKey: String {
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
