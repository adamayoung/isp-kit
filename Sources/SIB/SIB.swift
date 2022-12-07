import Foundation
import GBPCore
import Logging

public final class SIB: SportsbookImplyBetsDataSource {

    private static let implyBetsPath = "/api/sports/fixedodds/transactional/v1/implyBets"

    private let client: GBPHTTPClient
    private let logger: Logger

    public init(client: GBPHTTPClient, logger: Logger = Logger(label: "isp-kit.sib")) {
        self.client = client
        self.logger = logger
    }

    public func implyBets(_ request: ImplyBetsRequest) async throws -> ImplyBetsResult {
        logger.debug("Fetching from SIB.", metadata: ["request": .stringConvertible(request)])

        return try await client.execute(path: Self.implyBetsPath, tla: .sib, input: request, locale: request.locale)
    }

}
