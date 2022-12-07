import Foundation
import NIOHTTP1

extension HTTPHeaders {

    public struct Name: CustomStringConvertible, Equatable, Hashable {

        private let name: String

        public init(_ name: String) {
            self.name = name
        }

        public init(stringLiteral: String) {
            self.init(stringLiteral)
        }

        public var description: String {
            name
        }

        public static let host = Name("Host")
        public static let userAgent = Name("User-Agent")
        public static let contentType = Name("Content-Type")
        public static let accept = Name("Accept")
        public static let acceptLanguage = Name("Accept-Language")

        public static let applicationID = Name("X-Application")
        public static let starsSiteID = Name("X-Stars-Site")
        public static let authentication = Name("X-Authentication")

    }

    public init(_ headers: [(HTTPHeaders.Name, String)]) {
        let headers = headers.map { ($0.0, $0.1) }
        self.init(headers)
    }

    public mutating func add(_ name: HTTPHeaders.Name, value: String) {
        self.add(name: name.description, value: value)
    }

}
