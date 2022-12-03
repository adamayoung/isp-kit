import Foundation
import Logging
import SCAN

public final class MarketService {

    private let scan: CatalogueDataSource
    private let logger: Logger

    public convenience init(provider: ISPProvider) {
        self.init(
            scan: provider.scan,
            logger: Logger(label: "isp-kit.sportsbook.market-service")
        )
    }

    init(scan: CatalogueDataSource, logger: Logger) {
        self.scan = scan
        self.logger = logger
    }

    public func all(forEvent eventID: Event.ID, locale: Locale = .current) async throws -> [Market] {
        logger.debug("Fetching Markets", metadata: ["event-id": .stringConvertible(eventID)])

        let result = try await scan.search(.markets(forEvent: eventID, locale: locale))
        guard let marketAttachments = result.attachments.markets?.values else {
            return []
        }

        let markets = marketAttachments
            .compactMap(Market.init)
            .sorted { $0.name < $1.name }
            .sorted { $0.marketDate < $1.marketDate }

        return markets
    }

    public func all(forEvents eventIDs: [Event.ID], locale: Locale = .current) async throws -> [Event.ID: [Market]] {
        logger.debug("Fetching Markets", metadata: ["event-ids": .stringConvertible(eventIDs)])

        let result = try await scan.search(.markets(forEvents: eventIDs, locale: locale))
        guard let marketAttachments = result.attachments.markets?.values else {
            return [:]
        }

        var marketsDict = [Event.ID: [Market]]()
        marketAttachments.forEach { marketAttachment in
            var eventMarkets = marketsDict[marketAttachment.eventID, default: []]
            guard let market = Market(attachment: marketAttachment) else {
                return
            }

            eventMarkets.append(market)
            marketsDict[market.eventID] = eventMarkets
        }

        marketsDict.keys.forEach { eventID in
            marketsDict[eventID] = marketsDict[eventID]?
                .sorted { $0.name < $1.name }
                .sorted { $0.marketDate < $1.marketDate }
        }

        return marketsDict
    }

    public func find(withID id: Market.ID, locale: Locale = .current) async throws -> Market? {
        logger.debug("Fetching Market", metadata: ["id": .stringConvertible(id)])

        let result = try await scan.search(.markets(withID: id, locale: locale))
        guard let marketAttachment = result.attachments.markets?.first?.value else {
            return nil
        }

        let market = Market(attachment: marketAttachment)

        return market
    }

}
