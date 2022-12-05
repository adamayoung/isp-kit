import Foundation
import GBPCore
import Logging

public final class SCAN: CatalogueDataSource {

    private static let searchPath = "/www/sports/navigation/facet/v1.0/search"

    private let client: GBPHTTPClient
    private let logger: Logger

    public init(client: GBPHTTPClient, logger: Logger = Logger(label: "isp-kit.scan")) {
        self.client = client
        self.logger = logger
    }

    public func search(_ request: FacetedSearchRequest) async throws -> FacetedSearchResult {
        logger.debug("Searching SCAN.", metadata: ["facets": .stringConvertible(request.facets)])

        return try await client.execute(path: Self.searchPath, tla: .scan, input: request, locale: request.locale)
    }

}
