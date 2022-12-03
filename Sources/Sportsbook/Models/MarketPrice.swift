import Foundation

public struct MarketPrice: Identifiable, Equatable {

    public var id: Market.ID { marketID }

    /// Unique market identifier in the format 'product.market'.
    public let marketID: Market.ID
    /// The current state of a market.
    public let marketStatus: MarketPrice.MarketStatus
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
    public let bettingType: MarketPrice.MarketBettingType
    /// Available runners of the market in no particular order.
    public let runnerDetails: [RunnerDetails]
    /// True if eachway betting is available.
    public let isEachWayAvailable: Bool
    /// The number of places for a win market(each way).
    public let numberOfPlaces: Int?
    /// The fraction to which the place price is derived(each way).
    public let placeFraction: FractionalOdds?
    /// Available Leg Types the user can place bets in this market. e.g. Single Selection, Forecast, Wincast, etc.
    public let legTypes: [MarketPrice.LegType]?
    /// Is this market BPE (Price Rush) eligible.
    public let hasBPE: Bool?
    /// Is this market eligible for same game multiples?
    public let hasSGM: Bool?
    /// Linked market identifier. Presented in the 'product.market' format.
    public let linkedMarketID: Market.ID?
    /// The bet delay for a market.
    public let betDelay: TimeInterval
    /// List of Rule4 deductions on the represented market.
    public let rule4Deductions: [Rule4Deduction]?

    public init(marketID: Market.ID, marketStatus: MarketStatus, isTurnInPlayEnabled: Bool, isInPlay: Bool,
                isBSPMarket: Bool, isLivePriceAvailable: Bool, isGuaranteedPriceAvailable: Bool,
                bettingType: MarketBettingType, runnerDetails: [RunnerDetails], isEachWayAvailable: Bool,
                numberOfPlaces: Int? = nil, placeFraction: FractionalOdds? = nil, legTypes: [LegType]? = nil,
                hasBPE: Bool? = nil, hasSGM: Bool? = nil, linkedMarketID: Market.ID? = nil, betDelay: TimeInterval,
                rule4Deductions: [Rule4Deduction]? = nil) {
        self.marketID = marketID
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

}

extension MarketPrice {

    public enum MarketStatus: CaseIterable {
        /// Open Market.
        case open
        /// Suspended Market.
        case suspended
    }

    public enum MarketBettingType: CaseIterable {
        /// Fixed Odds Market.
        case fixedOdds
        /// Moving Handicap Market.
        case movingHandicap
    }

    public enum LegType: CaseIterable {
        /// Simple selection. Contain only one selection per leg.
        case simpleSelection
        /// Straight Forecast. Contain 2 selections per leg finishing in 1st and 2nd places. Straight Forecast bets must be properly filled with the finishing order of the runners.
        case forecast
        /// Reverse Forecast. Contains 2 selections per leg finishing in 1st and 2nd in the race in either order.
        case reverseForecast
        /// Combination forecast. Contains at least 3 selections per leg with any of them finishing in 1st and 2nd in any order. This is equivalent of having 6 permuted Forecasts.
        case combinationForecase
        /// Straight Tricast. Contains 3 selections per leg finishing in 1st, 2nd and 3rd places. Straight Tricast bets must be properly filled with the finishing order of the runners.
        case tricast
        /// Combination Tricast. Contains at least 3 selections per leg finishing in 1st, 2nd and 3rd places in any order. This is equivalent of having 6 permuted Straight Tricasts.
        case combinationTricast
        /// Scorecast. Contains 2 selections per leg consisting of a First Goalscorer selection and a Correct Score selection.
        case scorecast
        /// Wincast. Contains 2 selections per leg consisting of a First Goalscorer selection and a Match Result selection.
        case wincast
    }

}
