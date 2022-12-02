import Foundation
import ISPCore
import NIOHTTP1

extension HTTPHeaders.Name {

    static let tlaAPIKey = HTTPHeaders.Name("ISP-TLA-Header")
    static let ip = HTTPHeaders.Name("X-IP")
    static let ips = HTTPHeaders.Name("X-IPS")

}
