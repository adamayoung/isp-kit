import Foundation
import SCA

extension FootballScoreboard {

    init?(scoreboard: SCAFootballScoreboard) {
        guard let id = Int(scoreboard.id) else {
            return nil
        }

        self.init(id: id)
    }

}
