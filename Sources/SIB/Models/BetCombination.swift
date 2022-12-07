import Foundation

public struct BetCombination: Decodable {

    public let legCombinations: [LegCombinationRunner]
    public let canPlaceEachWayBet: Bool
    public let linesCount: Int
    public let betMinStake: Decimal
    public let betMaxStake: Decimal
    public let averageOdds: Decimal
    public let winAverageOdds: Decimal

}

extension BetCombination {

    private enum CodingKeys: String, CodingKey {
        case legCombinations
        case canPlaceEachWayBet = "canPlaceEachwayBet"
        case linesCount = "numLines"
        case betMinStake
        case betMaxStake
        case averageOdds
        case winAverageOdds
    }

}
