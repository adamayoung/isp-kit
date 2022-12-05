import Foundation
import Logging
import SCAN

public final class EventService {

    private let scan: CatalogueDataSource
    private let logger: Logger

    public convenience init(provider: ISPProvider) {
        self.init(
            scan: provider.scan,
            logger: Logger(label: "isp-kit.sportsbook.event-service")
        )
    }

    init(scan: CatalogueDataSource, logger: Logger) {
        self.scan = scan
        self.logger = logger
    }

    public func all(forCompetition competitionID: Competition.ID, locale: Locale = .current) async throws -> [Event]? {
        logger.debug("Fetching Events.", metadata: ["competition-id": .stringConvertible(competitionID)])

        let result = try await scan.search(.events(forCompetition: competitionID, locale: locale))
        guard result.attachments.competitions?.first?.value.competitionID == competitionID else {
            return nil
        }

        guard let eventAttachments = result.attachments.events?.values else {
            return []
        }

        let events = eventAttachments
            .compactMap { Event(attachment: $0, facets: result.facets) }
            .sorted { $0.name < $1.name }
            .sorted { $0.openDate ?? Date() < $1.openDate ?? Date() }

        return events
    }

    public func all(forSport sportID: Sport.ID, isInPlay: Bool? = nil,
                    locale: Locale = .current) async throws -> [Event]? {
        var metadata: Logger.Metadata = [
            "sport-id": .stringConvertible(sportID)
        ]
        if let isInPlay = isInPlay {
            metadata["is-in-play"] = .stringConvertible(isInPlay)
        }

        logger.debug("Fetching Events.", metadata: metadata)

        let result = try await scan.search(.events(forSport: sportID, isInPlay: isInPlay, locale: locale))
        guard result.attachments.sports?.first?.value.sportID == sportID else {
            return nil
        }

        guard let eventAttachments = result.attachments.events?.values else {
            return []
        }

        let events = eventAttachments
            .compactMap { Event(attachment: $0, facets: result.facets) }
            .sorted { $0.name < $1.name }
            .sorted { $0.openDate ?? Date() < $1.openDate ?? Date() }

        return events
    }

    public func all(forSports sportIDs: [Sport.ID], isInPlay: Bool? = nil,
                    locale: Locale = .current) async throws -> [Sport.ID: [Event]] {
        var metadata: Logger.Metadata = [
            "sport-ids": .stringConvertible(sportIDs)
        ]
        if let isInPlay = isInPlay {
            metadata["is-in-play"] = .stringConvertible(isInPlay)
        }

        logger.debug("Fetching Events.", metadata: metadata)

        let result = try await scan.search(.events(forSports: sportIDs, isInPlay: isInPlay, locale: locale))
        guard let eventAttachments = result.attachments.events?.values else {
            return [:]
        }

        let sportAttachments = result.attachments.sports ?? [:]

        var eventsDict = [Sport.ID: [Event]]()
        sportIDs.forEach { sportID in
            if sportAttachments[String(sportID)] != nil {
                eventsDict[sportID] = []
            }
        }

        eventAttachments.forEach { eventAttachment in
            var sportEvents = eventsDict[eventAttachment.sportID, default: []]
            guard let event = Event(attachment: eventAttachment, facets: result.facets) else {
                return
            }

            sportEvents.append(event)
            eventsDict[event.sportID] = sportEvents
        }

        eventsDict.keys.forEach { sportID in
            eventsDict[sportID] = eventsDict[sportID]?
                .sorted { $0.name < $1.name }
                .sorted { $0.openDate ?? Date() < $1.openDate ?? Date() }
        }

        return eventsDict
    }

    public func outrights(forCompetition competitionID: Competition.ID,
                          locale: Locale = .current) async throws -> [Event]? {
        logger.debug("Fetching Outrights.", metadata: ["competition-id": .stringConvertible(competitionID)])

        let sportsResult = try await scan.search(.eventSport(forCompetition: competitionID, locale: locale))
        guard let sportAttachment = sportsResult.attachments.sports?.first?.value else {
            return nil
        }

        let result = try await scan.search(
            .outrights(forCompetition: competitionID, sport: sportAttachment.sportID, locale: locale)
        )
        guard let eventAttachments = result.attachments.events?.values else {
            return []
        }

        let events = eventAttachments
            .compactMap { Event(attachment: $0, facets: result.facets) }
            .sorted { $0.name < $1.name }
            .sorted { $0.openDate ?? Date() < $1.openDate ?? Date() }

        return events
    }

    public func find(withID id: Event.ID, locale: Locale = .current) async throws -> Event? {
        logger.debug("Fetching Event.", metadata: ["id": .stringConvertible(id)])

        let result = try await scan.search(.event(withID: id, locale: locale))
        guard let eventAttachment = result.attachments.events?.first?.value else {
            return nil
        }

        let event = Event(attachment: eventAttachment, facets: result.facets)

        return event
    }

    public func find(forMarket marketID: Market.ID, locale: Locale = .current) async throws -> Event? {
        logger.debug("Fetching Event.", metadata: ["market-id": .stringConvertible(marketID)])

        let result = try await scan.search(.events(forMarket: marketID, locale: locale))
        guard let eventAttachment = result.attachments.events?.first?.value else {
            return nil
        }

        let event = Event(attachment: eventAttachment, facets: result.facets)

        return event
    }

}
