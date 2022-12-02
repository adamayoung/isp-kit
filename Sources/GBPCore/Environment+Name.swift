import Foundation
import ISPCore

extension Environment {

    var name: String {
        switch self {
        case .qaCore:
            return "qacore"

        case .qaRelease:
            return "qarelease"

        case .prod:
            return "prod"
        }
    }

}
