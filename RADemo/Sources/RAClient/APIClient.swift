import Foundation

protocol APIClient {
    func request<T: Codable>(_ apiRequest: APIRequest) async -> Result<T, APIError>
    func request(_ apiRequest: APIRequest) async -> APIResponse
}

extension APIClient {
    func request<T: Codable>(_ apiRequest: APIRequest) async -> Result<T, APIError> {
        let response = await request(apiRequest)
        switch response.result {
        case let .success(data):
            guard let data else {
                return .failure(.unknown)
            }
            do {
                let value = try JSONDecoder().decode(T.self, from: data)
                return .success(value)
            } catch {
                return .failure(.parsingError(error))
            }
        case let .failure(error):
            return .failure(error)
        }
    }

    func buildResponse(data: Data?, response: URLResponse?, error: Error?, request: URLRequest) -> APIResponse {
        guard error == nil else {
            return .init(result: .failure(.unknown), request: request)
        }
        return APIResponse(result: .success(data), request: request)
    }
}
