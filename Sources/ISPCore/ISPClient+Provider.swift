import AsyncHTTPClient
import Foundation
import NIOCore

extension ISPHTTPClient {

    public enum HTTPClientProvider {
        case shared(HTTPClient)
        case createNewWithEventLoopGroup(EventLoopGroup)
        case createNew
    }

}
