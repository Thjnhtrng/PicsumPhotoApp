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
        
        // Ký tự có dấu (ASCII > 122) và Emoji bị lọc bỏ hoàn toàn, dấu cách được giữ nguyên
        let expected = "Nguyn Dng Trng Thnh "
        XCTAssertEqual(SearchQueryValidator.sanitize(input: input), expected)
    }
    
    func testSanitize_Exceeds15Characters_TruncatesLength() {
        let input = "1234567890123456789"
        let result = SearchQueryValidator.sanitize(input: input)
        XCTAssertEqual(result.count, 15)
        XCTAssertEqual(result, "123456789012345")
    }
    
    func testSanitize_DisallowedSpecialChars_RemovesInvalidOnes() {
        let input = "Invalid<>~`"
        // '~' và '`' có mã ASCII không nằm trong dải cho phép nên bị xóa
        XCTAssertEqual(SearchQueryValidator.sanitize(input: input), "Invalid<>")
    }
}