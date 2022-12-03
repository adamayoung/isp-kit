import AsyncHTTPClient
import Logging
@testable import Sportsbook
import XCTest

final class SportServiceTests: XCTestCase {

    static var httpClient: HTTPClient!

    var sportService: SportService!
    var scan: SCAN!
    var cms: CMS!
    var gbpClient: GBPClient!
    var cmsClient: CMSClient!

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
        let site = StarsSite.uk
        let environment = Environment.qaCore
        gbpClient = GBPClient(
            applicationID: EnvironmentVariable.gbpApplicationID,
            apiKey: EnvironmentVariable.gbpAPIKey,
            site: site,
            environment: environment,
            httpClientProvider: .shared(Self.httpClient)
        )
        cmsClient = CMSClient(
            applicationID: EnvironmentVariable.cmsApplicationID,
            apiKey: EnvironmentVariable.cmsAPIKey,
            site: site,
            environment: environment,
            httpClientProvider: .shared(Self.httpClient)
        )
        scan = SCAN(client: gbpClient)
        cms = CMS(client: cmsClient)

        sportService = SportService(scan: scan, cms: cms, logger: Logger(label: "Test"))
    }

    override func tearDown() {
        sportService = nil
        cms = nil
        scan = nil
        cmsClient = nil
        gbpClient = nil
        super.tearDown()
    }

    func testAll() async throws {
        let sports = try await sportService.all(locale: .current)
        XCTAssertGreaterThan(sports.count, 0)
    }

}
