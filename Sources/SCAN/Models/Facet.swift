import Foundation

public final class Facet: Equatable, Hashable, Codable {

    public let type: FacetName
    public let values: [String]?
    public let includeOther: Bool?
    public let ranges: [String: RangeFacet]?
    public let bucket: BucketFacet?
    public let next: Facet?

    public init(type: FacetName, values: [String]? = nil, includeOther: Bool? = nil,
                ranges: [String: RangeFacet]? = nil, bucket: BucketFacet? = nil, next: Facet? = nil) {
        self.type = type
        self.values = values
        self.includeOther = includeOther
        self.ranges = ranges
        self.bucket = bucket
        self.next = next
    }

    public static func == (lhs: Facet, rhs: Facet) -> Bool {
        lhs.type == rhs.type &&
        lhs.next == rhs.next
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(type)
        hasher.combine(next)
    }

}

extension Facet: CustomStringConvertible {

    public var description: String {
        var facetNames = [type.rawValue]
        var currentFacet = next
        while let facet = currentFacet {
            facetNames.append(facet.description)
            currentFacet = facet.next
        }

        return facetNames.joined(separator: " -> ")
    }

}
