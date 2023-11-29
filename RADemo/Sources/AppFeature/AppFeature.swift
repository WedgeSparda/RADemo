import ComposableArchitecture
import SplashFeature
import MainFeature

@Reducer
public struct AppFeature {
    
    public init() {}
    
    @ObservableState
    public enum State: Equatable {
        case splash(SplashFeature.State)
        case main(MainFeature.State)
    }
    
    public enum Action {
        case onAppear
        
        case splash(SplashFeature.Action)
        case main(MainFeature.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                print("APP ON APPEAR")
                return .none

            case .splash(.onAppReady):
                state = .main(
                    .init()
                )
                return .none
                
            case .splash:
                return .none
                
            case .main:
                return .none
            }
        }
        .ifCaseLet(\.splash, action: \.splash) {
            SplashFeature()
        }
        .ifCaseLet(\.main, action: \.main) {
            MainFeature()
        }
    }
}
