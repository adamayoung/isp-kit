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

    public func scoreboards(forFootballEvents eventIDs: [Int],
                            locale: Locale = .current) async throws -> [FootballScoreboard] {
        logger.debug("Fetching Football Scoreboards.", metadata: ["event-ids": .stringConvertible(eventIDs)])

        let request = FootballScoreboardRequest(eventIDs: eventIDs)

        let result: GraphQLResult<FootballScoreboardGraphQLResult>? = try? await client.execute(
            path: Self.graphQLPath, tla: .sca, input: request, locale: locale
        )

        return result?.data.football.fixture ?? []
    }

}
