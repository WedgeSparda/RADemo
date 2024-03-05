import Foundation

final class RAClient {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension RAClient {
    func request() async -> APIResponse {
        let request = buildRequest()
        do {
            let (data, response) = try await session.data(for: request)
            return buildResponse(data: data, response: response, error: nil, request: request)
        } catch {
            return buildResponse(data: nil, response: nil, error: error, request: request)
        }
    }
}

private extension RAClient {
    func buildRequest() -> URLRequest {
        var requestComponents: URLComponents = URLComponents(string: "https://retroachievements.org")!
        requestComponents.path = "/API/API_GetConsoleIDs.php"
        requestComponents.queryItems = authorizationQueryParams
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
