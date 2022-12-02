import Foundation

public struct FacetedSearchRequest: Equatable, Encodable {

    public static let defaultCurrencyCode = "GBP"

    /// Selects how the results that match the selection criteria should be categorized.
    public let facets: [Facet]
    /// Provides the selection criteria, markets that match the given criteria are returned in the search results.
    public let filter: FilterQuery
    public let currencyCode: String
    public let locale: Locale
    public let textQuery: String?

    public init(facets: [Facet], filter: FilterQuery = .init(), currencyCode: String = Self.defaultCurrencyCode,
                locale: Locale, textQuery: String? = nil) {
        self.facets = facets
        self.filter = filter
        self.currencyCode = currencyCode
        self.locale = locale
        self.textQuery = textQuery
    }

    public init(facet: Facet, filter: FilterQuery = .init(), currencyCode: String = Self.defaultCurrencyCode,
                locale: Locale = .current, textQuery: String? = nil) {
        self.init(facets: [facet], filter: filter, currencyCode: currencyCode, locale: locale, textQuery: textQuery)
    }

}

extension FacetedSearchRequest {

    private enum CodingKeys: String, CodingKey {
        case facets
        case filter
        case currencyCode
        case locale
        case textQuery
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(facets, forKey: .facets)
        try container.encode(filter, forKey: .filter)
        try container.encode(currencyCode.uppercased(), forKey: .currencyCode)
        try container.encode(locale.identifier.uppercased(), forKey: .locale)
        try container.encodeIfPresent(textQuery, forKey: .textQuery)
    }

}
