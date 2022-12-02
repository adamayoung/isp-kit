import Foundation
import ISPCore

enum EndpointBase {

    static func value(for environment: Environment) -> String {
        "https://cms-api.cms-\(environment.name).isp-pub.starsops.com"
    }

}
