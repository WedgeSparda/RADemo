import Foundation

public enum APIError: Error {
    case parsingError(Error)
    case unknown
}

public struct APIResponse {
    let result: Result<Data?, APIError>
    let request: URLRequest
}
