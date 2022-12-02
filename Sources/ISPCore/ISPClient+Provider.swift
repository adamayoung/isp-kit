import AsyncHTTPClient
import Foundation
import NIOCore

extension ISPClient {

    public enum HTTPClientProvider {
        case shared(HTTPClient)
        case createNewWithEventLoopGroup(EventLoopGroup)
        case createNew
    }

}
