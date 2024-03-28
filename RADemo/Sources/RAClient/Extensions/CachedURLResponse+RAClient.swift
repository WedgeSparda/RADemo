import Foundation

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
