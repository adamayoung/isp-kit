import Foundation

public protocol AccountDataSource {

    func signIn(with credential: Credential) async throws -> UserSession

    func userInfo(token: String) async throws -> Account

}
