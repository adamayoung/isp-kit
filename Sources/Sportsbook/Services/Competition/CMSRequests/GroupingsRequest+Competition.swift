import CMS
import Foundation

extension GroupingsRequest {

    static func competitions(forSport sportID: Sport.ID, locale: Locale) -> Self {
        .init(
            nodeType: .competition,
            sportID: sportID,
            liveAtDate: Date()
        )
    }

}
