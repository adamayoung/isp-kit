import AsyncHTTPClient
@testable import CMS
import XCTest

final class CMSTests: XCTestCase {

    static var httpClient: HTTPClient!

    var cms: CMS!
    var client: CMSClient!

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

        client = CMSClient(
            applicationID: EnvironmentVariable.applicationID,
            apiKey: EnvironmentVariable.apiKey,
            site: .uk,
            environment: .qaCore,
            httpClientProvider: .shared(Self.httpClient)
        )

        cms = CMS(client: client)
    }

    override func tearDown() {
        cms = nil
        client = nil
        super.tearDown()
    }

    func testNodesWhenUsingFeatureTagReturnsFeaturedItems() async throws {
        let request = NodesRequest(tag: .featured)
        let result = try await cms.nodes(request)

        XCTAssertGreaterThan(result.count, 0)
    }

}
