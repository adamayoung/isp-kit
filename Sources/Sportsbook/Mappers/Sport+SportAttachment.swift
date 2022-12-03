import Foundation
import SCAN

extension Sport {

    init?(attachment: SportAttachment) {
        guard let name = attachment.name else {
            return nil
        }

        let category = Sport.Category(sportID: attachment.sportID)

        self.init(id: attachment.sportID, name: name, category: category)
    }

}
