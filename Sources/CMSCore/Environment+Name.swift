import Foundation
import ISPCore

extension Environment {

    var name: String {
        switch self {
        case .qaCore:
            return "dev"

        case .qaRelease:
            return "qr"

        case .prod:
            return "prod"
        }
    }

}
