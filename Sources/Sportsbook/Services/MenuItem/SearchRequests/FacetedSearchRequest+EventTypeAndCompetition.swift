import Foundation
import SCAN

extension FacetedSearchRequest {

    static func sports(withIDs sportIDs: [SportID], andCompetitionsWithIDs competitionIDs: [CompetitionID],
                       locale: Locale) -> Self {
        .init(
            facets: [
                Facet(type: .sport),
                Facet(type: .competition)
            ],
            filter: FilterQuery(
                sportIDs: sportIDs,
                competitionIDs: competitionIDs
            ),
            locale: locale
        )
    }

}
