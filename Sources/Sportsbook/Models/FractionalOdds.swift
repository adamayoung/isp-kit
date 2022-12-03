import Foundation

/// Odds represented in fractional format.
public struct FractionalOdds: Equatable {

    /// The numerator of a fractional representation of these odds.
    public let numerator: Int
    /// The denominator of a fractional representation of these odds
    public let denominator: Int

    public init(numerator: Int, denominator: Int) {
        self.numerator = numerator
        self.denominator = denominator
    }

}
