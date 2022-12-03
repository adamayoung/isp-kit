import Foundation

public protocol MarketPricesDataSource {

    func marketPrices(_ request: MarketPricesRequest) async throws -> [MarketDetails]

}
