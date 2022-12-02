import Foundation

/// Odds represented in American format.
public struct AmericanOdds: Equatable, Decodable, CustomStringConvertible {

    /// The non fractional American representation of these odds.
    public let americanOddsInt: Int

    public init(americanOddsInt: Int) {
        self.americanOddsInt = americanOddsInt
    }

    public var description: String {
        "\(americanOddsInt)"
    }

}
