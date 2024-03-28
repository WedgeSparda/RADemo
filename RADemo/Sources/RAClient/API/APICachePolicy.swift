import Foundation

enum APICachePolicy {
    case none
    case ttl(TimeInterval)
    
    var requestCachePolicy: NSURLRequest.CachePolicy {
        switch self {
        case .none:
            .reloadIgnoringLocalCacheData
        case .ttl:
            .returnCacheDataElseLoad
        }
    }
}
