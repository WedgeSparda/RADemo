import Foundation

final class APIClientV1: APIClient {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }

    func request(_ apiRequest: APIRequest) async -> APIResponse {
        let request = buildRequest(apiRequest)
        
        if
            let cache = session.configuration.urlCache?.cachedResponse(for: request),
            !cache.hasExpired(apiRequest)
        {
            return buildResponse(data: cache.data, response: cache.response, error: nil, request: request)
        }
        
        session.configuration.urlCache?.removeCachedResponse(for: request)
        
        do {
            let (data, response) = try await session.data(for: request)
            return buildResponse(data: data, response: response, error: nil, request: request)
        } catch {
            return buildResponse(data: nil, response: nil, error: error, request: request)
        }
    }
    
    func buildRequest(_ request: APIRequest) -> URLRequest {
        var requestComponents: URLComponents = URLComponents(string: "https://retroachievements.org")!
        requestComponents.path = request.path
        requestComponents.queryItems = authorizationQueryParams
        requestComponents.queryItems?.append(contentsOf: request.params)
        
        let urlRequest = URLRequest(
            url: requestComponents.url!,
            cachePolicy: request.cachePolicy.requestCachePolicy
        )
        
        return urlRequest
    }
    
    var authorizationQueryParams: [URLQueryItem] {
        let userName = URLQueryItem(name: "z", value: "WedgeSparda")
        let apiKey = URLQueryItem(name: "y", value: "782GKSwyD3rrmcglE5sZMZy9QqYZbbl8")
        return [userName, apiKey]
    }
}
