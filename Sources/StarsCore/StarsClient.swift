import Foundation
import ISPCore
import Logging
import NIOHTTP1

public final class StarsClient: ISPClient {

    public let site: StarsSite
    public let environment: Environment

    public init(
        site: StarsSite,
        environment: Environment,
        httpClientProvider: HTTPClientProvider,
        logger: Logger = Logger(label: "isp-kit.stars-core.client")
    ) {
        self.site = site
        self.environment = environment
        super.init(httpClientProvider: httpClientProvider, logger: logger)
    }

    public func execute<Output: Decodable>(path: String, httpMethod: HTTPMethod = .GET) async throws -> Output {
        let baseURL = EndpointBase.value(for: site, environment: environment)
        let url = "\(baseURL)\(path)"
        let options = Options(method: httpMethod)

        return try await super.execute(url: url, options: options)
    }

    public func execute<Input: Encodable, Output: Decodable>(path: String, httpMethod: HTTPMethod = .POST,
                                                             input: Input) async throws -> Output {
        let baseURL = EndpointBase.value(for: site, environment: environment)
        let url = "\(baseURL)\(path)"
        let options = Options(method: httpMethod)

        return try await super.execute(url: url, input: input, options: options)
    }

}
