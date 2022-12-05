import Foundation

public protocol ContentManagementDataSource {

    func nodes(_ request: NodesRequest) async throws -> [Node]

    func groupings(_ request: GroupingsRequest) async throws -> [Grouping]

}
