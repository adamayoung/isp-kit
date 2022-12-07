import Foundation

public struct FootballScoreboardDuration: Decodable {

    public let period: Period
    public let status: Status
    public let clock: Clock?
    public let stoppageMinutes: Int?

}

extension FootballScoreboardDuration {

    public enum Period: String, Decodable {

      case regular = "REGULAR"
      case extra = "EXTRA"

    }

    public enum Status: String, Decodable {

      case preMatch = "PRE_MATCH"
      case half = "HALF"
      case full = "FULL"
      case inplayFirstHalf = "INPLAY_FIRST_HALF"
      case inplaySecondHalf = "INPLAY_SECOND_HALF"
      case penaltyShootout = "PENALTY_SHOOTOUT"
      case end = "END"

    }

    public struct Clock: Decodable {

        public let minute: Int
        public let second: Int
        public let roundMinute: Int

        public  init(minute: Int, second: Int, roundMinute: Int) {
            self.minute = minute
            self.second = second
            self.roundMinute = roundMinute
        }

    }

}
