import Foundation

public struct GraphQLRequest<Query: Encodable, Variables: Encodable>: Encodable {

    public let query: Query
    public let variables: Variables

    public init(query: Query, variables: Variables) {
        self.query = query
        self.variables = variables
    }

}
