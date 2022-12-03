import Foundation
import SCAN

extension FacetedSearchRequest {

    static func sports(withID id: SportID, locale: Locale) -> Self {
        .init(
            facet: Facet(type: .sport),
            filter: FilterQuery(
                sportIDs: [id],
                maxResults: 1
            ),
            locale: locale
        )
    }

    static func sports(withIDs ids: [SportID], locale: Locale) -> Self {
        .init(
            facet: Facet(type: .sport),
            filter: FilterQuery(
                sportIDs: ids,
                maxResults: 0
            ),
            locale: locale
        )
    }

    static func sports(locale: Locale) -> Self {
        .init(
            facet: Facet(type: .sport),
            filter: FilterQuery(
                productTypes: [.sportsbook],
                maxResults: 0
            ),
            locale: locale
        )
    }

    static func sports(forCompetition competitionID: CompetitionID, locale: Locale) -> Self {
        .init(
            facet: Facet(type: .sport),
            filter: FilterQuery(
                competitionIDs: [competitionID],
                maxResults: 0
            ),
            locale: locale
        )
    }

    static func sports(forEvent eventID: EventID, locale: Locale) -> Self {
        .init(
            facet: Facet(type: .sport),
            filter: FilterQuery(
                eventIDs: [eventID],
                maxResults: 0
            ),
            locale: locale
        )
    }

}
