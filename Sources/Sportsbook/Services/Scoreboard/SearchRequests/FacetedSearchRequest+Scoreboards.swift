import Foundation
import SCAN

extension FacetedSearchRequest {

    static func scoreboardEvents(withIDs eventIDs: [EventID], locale: Locale) -> Self {
        .init(
            facet: Facet(
                type: .event
            ),
            filter: FilterQuery(
                eventIDs: eventIDs
            ),
            locale: locale
        )
    }

}
