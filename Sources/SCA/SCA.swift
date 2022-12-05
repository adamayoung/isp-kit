import Foundation
import GBPCore
import Logging

public final class SCA: SportsContentDataSource {

    private static let graphQLPath = "/graphql"

    private let client: GBPHTTPClient
    private let logger: Logger

    public init(client: GBPHTTPClient, logger: Logger = Logger(label: "isp-kit.sca")) {
        self.client = client
        self.logger = logger
    }

//    public func scoreboard(forFootballEvent eventID: Int) async throws -> FootballScoreboardResult? {
//        logger.debug("Fetching Football Scoreboard.", metadata: ["event-id": .stringConvertible(eventID)])
//
//        return try await client.execute(path: Self.searchPath, tla: .sca, input: request, locale: request.locale)
//    }

}
