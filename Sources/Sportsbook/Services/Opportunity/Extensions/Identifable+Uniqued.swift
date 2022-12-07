import Foundation

extension Array where Element: Identifiable {

    func uniqued() -> Self {
        var seenIDs = [Element.ID]()
        return filter { element in
            guard seenIDs.contains(element.id) else {
                return false
            }

            seenIDs.append(element.id)
            return true
        }
    }

    func uniqueMap<T>(_ transform: (Element) throws -> T) rethrows -> [T] {
        var seenIDs = [Element.ID]()
        return try compactMap { element in
            guard seenIDs.contains(element.id) else {
                return nil
            }

            seenIDs.append(element.id)
            return try transform(element)
        }
    }

}
