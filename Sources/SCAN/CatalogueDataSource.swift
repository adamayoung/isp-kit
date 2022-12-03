import Foundation

public protocol CatalogueDataSource {

    func search(_ request: FacetedSearchRequest) async throws -> FacetedSearchResult

}
