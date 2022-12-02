import Foundation

extension JSONDecoder {

    public static var gbp: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.gbp)
        return decoder
    }

}
