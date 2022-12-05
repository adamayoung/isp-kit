import Foundation
import Logging
import SMP

public final class MarketPriceService {

    private let smp: MarketPricesDataSource
    private let logger: Logger

    public convenience init(provider: ISPProvider) {
        self.init(
            smp: provider.smp,
            logger: Logger(label: "isp-kit.sportsbook.market-price-service")
        )
    }

    init(smp: MarketPricesDataSource, logger: Logger) {
        self.smp = smp
        self.logger = logger
    }

    public func find(forMarket marketID: Market.ID, locale: Locale = .current) async throws -> MarketPrice? {
        logger.debug("Fetching Market Price.", metadata: ["market-ids": .string(marketID)])

        let request = MarketPricesRequest(marketID: marketID, locale: locale)
        guard let marketDetails = try await smp.marketPrices(request).first else {
            return nil
        }

        let marketPrice = MarketPrice(marketDetails: marketDetails)

        return marketPrice
    }

    public  func find(forMarkets marketIDs: [Market.ID], locale: Locale = .current) async throws -> [MarketPrice] {
        logger.debug("Fetching Market Prices.", metadata: ["market-ids": .string(marketIDs.joined(separator: ", "))])

        let request = MarketPricesRequest(marketIDs: marketIDs, locale: locale)
        let marketDetails = try await smp.marketPrices(request)

        let marketPrices = marketDetails.compactMap(MarketPrice.init)

        return marketPrices
    }

}
