import CMSCore
import Foundation
import Logging

public final class CMS {

    private static let nodesPath = "/nodes"

    private let client: CMSClient
    private let logger: Logger

    public init(client: CMSClient, logger: Logger = Logger(label: "isp-kit.cms")) {
        self.client = client
        self.logger = logger
    }

    public func nodes(_ request: NodesRequest) async throws -> [Node] {
        logger.debug("Fetching nodes from CMS service")

        var path = Self.nodesPath
        if !path.contains("?") {
            path += "?"
        } else {
            path += "&"
        }

        path += request.queryString

        return try await client.execute(path: path, locale: request.locale)
    }

}
