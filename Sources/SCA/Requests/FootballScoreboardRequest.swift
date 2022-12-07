import Foundation
import GBPCore

struct FootballScoreboardRequest: GraphQLRequest {

    let query: String = """
    query Football($ids: [ID!]!) {
        football {
          fixture(ids: $ids) {
            id
            score {
              home
              away
            }
            duration {
              period
              status
              clock {
                minute
                second
                roundMinute
              }
              stoppageMinutes
            }
            penaltyShootout {
              firstTeamToShoot
              penaltyFormat
              nextTeamToShoot
              penaltyScores {
                penaltyNumber
                side
                shotResult
              }
            }
          }
        }
    }
    """

    let variables: [String: [String]]

    init(eventIDs: [Int]) {
        self.variables = ["ids": eventIDs.map(String.init)]
    }

    init(eventID: Int) {
        self.init(eventIDs: [eventID])
    }

}
