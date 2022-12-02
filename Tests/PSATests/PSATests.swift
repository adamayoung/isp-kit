import AsyncHTTPClient
@testable import PSA
import XCTest

final class PSATests: XCTestCase {

    static var httpClient: HTTPClient!

    var psa: PSA!
    var client: StarsClient!

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

        client = StarsClient(
            site: .uk,
            environment: .qaCore,
            httpClientProvider: .shared(Self.httpClient)
        )

        psa = PSA(client: client)
    }

    override func tearDown() {
        psa = nil
        client = nil
        super.tearDown()
    }

    func testSearchWhenSearchingForASingleEventTypeShouldReturnEventType() async throws {
        let credential = Credential.mock

        let userSession = try await psa.signIn(with: credential)

        XCTAssertEqual(userSession.account.userId, credential.userId)
    }

}
