import Foundation
import ISPCore
import Logging
import NIOHTTP1

public final class CMSClient: ISPClient {

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
        logger: Logger = Logger(label: "isp-kit.cms-core.client")
    ) {
        self.applicationID = applicationID
        self.apiKey = apiKey
        self.site = site
        self.environment = environment
        super.init(httpClientProvider: httpClientProvider, logger: logger)
    }

    public func execute<Output: Decodable>(path: String, httpMethod: HTTPMethod = .GET,
                                           locale: Locale) async throws -> Output {
        let baseURL = EndpointBase.value(for: environment)
        let path = pathWithQueryItems(path, locale: locale)

        let url = "\(baseURL)\(path)"
        let options = Options(method: httpMethod, headers: headers)

        return try await super.execute(url: url, options: options, locale: locale)
    }

    public func execute<Input: Encodable, Output: Decodable>(path: String, httpMethod: HTTPMethod = .POST,
                                                             input: Input, locale: Locale) async throws -> Output {
        let baseURL = EndpointBase.value(for: environment)
        let url = "\(baseURL)\(path)"
        let options = Options(method: httpMethod, headers: headers)

        return try await super.execute(url: url, input: input, options: options, locale: locale)
    }

}

extension CMSClient {

    private var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        headers.add(.applicationID, value: applicationID)
        headers.add(.starsSiteID, value: site.id)
        headers.add(.cmsAPIKey, value: apiKey)
        return headers
    }

    private func pathWithQueryItems(_ path: String, locale: Locale) -> String {
        let queryItems = [
            "site": site.code,
            "country": site.countryCode,
            "locale": locale.identifier
        ]

        let queryString = queryItems
            .map { queryItem in
                "\(queryItem.key)=\(queryItem.value)"
            }
            .joined(separator: "&")

        var path = path
        if !path.contains("?") {
            path += "?"
        } else {
            path += "&"
        }

        path += queryString
        return path
    }

}
