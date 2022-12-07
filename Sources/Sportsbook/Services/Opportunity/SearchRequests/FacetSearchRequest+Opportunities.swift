import Foundation
import SCAN

extension FacetedSearchRequest {

    static func opportunityMarkets(withIDs marketIDs: [MarketID], locale: Locale) -> Self {
        .init(
            facet: Facet(
                type: .sport,
                next: Facet(
                    type: .competition,
                    next: Facet(
                        type: .event,
                        next: Facet(
                            type: .market
                        )
                    )
                )
            ),
            filter: FilterQuery(
                marketIDs: marketIDs,
                selectBy: .firstToStart
            ),
            locale: locale
        )
    }

}
