import AsyncHTTPClient
@testable import SCA
import XCTest

final class SCATests: XCTestCase {

    static var httpClient: HTTPClient!

    var sca: SCA!
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

        sca = SCA(client: client)
    }

    override func tearDown() {
        sca = nil
        client = nil
        super.tearDown()
    }

    func testScoreboardForFootballEvent() async throws {
        let eventID = 31672776

        let scoreboard = try await sca.scoreboard(forFootballEvent: eventID, locale: .current)

        XCTAssertEqual(scoreboard?.id, String(eventID))
    }

}
