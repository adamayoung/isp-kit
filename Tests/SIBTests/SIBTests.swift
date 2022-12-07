import AsyncHTTPClient
@testable import SIB
import XCTest

final class SIBTests: XCTestCase {

    static var httpClient: HTTPClient!

    var sib: SIB!
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

        sib = SIB(client: client)
    }

    override func tearDown() {
        sib = nil
        client = nil
        super.tearDown()
    }

    func testImplyBetsReturnsResult() async throws {
        let request = ImplyBetsRequest(
            betLegs: [
                BetLeg(
                    betRunners: [
                        BetLegRunner(
                            runner: Runner(marketID: "501.25334285", selectionID: 69821)
                        )
                    ]
                )
            ]
        )

        let result = try await sib.implyBets(request)

        XCTAssertGreaterThan(result.betCombinations.count, 0)
    }

}
