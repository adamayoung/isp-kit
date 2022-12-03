import Foundation
import SCAN

extension Competition {

    init?(attachment: CompetitionAttachment) {
        guard let name = attachment.name else {
            return nil
        }

        self.init(id: attachment.competitionID, name: name, sportID: attachment.sportID)
    }

}
