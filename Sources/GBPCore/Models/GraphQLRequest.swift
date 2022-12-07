import Foundation

public protocol GraphQLRequest: Encodable {

    var query: String { get }
    var variables: [String: [String]] { get }

}

extension GraphQLRequest {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: GraphQLRequestCodingKeys.self)
        try container.encode(query, forKey: .query)
        try container.encodeIfPresent(variables, forKey: .variables)
    }

}

private enum GraphQLRequestCodingKeys: String, CodingKey {

    case query
    case variables

}
