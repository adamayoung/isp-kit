import Foundation

public enum StarsSite: String {

    case uk

}

extension StarsSite {

    public var id: String {
        switch self {
        case .uk:
            return "32768"
        }
    }

    public var code: String {
        rawValue.uppercased()
    }

    public var countryCode: String {
        switch self {
        case .uk:
            return "GB"
        }
    }

}
