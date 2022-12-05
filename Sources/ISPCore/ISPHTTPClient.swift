import AsyncHTTPClient
import Foundation
import Logging
import NIOCore
import NIOFoundationCompat
import NIOHTTP1

open class ISPHTTPClient {

    private static let userAgent = "isp-kit"

    public let httpClient: HTTPClient
    public var eventLoopGroup: EventLoopGroup { httpClient.eventLoopGroup }

    private let httpClientProvider: HTTPClientProvider
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    private let logger: Logger

    public init(
        httpClientProvider: HTTPClientProvider,
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder(),
        logger: Logger = Logger(label: "isp-kit.isp-core.client")
    ) {
        self.httpClientProvider = httpClientProvider
        self.encoder = encoder
        self.decoder = decoder

        switch httpClientProvider {
        case .shared(let providedHTTPClient):
            self.httpClient = providedHTTPClient

        case .createNewWithEventLoopGroup(let eventLoopGroup):
            self.httpClient = HTTPClient(
                eventLoopGroupProvider: .shared(eventLoopGroup),
                configuration: .init(timeout: .init(connect: .seconds(10)))
            )

        case .createNew:
            self.httpClient = HTTPClient(
                eventLoopGroupProvider: .createNew,
                configuration: .init(timeout: .init(connect: .seconds(10)))
            )
        }

        self.logger = logger
    }

    public func shutdown() async throws {
        try await httpClient.shutdown()
    }

}

extension ISPHTTPClient {

    public func execute<Output: Decodable>(url: String, options: Options? = nil,
                                           locale: Locale = .current) async throws -> Output {
        let options = options ?? Options(method: .GET)
        var request = HTTPClientRequest(url: url)
        request.method = options.method
        request.headers.add(contentsOf: options.headers)

        return try await invoke(request, locale: locale)
    }

    public func execute<Input: Encodable, Output: Decodable>(url: String, input: Input, options: Options? = nil,
                                                             locale: Locale = .current) async throws -> Output {
        let options = options ?? Options(method: .POST)
        var request = HTTPClientRequest(url: url)
        request.method = options.method
        request.headers.add(contentsOf: options.headers)

        do {
            let data = try encoder.encode(input)
            request.headers.add(.contentType, value: "application/json")
            request.body = .bytes(ByteBuffer(bytes: data))
        } catch let error {
            throw ISPClientError.encode(error)
        }

        return try await invoke(request, locale: locale)
    }

    private func invoke<Output: Decodable>(_ request: HTTPClientRequest,
                                           locale: Locale) async throws -> Output {
        var request = request
        request.headers.add(contentsOf: defaultHeaders(requestURL: request.url, locale: locale))

        logger.debug("\(request.method.rawValue) \(request.url).", metadata: [
            "headers": .stringConvertible(request.headers)
        ])

        let response: HTTPClientResponse
        do {
            response = try await httpClient.execute(request, timeout: .seconds(10))
        } catch let error {
            throw ISPClientError.network(error)
        }

        guard response.status == .ok else {
            throw ISPClientError.response(response.status)
        }

        let body: ByteBuffer
        do {
            body = try await response.body.collect(upTo: 1024 * 1024)
        } catch let error {
            throw ISPClientError.network(error)
        }

        let output: Output
        do {
            output = try decoder.decode(Output.self, from: body)
        } catch let error {
            throw ISPClientError.decode(error)
        }

        return output
    }

}

extension ISPHTTPClient {

    private func defaultHeaders(requestURL: String, locale: Locale) -> HTTPHeaders {
        var headers = HTTPHeaders()
        headers.add(.accept, value: "application/json")
        headers.add(.acceptLanguage, value: locale.identifier.replacingOccurrences(of: "_", with: "-"))
        headers.add(.userAgent, value: Self.userAgent)
        headers.add(.host, value: URL(string: requestURL)?.host ?? "")
        return headers
    }

}
