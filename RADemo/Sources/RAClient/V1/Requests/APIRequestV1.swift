import Foundation

protocol APIRequestV1 {
    var path: String { get }
    var queryParams: [URLQueryItem] { get }
}

extension APIRequestV1 {
    var queryParams: [URLQueryItem] { [] }
}
