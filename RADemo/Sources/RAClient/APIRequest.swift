import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol APIRequest {
    var path: String { get }
    var params: [URLQueryItem] { get }
    var method: HTTPMethod { get }
    var cachePolicy: APICachePolicy { get }
    var timeout: TimeInterval { get }
}
