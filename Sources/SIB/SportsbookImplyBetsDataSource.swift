import Foundation

public protocol SportsbookImplyBetsDataSource {

    func implyBets(_ request: ImplyBetsRequest) async throws -> ImplyBetsResult

}
