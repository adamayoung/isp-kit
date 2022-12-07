import Foundation

public enum LegType: String, Codable {

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
