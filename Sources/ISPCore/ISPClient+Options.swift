import Foundation
import NIOHTTP1

extension ISPClient {

    public struct Options {

        public let method: HTTPMethod
        public let headers: HTTPHeaders

        public init(method: HTTPMethod, headers: HTTPHeaders = HTTPHeaders()) {
            self.method = method
            self.headers = headers
        }

    }

}
