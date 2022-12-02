import Foundation
import ISPCore
import Logging
import NIOHTTP1

public final class GBPClient: ISPClient {

    public let applicationID: String
    public let site: StarsSite
    public let environment: Environment

    private let apiKey: String

    public init(
        applicationID: String,
        apiKey: String,
        site: StarsSite,
        environment: Environment,
        httpClientProvider: HTTPClientProvider,
        logger: Logger = Logger(label: "isp-kit.gbp-core.client")
    ) {
        self.applicationID = applicationID
        self.apiKey = apiKey
        self.site = site
        self.environment = environment
        super.init(httpClientProvider: httpClientProvider, encoder: .gbp, decoder: .gbp, logger: logger)
    }

    public func execute<Output: Decodable>(path: String, tla: TLA, httpMethod: HTTPMethod = .GET,
                                           locale: Locale) async throws -> Output {
        let baseURL = EndpointBase.value(for: tla, environment: environment)
        let url = "\(baseURL)\(path)"
        let options = Options(method: httpMethod, headers: headers)

        return try await super.execute(url: url, options: options, locale: locale)
    }

    public func execute<Input: Encodable, Output: Decodable>(path: String, tla: TLA, httpMethod: HTTPMethod = .POST,
                                                             input: Input, locale: Locale) async throws -> Output {
        let baseURL = EndpointBase.value(for: tla, environment: environment)
        let url = "\(baseURL)\(path)"
        let options = Options(method: httpMethod, headers: headers)

        return try await super.execute(url: url, input: input, options: options, locale: locale)
    }

}

extension GBPClient {

    private var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        headers.add(.applicationID, value: applicationID)
        headers.add(.starsSiteID, value: site.id)
        headers.add(.tlaAPIKey, value: apiKey)
        headers.add(.ip, value: "91.211.98.36")
        headers.add(.ips, value: "91.211.98.36")
        return headers
    }

}
