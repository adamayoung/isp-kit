import Foundation

public protocol SportsContentDataSource {

    func scoreboards(forFootballEvents eventIDs: [Int], locale: Locale) async throws -> [FootballScoreboard]

}

extension SportsContentDataSource {

    public func scoreboard(forFootballEvent eventID: Int,
                           locale: Locale) async throws -> FootballScoreboard? {
        let scoreboards = try await self.scoreboards(forFootballEvents: [eventID], locale: locale)
        return scoreboards.first { $0.id == String(eventID) }
    }

}
