import Foundation

final class APIClientV1 {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension APIClientV1 {
    func request<T: Codable>(_ apiRequest: APIRequestV1) async -> Result<T, HTTPError> {
        let response = await request(GetConsoleIDs())
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
    
    private func request(_ apiRequest: APIRequestV1) async -> APIResponse {
        let request = buildRequest(apiRequest)
        do {
            let (data, response) = try await session.data(for: request)
            return buildResponse(data: data, response: response, error: nil, request: request)
        } catch {
            return buildResponse(data: nil, response: nil, error: error, request: request)
        }
    }
}

private extension APIClientV1 {
    func buildRequest(_ request: APIRequestV1) -> URLRequest {
        var requestComponents: URLComponents = URLComponents(string: "https://retroachievements.org")!
        requestComponents.path = request.path
        requestComponents.queryItems = authorizationQueryParams
        requestComponents.queryItems?.append(contentsOf: request.queryParams)
        return URLRequest(url: requestComponents.url!)
    }
    
    var authorizationQueryParams: [URLQueryItem] {
        let userName = URLQueryItem(name: "z", value: "WedgeSparda")
        let apiKey = URLQueryItem(name: "y", value: "782GKSwyD3rrmcglE5sZMZy9QqYZbbl8")
        return [userName, apiKey]
    }
    
    func buildResponse(data: Data?, response: URLResponse?, error: Error?, request: URLRequest) -> APIResponse {
        guard error == nil else {
            return .init(result: .failure(.unknown), request: request)
        }
        return APIResponse(result: .success(data), request: request)
    }
}
