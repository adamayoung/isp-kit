import CMS
import Foundation

extension NodesRequest {

    static func featuredCompetitions(locale: Locale) -> Self {
        .init(
            tag: .featured,
            liveAtDate: Date(),
            type: .competition,
            locale: locale
        )
    }

    static func popularCompetitions(locale: Locale) -> Self {
        .init(
            tag: .popular,
            liveAtDate: Date(),
            type: .competition,
            locale: locale
        )
    }

}
