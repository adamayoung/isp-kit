import Foundation
import NIOHTTP1

public enum ISPClientError: Error {

    case encode(Error)
    case network(Error)
    case response(HTTPResponseStatus)
    case emptyBody
    case decode(Error)

}
