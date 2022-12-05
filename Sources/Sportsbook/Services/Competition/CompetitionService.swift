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
        let metadata: Logger.Metadata = [
            "sport-id": .stringConvertible(sportID),
            "locale": .string(locale.identifier)
        ]
        logger.debug("Fetching Competitions.", metadata: metadata)

        let result = try await scan.search(.competitions(forSport: sportID, locale: locale))
        guard result.attachments.sports?.first?.value.sportID == sportID else {
            logger.info("Sport with ID \(sportID) not found.")
            return nil
        }

        guard let competitionAttachments = result.attachments.competitions?.values else {
            logger.info("No competitions found for Sport with ID \(sportID).")
            return []
        }

        let competitions = competitionAttachments
            .compactMap(Competition.init)
            .sorted { $0.name < $1.name }

        return competitions
    }

    public func featured(forSport sportID: Sport.ID?, locale: Locale = .current) async throws -> [Competition] {
        var metadata: Logger.Metadata = [:]
        if let sportID {
            metadata["sport-id"] = .stringConvertible(sportID)
        }

        metadata["locale"] = .string(locale.identifier)
        logger.debug("Fetching featured Competitions.", metadata: metadata)

        let competitionIDs = try await cms.nodes(.featuredCompetitions(locale: locale))
            .compactMap { Int($0.competitionID ?? "") }

        guard !competitionIDs.isEmpty else {
            if let sportID {
                logger.info("No featured Competitions found in CMS for Sport with ID \(sportID).")
            } else {
                logger.info("No featured Competitions found in CMS.")
            }

            return []
        }

        let result = try await scan.search(.competitions(withIDs: competitionIDs, locale: locale))
        guard let competitionAttachments = result.attachments.competitions else {
            if let sportID {
                logger.info("No featured Competitions found for Sport with ID \(sportID).")
            } else {
                logger.info("No featured Competitions found.")
            }

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
        var metadata: Logger.Metadata = [:]
        if let sportID {
            metadata["sport-id"] = .stringConvertible(sportID)
        }

        metadata["locale"] = .string(locale.identifier)
        logger.debug("Fetching popular Competitions.", metadata: metadata)

        let competitionIDs = try await cms.nodes(.popularCompetitions(locale: locale))
            .compactMap { Int($0.competitionID ?? "") }

        guard !competitionIDs.isEmpty else {
            if let sportID {
                logger.info("No popular Competitions found in CMS for Sport with ID \(sportID).")
            } else {
                logger.info("No popular Competitions found in CMS.")
            }

            return []
        }

        let result = try await scan.search(.competitions(withIDs: competitionIDs, locale: locale))
        guard let competitionAttachments = result.attachments.competitions else {
            if let sportID {
                logger.info("No popular Competitions found for Sport with ID \(sportID).")
            } else {
                logger.info("No popular Competitions found.")
            }

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
        let metadata: Logger.Metadata = [
            "id": .stringConvertible(id),
            "locale": .string(locale.identifier)
        ]
        logger.debug("Fetching Competition.", metadata: metadata)

        let result = try await scan.search(.competitions(withID: id, locale: locale))
        guard let competitionAttachment = result.attachments.competitions?.first?.value else {
            logger.info("Competition with ID \(id) not found.")
            return nil
        }

        let competition = Competition(attachment: competitionAttachment)

        return competition
    }

    public func find(forEvent eventID: Event.ID, locale: Locale = .current) async throws -> Competition? {
        logger.debug("Fetching Competition.", metadata: ["event-id": .stringConvertible(eventID)])

        let result = try await scan.search(.competitions(forEvent: eventID, locale: locale))
        guard let competitionAttachment = result.attachments.competitions?.first?.value else {
            logger.info("Competition for Event with ID \(eventID) not found.")
            return nil
        }

        let competition = Competition(attachment: competitionAttachment)

        return competition
    }

    public func groups(forSport sportID: Sport.ID, locale: Locale = .current) async throws -> [CompetitionGroup] {
        logger.debug("Fetching Competition Groups", metadata: ["sport-id": .stringConvertible(sportID)])

        let cmsGroupings = try await cms.groupings(.competitions(forSport: sportID, locale: locale))
        guard !cmsGroupings.isEmpty else {
            logger.info("No Competition Groups found for Sport with ID \(sportID).")
            return []
        }

        let competitionIDs = cmsGroupings.flatMap {
            $0.nodes.compactMap { node -> Int? in
                guard let competitionID = node.competitionID else {
                    return nil
                }

                return Competition.ID(competitionID)
            }
        }

        guard !competitionIDs.isEmpty else {
            logger.info("Competition Groups empty for Sport with ID \(sportID).")
            return []
        }

        let result = try await scan.search(.competitions(withIDs: competitionIDs, locale: locale))
        guard let competitionAttachments = result.attachments.competitions else {
            return []
        }

        let competitionGroup = cmsGroupings.map { cmsGrouping in
            CompetitionGroup(
                id: cmsGrouping.id,
                name: cmsGrouping.name,
                competitions: cmsGrouping.nodes.compactMap { node in
                    guard
                        let competitionID = node.competitionID,
                        let competitionAttachment = competitionAttachments[competitionID]
                    else {
                        return nil
                    }

                    return Competition(attachment: competitionAttachment)
                }
            )
        }

        return competitionGroup
    }

}
