import Foundation

extension TimeInterval {
    
    static var oneHour: TimeInterval { 60 * 60 }
    static var oneMinute: TimeInterval { 60 }
    static var oneDay: TimeInterval { oneHour * 24 }
    
    static func minutes(_ minutes: Int) -> TimeInterval {
        oneMinute * Double(minutes)
    }
    
    static func hours(_ hours: Int) -> TimeInterval {
        oneHour * Double(hours)
    }
    
    static func days(_ days: Int) -> TimeInterval {
        oneDay * Double(days)
    }
}
