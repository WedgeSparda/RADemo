public enum GameType: Equatable, Identifiable {
    case core
    case demo
    case hack
    case homebrew
    case prototype
    case testKit
    case subset(String)
    case unlicensed

    public var id: Int {
        switch self {
        case .core:
            0
        case .demo:
            1
        case .hack:
            2
        case .homebrew:
            3
        case .prototype:
            4
        case .testKit:
            5
        case .subset:
            6
        case .unlicensed:
            7
        }
    }
    
    public var text: String {
        switch self {
        case .core:
            ""
        case .demo:
            "Demo"
        case .hack:
            "Hack"
        case .homebrew:
            "Homebrew"
        case .prototype:
            "Prototype"
        case .testKit:
            "Testkit"
        case .subset:
            "Subset"
        case .unlicensed:
            "Unlicensed"
        }
    }
}
