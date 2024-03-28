import Foundation

final class APIClientV1: APIClient {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }

    func request(_ apiRequest: APIRequest) async -> APIResponse {
        let request = buildRequest(apiRequest)
        
        if 
            let cachedURLResponse = session.configuration.urlCache?.cachedResponse(for: request),
            !cachedURLResponse.hasExpired(apiRequest)
        {
            print("--> CACHE")
            return buildResponse(data: cachedURLResponse.data, response: cachedURLResponse.response, error: nil, request: request)
        }
        print("--> REMOTE")
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

extension CachedURLResponse {
    func hasExpired(_ request: APIRequest) -> Bool {
        guard
            let httpResponse = response as? HTTPURLResponse,
            let cacheDate = httpResponse.value(forHTTPHeaderField: "Date")?.formatResponseHeaderDate()
        else {
            return true
        }
        switch request.cachePolicy {
        case .none:
            return true
        case let .ttl(time):
            return abs(cacheDate.timeIntervalSinceNow) > time
        }
    }
}

extension String {
    func formatResponseHeaderDate() -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "EEE,d MMM yyyy HH:mm:ss zzz"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        return dateFormatter.date(from: self)
    }
}

