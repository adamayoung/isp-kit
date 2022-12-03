import CMS
import Foundation

extension NodesRequest {

    static func featuredSports(locale: Locale) -> Self {
        .init(
            tag: .featured,
            liveAtDate: Date(),
            type: .sport,
            locale: locale
        )
    }

    static func popularSports(locale: Locale) -> Self {
        .init(
            tag: .popular,
            liveAtDate: Date(),
            type: .sport,
            locale: locale
        )
    }

}
