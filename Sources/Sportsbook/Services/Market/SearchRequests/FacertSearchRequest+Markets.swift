import Foundation
import SCAN

extension FacetedSearchRequest {

    static func markets(withID marketID: MarketID, locale: Locale) -> Self {
        .init(
            facet: Facet(type: .market),
            filter: FilterQuery(
                marketIDs: [marketID]
            ),
            locale: locale
        )
    }

    static func markets(forEvent eventID: EventID, marketTypes: [String]? = nil, locale: Locale) -> Self {
        markets(forEvents: [eventID], marketTypes: marketTypes, locale: locale)
    }

    static func markets(forEvents eventIDs: [EventID], marketTypes: [String]? = nil, locale: Locale) -> Self {
        .init(
            facet: Facet(type: .market),
            filter: FilterQuery(
                eventIDs: eventIDs,
                marketTypeCodes: marketTypes
            ),
            locale: locale
        )
    }

}
