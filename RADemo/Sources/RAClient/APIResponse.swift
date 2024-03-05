import Foundation

public enum HTTPError: Error {
    case parsingError(Error)
    case unknown
}

public struct APIResponse {
    let result: Result<Data?, HTTPError>
    let request: URLRequest
}
