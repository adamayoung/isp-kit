import CMS
import Foundation

extension NodesRequest {

    static func featuredMenuItems(locale: Locale) -> Self {
        .init(
            tag: .featured,
            liveAtDate: Date(),
            locale: locale
        )
    }

    static func popularMenuItems(locale: Locale) -> Self {
        .init(
            tag: .featured,
            liveAtDate: Date(),
            locale: locale
        )
    }

    static func aToZMenuItems(locale: Locale) -> Self {
        .init(
            liveAtDate: Date(),
            type: .sport,
            locale: locale
        )
    }

}
