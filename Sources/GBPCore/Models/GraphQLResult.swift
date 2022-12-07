import Foundation

public struct GraphQLResult<DataResult: Decodable>: Decodable {

    public let data: DataResult

    public init(data: DataResult) {
        self.data = data
    }

}
