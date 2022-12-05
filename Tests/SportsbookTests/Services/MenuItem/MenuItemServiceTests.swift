import AsyncHTTPClient
@testable import Sportsbook
import Logging
import XCTest

final class MenuItemServiceTests: XCTestCase {

    static var httpClient: HTTPClient!

    var menuItemService: MenuItemService!
    var scan: SCAN!
    var cms: CMS!
    var gbpClient: GBPHTTPClient!
    var cmsClient: CMSHTTPClient!

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
        gbpClient = GBPHTTPClient(
            applicationID: EnvironmentVariable.gbpApplicationID,
            apiKey: EnvironmentVariable.gbpAPIKey,
            site: site,
            environment: environment,
            httpClientProvider: .shared(Self.httpClient)
        )
        cmsClient = CMSHTTPClient(
            applicationID: EnvironmentVariable.cmsApplicationID,
            apiKey: EnvironmentVariable.cmsAPIKey,
            site: site,
            environment: environment,
            httpClientProvider: .shared(Self.httpClient)
        )
        scan = SCAN(client: gbpClient)
        cms = CMS(client: cmsClient)

        menuItemService = MenuItemService(cms: cms, scan: scan, logger: Logger(label: "Test"))
    }

    override func tearDown() {
        menuItemService = nil
        cms = nil
        scan = nil
        cmsClient = nil
        gbpClient = nil
        super.tearDown()
    }

    func testFeatured() async throws {
        let menuItems = try await menuItemService.featured()

        print(menuItems)

        XCTAssertGreaterThan(menuItems.count, 0)
    }

    func testPopular() async throws {
        let menuItems = try await menuItemService.popular()

        print(menuItems)

        XCTAssertGreaterThan(menuItems.count, 0)
    }

    func testAToZ() async throws {
        let menuItems = try await menuItemService.aToZ()

        print(menuItems)

        XCTAssertGreaterThan(menuItems.count, 0)
    }

    func testMenuItemCollection() async throws {
        let menuItemGroups = try await menuItemService.menuItemCollection()

        print(menuItemGroups)

        XCTAssertGreaterThan(menuItemGroups.count, 0)
    }

}
