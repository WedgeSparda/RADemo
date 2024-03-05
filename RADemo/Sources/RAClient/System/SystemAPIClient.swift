import Foundation
import ComposableArchitecture

public protocol SystemAPIClientProtocol {
    func getAll() async -> Result<[SystemAPIModel], HTTPError>
}

struct LiveSystemAPIClient: SystemAPIClientProtocol {
    
    private let apiClient = RAClient()
    
    func getAll() async -> Result<[SystemAPIModel], HTTPError> {
        let response = await apiClient.request()
        switch response.result {
        case let .success(data):
            guard let data else {
                return .failure(.unknown)
            }
            do {
                let value = try JSONDecoder().decode([SystemAPIModel].self, from: data)
                return .success(value)
            } catch {
                return .failure(.parsingError(error))
            }
        case let .failure(error):
            return .failure(error)
        }
    }
}

private enum SystemAPIClient: DependencyKey {
    public static var liveValue: any SystemAPIClientProtocol = LiveSystemAPIClient()
}

extension DependencyValues {
    public var systemAPIClient: SystemAPIClientProtocol {
        get { self[SystemAPIClient.self] }
        set { self[SystemAPIClient.self] = newValue }
    }
}
