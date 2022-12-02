import Foundation

extension String {

    static var randomInstallID: String {
        (1...16).reduce("") { partialResult, _ in
            partialResult + "\(Int.random(in: 1...9))"
        }
    }

}
