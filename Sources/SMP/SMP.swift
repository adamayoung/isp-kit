import Foundation
import GBPCore
import Logging

public final class SMP: MarketPricesDataSource {

    private static let marketPricesPath = "/www/sports/fixedodds/readonly/v1/getMarketPrices?priceHistory=1"

    private let client: GBPHTTPClient
    private let logger: Logger

    public init(client: GBPHTTPClient, logger: Logger = Logger(label: "isp-kit.smp")) {
        self.client = client
        self.logger = logger
    }

    public func marketPrices(_ request: MarketPricesRequest) async throws -> [MarketDetails] {
        logger.debug("Fetching market prices from SMP.",
                     metadata: ["request": .stringConvertible(request)])

        return try await client.execute(path: Self.marketPricesPath, tla: .smp, input: request, locale: request.locale)
    }

}
