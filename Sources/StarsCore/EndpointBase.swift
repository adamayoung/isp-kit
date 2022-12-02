import Foundation
import ISPCore

enum EndpointBase {

    static func value(for site: StarsSite, environment: Environment) -> String {
        switch environment {
        case .qaCore:
            return "https://www.pokerstars.\(site.rawValue).qc-sports-mt1.starsweb.io"

        case .qaRelease:
            return "https://www.pokerstars.\(site.rawValue).qr-sports1.starsweb.io"

        case .prod:
            return "https://www.pokerstars.\(site.rawValue)"
        }
    }

}
