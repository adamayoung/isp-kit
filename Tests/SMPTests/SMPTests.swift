import AsyncHTTPClient
@testable import SMP
import XCTest

final class SMPTests: XCTestCase {

    static var httpClient: HTTPClient!

    var smp: SMP!
    var client: GBPHTTPClient!

    override class func setUp() {
        super.setUp()
        httpClient = HTTPClient(
            eventLoopGroupProvider: .createNew,
            configuration: .init(
                timeout: .init(connect: .seconds(10))
            )
        )
    }

    override class func tearDown() {
        Task {
            try await httpClient.shutdown()
        }

        super.tearDown()
    }

    override func setUp() {
        super.setUp()

        client = GBPHTTPClient(
            applicationID: EnvironmentVariable.applicationID,
            apiKey: EnvironmentVariable.apiKey,
            site: .uk,
            environment: .qaCore,
            httpClientProvider: .shared(Self.httpClient)
        )

        smp = SMP(client: client)
    }

    override func tearDown() {
        smp = nil
        client = nil
        super.tearDown()
    }

    func testMarketPricesWhenSearchingForAMarketsPricesShouldReturnPrices() async throws {
        let marketID = "501.43595890"
        let request = MarketPricesRequest(marketID: marketID)

        let result = try await smp.marketPrices(request)

        let marketDetails = try XCTUnwrap(result.first)

        XCTAssertEqual(marketDetails.marketID, marketID)
    }

}
