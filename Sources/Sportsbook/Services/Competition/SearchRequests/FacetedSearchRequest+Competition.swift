import Foundation
import SCAN

extension FacetedSearchRequest {

    static func competitions(forSport sportID: SportID, locale: Locale) -> Self {
        .init(
            facet: Facet(
                type: .sport,
                next: Facet(type: .competition)
            ),
            filter: FilterQuery(
                sportIDs: [sportID],
                selectBy: .firstToStart
            ),
            locale: locale
        )
    }

    static func competitions(withID competitionID: CompetitionID, locale: Locale) -> Self {
        .init(
            facet: Facet(type: .competition),
            filter: FilterQuery(
                competitionIDs: [competitionID],
                maxResults: 1
            ),
            locale: locale
        )
    }

    static func competitions(withIDs competitionIDs: [CompetitionID], locale: Locale) -> Self {
        .init(
            facet: Facet(type: .competition),
            filter: FilterQuery(
                competitionIDs: competitionIDs
            ),
            locale: locale
        )
    }

    static func competitions(forEvent eventID: EventID, locale: Locale) -> Self {
        .init(
            facet: Facet(
                type: .event,
                next: Facet(type: .competition)
            ),
            filter: FilterQuery(
                eventIDs: [eventID],
                selectBy: .firstToStart,
                maxResults: 1
            ),
            locale: locale
        )
    }

}
