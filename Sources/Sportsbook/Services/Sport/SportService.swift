import CMS
import Foundation
import Logging
import SCAN

public final class SportService {

    private let scan: CatalogueDataSource
    private let cms: ContentManagementDataSource
    private let logger: Logger

    public convenience init(provider: ISPProvider) {
        self.init(
            scan: provider.scan,
            cms: provider.cms,
            logger: Logger(label: "isp-kit.sportsbook.sport-service")
        )
    }

    init(scan: CatalogueDataSource, cms: ContentManagementDataSource, logger: Logger) {
        self.scan = scan
        self.cms = cms
        self.logger = logger
    }

    public func all(locale: Locale = .current) async throws -> [Sport] {
        logger.debug("Fetching Sports.")

        let result = try await scan.search(.sports(locale: locale))
        guard let sportAttachments = result.attachments.sports?.values else {
            return []
        }

        let sports = sportAttachments
            .compactMap(Sport.init)
            .sorted { $0.name < $1.name }

        return sports
    }

    public func featured(locale: Locale = .current) async throws -> [Sport] {
        logger.debug("Fetching featured Sports.")

        let nodes = try await cms.nodes(.featuredSports(locale: locale))
        let sports = nodes.compactMap(Sport.init)

        return sports
    }

    public func popular(locale: Locale = .current) async throws -> [Sport] {
        logger.debug("Fetching popular Sports.")

        let nodes = try await cms.nodes(.popularSports(locale: locale))
        let sports = nodes.compactMap(Sport.init)

        return sports
    }

    public func find(withID id: Sport.ID, locale: Locale = .current) async throws -> Sport? {
        logger.debug("Fetching Sport.", metadata: ["id": .stringConvertible(id)])

        let result = try await scan.search(.sports(withID: id, locale: locale))
        guard let sportAttachment = result.attachments.sports?.first?.value else {
            return nil
        }

        let sport = Sport(attachment: sportAttachment)

        return sport
    }

    public func find(forCompetition competitionID: Competition.ID, locale: Locale = .current) async throws -> Sport? {
        logger.debug("Fetching Sport.", metadata: ["competition-id": .stringConvertible(competitionID)])

        let result = try await scan.search(.sports(forCompetition: competitionID, locale: locale))
        guard let sportAttachment = result.attachments.sports?.first?.value else {
            return nil
        }

        let sport = Sport(attachment: sportAttachment)

        return sport
    }

    public func find(forEvent eventID: Event.ID, locale: Locale = .current) async throws -> Sport? {
        logger.debug("Fetching Sport.", metadata: ["event-id": .stringConvertible(eventID)])

        let result = try await scan.search(.sports(forEvent: eventID, locale: locale))
        guard let sportAttachment = result.attachments.sports?.first?.value else {
            return nil
        }

        let sport = Sport(attachment: sportAttachment)

        return sport
    }

}
