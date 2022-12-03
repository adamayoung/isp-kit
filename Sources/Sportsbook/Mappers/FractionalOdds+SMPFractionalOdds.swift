import Foundation
import SMP

extension FractionalOdds {

    init?(fractionOdds: SMPFractionalOdds?) {
        guard let fractionOdds = fractionOdds else {
            return nil
        }

        self.init(numerator: fractionOdds.numerator, denominator: fractionOdds.denominator)
    }

}
