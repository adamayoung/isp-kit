import Foundation

/// An object describing the precise odds currently in force for a selection. Only the fractional odds should be used as precise representation. The Decimal Odds are only present for reference.
public struct TrueOdds: Equatable, Decodable, CustomStringConvertible {

    /// The decimal representation of these odds with half round up 2 decimal places. This must not be used for calculations.
    public let decimalOdds: DecimalOdds?
    /// The fractional representation of these odds. This should be used for all needed calculations.
    public let fractionalOdds: FractionalOdds?

    public init(decimalOdds: DecimalOdds? = nil, fractionalOdds: FractionalOdds? = nil) {
        self.decimalOdds = decimalOdds
        self.fractionalOdds = fractionalOdds
    }

    public var description: String {
        let values = [
            "decimalOdds: \(decimalOdds?.description ?? "nil")",
            "fractionalOdds: \(fractionalOdds?.description ?? "nil")"
        ]

        return "[\(values.joined(separator: ","))]"
    }

}
