import Foundation
import SIB

extension BetLeg {

    init(selection: Selection) {
        self.init(
            betRunners: [
                BetLegRunner(
                    runner: Runner(marketID: selection.marketID, selectionID: selection.runnerID)
                )
            ]
        )
    }

}
