import CMS
import Foundation

extension MarketPrice {

    init?(marketDetails: MarketDetails) {
        guard
            let marketStatus = MarketPrice.MarketStatus(marketStatus: marketDetails.marketStatus),
            let bettingType = MarketPrice.MarketBettingType(bettingType: marketDetails.bettingType)
        else {
            return nil
        }

        let runnerDetails = marketDetails.runnerDetails.compactMap(RunnerDetails.init)
        let placeFraction = FractionalOdds(fractionOdds: marketDetails.placeFraction)
        let legTypes = marketDetails.legTypes?.compactMap(LegType.init)
        let rule4Deductions = marketDetails.rule4Deductions?.compactMap(Rule4Deduction.init)

        self.init(
            marketID: marketDetails.marketID,
            marketStatus: marketStatus,
            isTurnInPlayEnabled: marketDetails.isTurnInPlayEnabled,
            isInPlay: marketDetails.isInPlay,
            isBSPMarket: marketDetails.isBSPMarket,
            isLivePriceAvailable: marketDetails.isLivePriceAvailable,
            isGuaranteedPriceAvailable: marketDetails.isGuaranteedPriceAvailable,
            bettingType: bettingType,
            runnerDetails: runnerDetails,
            isEachWayAvailable: marketDetails.isEachWayAvailable,
            numberOfPlaces: marketDetails.numberOfPlaces,
            placeFraction: placeFraction,
            legTypes: legTypes,
            hasBPE: marketDetails.hasBPE,
            hasSGM: marketDetails.hasSGM,
            linkedMarketID: marketDetails.linkedMarketID,
            betDelay: marketDetails.betDelay,
            rule4Deductions: rule4Deductions
        )
    }

}

extension MarketPrice.MarketStatus {

    init?(marketStatus: MarketDetails.MarketStatus) {
        switch marketStatus {
        case .open:
            self = .open

        case .suspended:
            self = .suspended

        default:
            return nil
        }
    }

}

extension MarketPrice.MarketBettingType {

    init?(bettingType: MarketDetails.MarketBettingType) {
        switch bettingType {
        case .fixedOdds:
            self = .fixedOdds

        case .movingHandicap:
            self = .movingHandicap

        default:
            return nil
        }
    }

}

extension MarketPrice.LegType {

    init?(legType: MarketDetails.LegType) {
        switch legType {
        case .simpleSelection:
            self = .simpleSelection

        case .forecast:
            self = .forecast

        case .reverseForecast:
            self = .reverseForecast

        case .combinationForecase:
            self = .combinationTricast

        case .tricast:
            self = .tricast

        case .combinationTricast:
            self = .combinationTricast

        case .scorecast:
            self = .scorecast

        case .wincast:
            self = .wincast

        default:
            return nil
        }
    }

}
