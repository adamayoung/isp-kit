import Foundation

public struct BetLeg: Encodable, Equatable, CustomStringConvertible {

    public let betRunners: [BetLegRunner]
    public let legType: BetLegType

    public  init(betRunners: [BetLegRunner], legType: BetLeg.BetLegType = .simpleSelection) {
        self.betRunners = betRunners
        self.legType = legType
    }

    public var description: String {
        let betRunners = betRunners.map(\.description).joined(separator: ", ")
        return "[betRunners: \(betRunners), legType: \"\(legType.rawValue)\"]"
    }

}

extension BetLeg {

    public enum BetLegType: String, Equatable, Encodable {

        case simpleSelection = "SIMPLE_SELECTION"
        case forecast = "FORECAST"
        case reverseForecast = "REVERSE_FORECAST"
        case combinationForecast = "COMBINATION_FORECAST"
        case tricast = "TRICAST"
        case combinationTricast = "COMBINATION_TRICAST"
        case scorecast = "SCORECAST"
        case wincast = "WINCAST"
        case onLineBet = "ONE_LINE_BET"

    }

}
