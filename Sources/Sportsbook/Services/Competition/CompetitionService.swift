import CMS
import Foundation
import Logging
import SCAN

public final class CompetitionService {

    private let scan: CatalogueDataSource
    private let cms: ContentManagementDataSource
    private let logger: Logger

    public convenience init(provider: ISPProvider) {
        self.init(
            scan: provider.scan,
            cms: provider.cms,
            logger: Logger(label: "isp-kit.sportsbook.competition-service")
        )
    }

    init(scan: CatalogueDataSource, cms: ContentManagementDataSource, logger: Logger) {
        self.scan = scan
        self.cms = cms
        self.logger = logger
    }

    public func all(forSport sportID: Sport.ID, locale: Locale = .current) async throws -> [Competition]? {
        logger.debug("Fetching Competitions", metadata: ["sport-id": .stringConvertible(sportID)])

        let result = try await scan.search(.competitions(forSport: sportID, locale: locale))
        guard result.attachments.sports?.first?.value.sportID == sportID else {
            return nil
        }

        guard let competitionAttachments = result.attachments.competitions?.values else {
            return []
        }

        let competitions = competitionAttachments
            .compactMap(Competition.init)
            .sorted { $0.name < $1.name }

        return competitions
    }

    public func featured(forSport sportID: Sport.ID?, locale: Locale = .current) async throws -> [Competition] {
        logger.debug("Fetching featured Competitions")

        let competitionIDs = try await cms.nodes(.featuredCompetitions(locale: locale))
            .compactMap { Int($0.competitionID ?? "") }

        guard !competitionIDs.isEmpty else {
            return []
        }

        let result = try await scan.search(.competitions(withIDs: competitionIDs, locale: locale))

        guard let competitionAttachments = result.attachments.competitions else {
            return []
        }

        let competitions = competitionIDs
            .compactMap { competitionID -> Competition? in
                guard let attachment = competitionAttachments[String(competitionID)] else {
                    return nil
                }

                return Competition(attachment: attachment)
            }

        return competitions
    }

    public func popular(forSport sportID: Sport.ID?, locale: Locale = .current) async throws -> [Competition] {
        logger.debug("Fetching popular Competitions")

        let competitionIDs = try await cms.nodes(.popularCompetitions(locale: locale))
            .compactMap { Int($0.competitionID ?? "") }

        guard !competitionIDs.isEmpty else {
            return []
        }

        let result = try await scan.search(.competitions(withIDs: competitionIDs, locale: locale))

        guard let competitionAttachments = result.attachments.competitions else {
            return []
        }

        let competitions = competitionIDs
            .compactMap { competitionID -> Competition? in
                guard let attachment = competitionAttachments[String(competitionID)] else {
                    return nil
                }

                return Competition(attachment: attachment)
            }

        return competitions
    }

    public func find(withID id: Competition.ID, locale: Locale = .current) async throws -> Competition? {
        logger.debug("Fetching Competition", metadata: ["id": .stringConvertible(id)])

        let result = try await scan.search(.competitions(withID: id, locale: locale))
        guard let competitionAttachment = result.attachments.competitions?.first?.value else {
            return nil
        }

        let competition = Competition(attachment: competitionAttachment)

        return competition
    }

    public func find(forEvent eventID: Event.ID, locale: Locale = .current) async throws -> Competition? {
        logger.debug("Fetching Competition", metadata: ["event-id": .stringConvertible(eventID)])

        let result = try await scan.search(.competitions(forEvent: eventID, locale: locale))
        guard let competitionAttachment = result.attachments.competitions?.first?.value else {
            return nil
        }

        let competition = Competition(attachment: competitionAttachment)

        return competition
    }

}
