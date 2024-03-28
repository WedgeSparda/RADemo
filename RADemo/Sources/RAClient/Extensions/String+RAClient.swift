import Foundation

extension String {
    func formatResponseHeaderDate() -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "EEE,d MMM yyyy HH:mm:ss zzz"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        return dateFormatter.date(from: self)
    }
}
