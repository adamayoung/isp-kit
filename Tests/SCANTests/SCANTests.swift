import AsyncHTTPClient
@testable import SCAN
import XCTest

final class SCANTests: XCTestCase {

    static var httpClient: HTTPClient!

    var scan: SCAN!
    var client: GBPClient!

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

        client = GBPClient(
            applicationID: EnvironmentVariable.applicationID,
            apiKey: EnvironmentVariable.apiKey,
            site: .uk,
            environment: .qaCore,
            httpClientProvider: .shared(Self.httpClient)
        )

        scan = SCAN(client: client)
    }

    override func tearDown() {
        scan = nil
        client = nil
        super.tearDown()
    }

    func testSearchWhenSearchingForASingleSportShouldReturnSport() async throws {
        let sportID: SportID = 1
        let searchRequest = FacetedSearchRequest(
            facet: Facet(type: .sport),
            filter: FilterQuery(
                sportIDs: [sportID],
                maxResults: 1
            )
        )

        let result = try await scan.search(searchRequest)

        let sport = try XCTUnwrap(result.attachments.sports?.first?.value)

        XCTAssertEqual(sport.sportID, sportID)
    }

}
