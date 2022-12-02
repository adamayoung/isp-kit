import Foundation

extension JSONEncoder {

    public static var gbp: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(.gbp)
        return encoder
    }

}
