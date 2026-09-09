// Unit Test cho logic Validator
import XCTest

final class SearchQueryValidatorTests: XCTestCase {
    
    func testSanitize_ValidText_ReturnsUnchanged() {
        let input = "John123"
        XCTAssertEqual(SearchQueryValidator.sanitize(input: input), "John123")
    }
    
    func testSanitize_AllowedSpecialChars_ReturnsUnchanged() {
        let input = "abc!@#$."
        XCTAssertEqual(SearchQueryValidator.sanitize(input: input), "abc!@#$.")
    }
    
    func testSanitize_AccentedVietnameseAndEmoji_StripsInvalidChars() {
        let input = "Nguyễn Dương Trường Thịnh 😀"
        // Loại bỏ dấu tiếng Việt và Emoji
        XCTAssertEqual(SearchQueryValidator.sanitize(input: input), "Nguyn Dng Trng Thnh")
    }
    
    func testSanitize_Exceeds15Characters_TruncatesLength() {
        let input = "1234567890123456789"
        let result = SearchQueryValidator.sanitize(input: input)
        XCTAssertEqual(result.count, 15)
        XCTAssertEqual(result, "123456789012345")
    }
}