import Foundation
import SCAN

extension FacetedSearchRequest {

    static func event(withID eventID: EventID, locale: Locale) -> Self {
        .init(
            facet: Facet(
                type: .event,
                next: Facet(
                    type: .inPlay,
                    next: Facet(
                        type: .canTurnInPlay
                    )
                )
            ),
            filter: FilterQuery(
                eventIDs: [eventID],
                maxResults: 1
            ),
            locale: locale
        )
    }

    static func events(forCompetition competitionID: CompetitionID, locale: Locale) -> Self {
        .init(
            facet: Facet(
                type: .sport,
                next: Facet(
                    type: .competition,
                    next: Facet(
                        type: .event,
                        next: Facet(
                            type: .inPlay,
                            next: Facet(
                                type: .canTurnInPlay
                            )
                        )
                    )
                )
            ),
            filter: FilterQuery(
                competitionIDs: [competitionID],
                marketLevels: [.avbEvent]
            ),
            locale: locale
        )
    }

    static func events(forSport sportID: SportID, isInPlay: Bool? = nil, locale: Locale) -> Self {
        events(forSports: [sportID], isInPlay: isInPlay, locale: locale)
    }

    static func events(forSports sportIDs: [SportID], isInPlay: Bool? = nil, locale: Locale) -> Self {
        .init(
            facet: Facet(
                type: .sport,
                next: Facet(
                    type: .competition,
                    next: Facet(
                        type: .event,
                        next: Facet(
                            type: .inPlay,
                            next: Facet(
                                type: .canTurnInPlay
                            )
                        )
                    )
                )
            ),
            filter: FilterQuery(
                sportIDs: sportIDs,
                turnInPlayEnabled: isInPlay == true ? true : nil,
                marketStartingBefore:
                    isInPlay == true ? Date().addingTimeInterval(30) : Date().addingTimeInterval(60 * 24),
                marketLevels: isInPlay == true ? nil : nil
            ),
            locale: locale
        )
    }

    static func events(forMarket marketID: MarketID, locale: Locale) -> Self {
        .init(
            facet: Facet(
                type: .event,
                next: Facet(
                    type: .inPlay,
                    next: Facet(
                        type: .canTurnInPlay
                    )
                )
            ),
            filter: FilterQuery(
                marketIDs: [marketID],
                maxResults: 0
            ),
            locale: locale
        )
    }

    static func eventSport(forCompetition competitionID: CompetitionID, locale: Locale) -> Self {
        .init(
            facet: Facet(
                type: .sport
            ),
            filter: FilterQuery(
                competitionIDs: [competitionID],
                maxResults: 0
            ),
            locale: locale
        )
    }

    static func outrights(forCompetition competitionID: CompetitionID, sport sportID: SportID, locale: Locale) -> Self {
        let competitionMarketLevelOnlySportIDs = [Sport.ID.golf]
        let marketLevels: [MarketLevel] = {
            if competitionMarketLevelOnlySportIDs.contains(sportID) {
                return [.competition]
            }

            return [.competition, .subCompetition]
        }()

        return .init(
            facet: Facet(
                type: .sport,
                next: Facet(
                    type: .competition,
                    next: Facet(
                        type: .event
                    )
                )
            ),
            filter: FilterQuery(
                competitionIDs: [competitionID],
                marketLevels: marketLevels
            ),
            locale: locale
        )
    }

}
