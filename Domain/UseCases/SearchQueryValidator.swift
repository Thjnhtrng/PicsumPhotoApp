import Foundation

struct SearchQueryValidator {
    private static let allowedPattern = "^[a-zA-Z0-9 !@#$%^&*():.,<>/\\[\\]?]*$"
    
    static func sanitize(input: String) -> String {
        let truncated = String(input.prefix(15))
        let filtered = truncated.filter { char in
            let str = String(char)
            return str.range(of: allowedPattern, options: .regularExpression) != nil
        }
        return filtered
    }
}
