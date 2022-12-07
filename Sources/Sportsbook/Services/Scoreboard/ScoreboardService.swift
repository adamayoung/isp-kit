import Foundation
import Logging
import SCA
import SCAN

public final class ScoreboardService {

    private let sca: SportsContentDataSource
    private let scan: CatalogueDataSource
    private let logger: Logger

    public convenience init(provider: ISPProvider) {
        self.init(
            sca: provider.sca,
            scan: provider.scan,
            logger: Logger(label: "isp-kit.sportsbook.scoreboard-service")
        )
    }

    init(sca: SportsContentDataSource, scan: CatalogueDataSource, logger: Logger) {
        self.sca = sca
        self.scan = scan
        self.logger = logger
    }

    func scoreboard(forFootballEvent eventID: EventID, locale: Locale = .current) async throws -> FootballScoreboard? {
        let scoreboards = try await scoreboards(forFootballEvents: [eventID])

        return scoreboards.first
    }

    func scoreboards(forFootballEvents eventIDs: [EventID],
                     locale: Locale = .current) async throws -> [FootballScoreboard] {
        logger.debug("Fetching Football Scoreboards.", metadata: ["event-ids": .stringConvertible(eventIDs)])

        let result = try await scan.search(.scoreboardEvents(withIDs: eventIDs, locale: locale))
        guard let eventAttachments = result.attachments.events?.values else {
            return []
        }

        let eventIDs = eventAttachments.compactMap { eventAttachment -> Int? in
            guard eventAttachment.sportID == Sport.ID.football else {
                return nil
            }

            return eventAttachment.eventID
        }

        let scaScoreboards = try await sca.scoreboards(forFootballEvents: eventIDs, locale: locale)

        let scoreboards = scaScoreboards.compactMap(FootballScoreboard.init)
        return scoreboards
    }

}
