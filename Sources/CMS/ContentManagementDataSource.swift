import Foundation

public protocol ContentManagementDataSource {

    func nodes(_ request: NodesRequest) async throws -> [Node]

}
