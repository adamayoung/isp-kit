import Foundation
import SCAN

extension Sportsbook.Market {

    init?(attachment: MarketAttachment) {
        guard
            let marketName = attachment.marketName,
            let marketDate = attachment.marketTime,
            let attachmentRunners = attachment.runners
        else {
            return nil
        }

        let runners = attachmentRunners.compactMap(MarketRunner.init)
        guard !runners.isEmpty else {
            return nil
        }

        let marketType = MarketType(attachment.marketType)

        self.init(id: attachment.marketID, name: marketName, marketDate: marketDate, inPlay: attachment.inPlay,
                  isSGMMarket: attachment.sgmMarket, canTurnInPlay: attachment.canTurnInPlay, marketType: marketType,
                  runners: runners, sportID: attachment.sportID, eventID: attachment.eventID,
                  competitionID: attachment.competitionID)
    }

}
