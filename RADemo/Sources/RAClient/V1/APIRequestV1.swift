import Foundation

protocol APIRequestV1: APIRequest {}

extension APIRequestV1 {
    var params: [URLQueryItem] { [] }
    var method: HTTPMethod { .get }
    var cachePolicy: APICachePolicy { .none }
    var timeout: TimeInterval { 60 }
}
