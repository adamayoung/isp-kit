import Foundation

public struct FootballScoreboard: Identifiable, Decodable {

    public let id: String
    public let score: FootballScoreboardScore?
    public let duration: FootballScoreboardDuration?


}

public typealias SCAFootballScoreboard = FootballScoreboard
