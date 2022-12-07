import Foundation

public struct FootballScoreboardScore: Decodable {

    public let home: Int
    public let away: Int

    public init(home: Int, away: Int) {
        self.home = home
        self.away = away
    }

}
