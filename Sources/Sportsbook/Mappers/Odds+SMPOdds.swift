import Foundation
import SMP

extension Odds {

    init?(odds: SMPOdds?) {
        guard let odds = odds else {
            return nil
        }

        let fractionalOdds = FractionalOdds(fractionOdds: odds.fractionalDisplayOdds)

        self.init(
            decimalOdds: odds.decimalDisplayOdds?.decimalOdds,
            fractionalOdds: fractionalOdds,
            americanOdds: odds.americanDisplayOdds?.americanOddsInt
        )
    }

}
