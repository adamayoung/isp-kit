import Foundation
import ISPCore

public enum EndpointBase {

    public static func value(for tla: TLA, environment: Environment) -> String {
        "https://\(tla.rawValue).gbp-\(environment.name).isp-pub.starsops.com"
    }

}
