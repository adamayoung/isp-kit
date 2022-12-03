import CMS
import Foundation

extension Sport {

    init?(node: Node) {
        guard
            node.type == .sport,
            let sportIDValue = node.sportID,
            let sportID = Int(sportIDValue)
        else {
            return nil
        }

        let category = Sport.Category(sportID: sportID)

        self.init(id: sportID, name: node.name, category: category)
    }

}
