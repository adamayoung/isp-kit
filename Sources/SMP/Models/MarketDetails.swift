import Foundation

/// Market Price.
///
/// - Note: [GBP | SMP | MarketDetails](https://github.com/Flutter-Global/cap-product-catalogue/blob/master/api/smp/SMP-IDD.md#MarketDetails)
public struct MarketDetails: Equatable, Decodable, CustomStringConvertible {

    /// Unique market identifier in the format 'product.market'.
    public let marketID: String
    /// The current state of a market.
    public let marketStatus: MarketDetails.MarketStatus
    /// True if a market turns 'in play' at a kick off time, otherwise it is false.
    public let isTurnInPlayEnabled: Bool
    /// True if a market is currently in play, otherwise it is false.
    public let isInPlay: Bool
    /// bspMarket.
    public let isBSPMarket: Bool
    /// True if live prices are available on the market.
    public let isLivePriceAvailable: Bool
    /// True if guaranteed price is available on this market.
    public let isGuaranteedPriceAvailable: Bool
    /// Represents a type of a betting market.
    public let bettingType: MarketDetails.MarketBettingType
    /// Available runners of the market in no particular order.
    public let runnerDetails: [RunnerDetails]
    /// True if eachway betting is available.
    public let isEachWayAvailable: Bool
    /// The number of places for a win market(each way).
    public let numberOfPlaces: Int?
    /// The fraction to which the place price is derived(each way).
    public let placeFraction: FractionalOdds?
    /// Available Leg Types the user can place bets in this market. e.g. Single Selection, Forecast, Wincast, etc.
    public let legTypes: [MarketDetails.LegType]?
    /// Is this market BPE (Price Rush) eligible.
    public let hasBPE: Bool?
    /// Is this market eligible for same game multiples?
    public let hasSGM: Bool?
    /// Linked market identifier. Presented in the 'product.market' format.
    public let linkedMarketID: String?
    /// The bet delay for a market.
    public let betDelay: TimeInterval
    /// List of Rule4 deductions on the represented market.
    public let rule4Deductions: [Rule4Deduction]?

    public init(marketId: String, marketStatus: MarketDetails.MarketStatus, isTurnInPlayEnabled: Bool, isInPlay: Bool,
                isBSPMarket: Bool, isLivePriceAvailable: Bool, isGuaranteedPriceAvailable: Bool,
                bettingType: MarketDetails.MarketBettingType, runnerDetails: [RunnerDetails], isEachWayAvailable: Bool,
                numberOfPlaces: Int? = nil, placeFraction: FractionalOdds? = nil,
                legTypes: [MarketDetails.LegType]? = nil, hasBPE: Bool? = nil, hasSGM: Bool? = nil,
                linkedMarketID: String? = nil, betDelay: TimeInterval, rule4Deductions: [Rule4Deduction]? = nil) {
        self.marketID = marketId
        self.marketStatus = marketStatus
        self.isTurnInPlayEnabled = isTurnInPlayEnabled
        self.isInPlay = isInPlay
        self.isBSPMarket = isBSPMarket
        self.isLivePriceAvailable = isLivePriceAvailable
        self.isGuaranteedPriceAvailable = isGuaranteedPriceAvailable
        self.bettingType = bettingType
        self.runnerDetails = runnerDetails
        self.isEachWayAvailable = isEachWayAvailable
        self.numberOfPlaces = numberOfPlaces
        self.placeFraction = placeFraction
        self.legTypes = legTypes
        self.hasBPE = hasBPE
        self.hasSGM = hasSGM
        self.linkedMarketID = linkedMarketID
        self.betDelay = betDelay
        self.rule4Deductions = rule4Deductions
    }

    public var description: String {
        "[marketID: \(marketID)]"
    }

}

extension MarketDetails {

    private enum CodingKeys: String, CodingKey {
        case marketID = "marketId"
        case marketStatus
        case isTurnInPlayEnabled = "turnInPlayEnabled"
        case isInPlay = "inplay"
        case isBSPMarket = "bspMarket"
        case isLivePriceAvailable = "livePriceAvailable"
        case isGuaranteedPriceAvailable = "guaranteedPriceAvailable"
        case bettingType
        case runnerDetails
        case isEachWayAvailable = "eachwayAvailable"
        case numberOfPlaces
        case placeFraction
        case legTypes
        case hasBPE
        case hasSGM
        case linkedMarketID = "linkedMarketId"
        case betDelay
        case rule4Deductions
    }

}

extension MarketDetails {

    public enum MarketStatus: String, CaseIterable, Decodable, CustomStringConvertible {
        /// Open Market.
        case open = "OPEN"
        /// Suspended Market.
        case suspended = "SUSPENDED"
        /// Unknown.
        case unknown = "UNKNOWN"

        public init(from decoder: Decoder) throws {
            self = try Self(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
        }

        public var description: String {
            rawValue
        }
    }

    public enum MarketBettingType: String, CaseIterable, Decodable, CustomStringConvertible {
        /// Fixed Odds Market.
        case fixedOdds = "FIXED_ODDS"
        /// Moving Handicap Market.
        case movingHandicap = "MOVING_HANDICAP"
        /// Unknown.
        case unknown = "UNKNOWN"

        public init(from decoder: Decoder) throws {
            self = try Self(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
        }

        public var description: String {
            rawValue
        }
    }

    public enum LegType: String, CaseIterable, Decodable, CustomStringConvertible {
        /// Simple selection. Contain only one selection per leg.
        case simpleSelection = "SIMPLE_SELECTION"
        /// Straight Forecast. Contain 2 selections per leg finishing in 1st and 2nd places. Straight Forecast bets must be properly filled with the finishing order of the runners.
        case forecast = "FORECAST"
        /// Reverse Forecast. Contains 2 selections per leg finishing in 1st and 2nd in the race in either order.
        case reverseForecast = "REVERSE_FORECAST"
        /// Combination forecast. Contains at least 3 selections per leg with any of them finishing in 1st and 2nd in any order. This is equivalent of having 6 permuted Forecasts.
        case combinationForecase = "COMBINATION_FORECAST"
        /// Straight Tricast. Contains 3 selections per leg finishing in 1st, 2nd and 3rd places. Straight Tricast bets must be properly filled with the finishing order of the runners.
        case tricast = "TRICAST"
        /// Combination Tricast. Contains at least 3 selections per leg finishing in 1st, 2nd and 3rd places in any order. This is equivalent of having 6 permuted Straight Tricasts.
        case combinationTricast = "COMBINATION_TRICAST"
        /// Scorecast. Contains 2 selections per leg consisting of a First Goalscorer selection and a Correct Score selection.
        case scorecast = "SCORECAST"
        /// Wincast. Contains 2 selections per leg consisting of a First Goalscorer selection and a Match Result selection.
        case wincast = "WINCAST"
        /// Unknown.
        case unknown = "UNKNOWN"

        public init(from decoder: Decoder) throws {
            self = try Self(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
        }

        public var description: String {
            rawValue
        }
    }

}
