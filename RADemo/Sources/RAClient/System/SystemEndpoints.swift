import Foundation

enum SystemEndpoints: APIRequestV1 {
    case getSystems(onlyGameSystems: Bool, onlyActive: Bool)
    
    var path: String {
        switch self {
        case .getSystems(let onlyGameSystems, let onlyActive):
            "/API/API_GetConsoleIDs.php"
        }
    }
    
    var queryParams: [URLQueryItem] {
        switch self {
        case let .getSystems(onlyGameSystems, onlyActive):
            [
                URLQueryItem(name: "g", value: onlyGameSystems ? "1" : "0"),
                URLQueryItem(name: "a", value: onlyActive ? "1" : "0")
            ]
        }
    }
}
