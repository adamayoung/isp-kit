import Foundation

public struct ImplyBetsResult: Decodable {

    public let betCombinations: [BetCombination]
    public let maxPayout: Decimal
    public let hasBonusMoney: Bool

}
