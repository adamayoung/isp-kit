import CMSCore
import Foundation
import Logging

public final class CMS: ContentManagementDataSource {

    private static let nodesPath = "/nodes"
    private static let groupingsPath = "/groupings"

    private let client: CMSHTTPClient
    private let logger: Logger

    public init(client: CMSHTTPClient, logger: Logger = Logger(label: "isp-kit.cms")) {
        self.client = client
        self.logger = logger
    }

    public func nodes(_ request: NodesRequest) async throws -> [Node] {
        logger.debug("Fetching nodes from CMS service.")

        var path = Self.nodesPath
        if !path.contains("?") {
            path += "?"
        } else {
            path += "&"
        }

        path += request.queryString

        return try await client.execute(path: path, locale: request.locale)
    }

    public func groupings(_ request: GroupingsRequest) async throws -> [Grouping] {
        logger.debug("Fetching groupings from CMS service.")

        var path = Self.groupingsPath
        if !path.contains("?") {
            path += "?"
        } else {
            path += "&"
        }

        path += request.queryString

        return try await client.execute(path: path, locale: request.locale)
    }

}
