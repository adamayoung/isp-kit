import Foundation
import PSA

extension Credential {

    static var mock: Self {
        let userID = EnvironmentVariable.userID
        let password = EnvironmentVariable.password
        let installID = String.randomInstallID

        return Credential(userId: userID, password: password, installId: installID)
    }

}
