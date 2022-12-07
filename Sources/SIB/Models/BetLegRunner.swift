import Foundation

public struct BetLegRunner: Encodable, Equatable, CustomStringConvertible {

    public let runner: Runner

    public init(runner: Runner) {
        self.runner = runner
    }

    public var description: String {
        return "[runner: \(runner)]"
    }

}
