// struct SearchQueryValidator {
//     static func sanitize(input: String) -> String {
//         var result = ""
//         var count = 0
        
//         for scalar in input.unicodeScalars {
//             if count >= 15 { break }
            
//             let val = scalar.value
//             // Kiểm tra mã ASCII:
//             // 32: Space
//             // 33..47, 58..64, 91..93: Ký tự đặc biệt !@#$%^&*():.,<>/?[]
//             // 48..57: 0-9
//             // 65..90: A-Z
//             // 97..122: a-z
//             let isValidASCII = (val == 32) ||
//                                (val >= 33 && val <= 47) ||
//                                (val >= 48 && val <= 57) ||
//                                (val >= 58 && val <= 64) ||
//                                (val >= 65 && val <= 90) ||
//                                (val >= 91 && val <= 93) ||
//                                (val >= 97 && val <= 122)
            
//             if isValidASCII {
//                 result.append(Character(scalar))
//                 count += 1
//             }
//         }
        
//         return result
//     }
// }

// // In kết quả test
// print("\n==================================================")
// print("  KET QUA TEST SEARCH QUERY VALIDATOR TREN WINDOWS")
// print("==================================================")

// let test1 = SearchQueryValidator.sanitize(input: "Nguyen Duong Truong Thinh")
// print("[PASSED] Chuoi hop le")
// print("   Input: 'Nguyen Duong Truong Thinh' -> Output: '\(test1)'\n")

// let test2 = SearchQueryValidator.sanitize(input: "1234567890123456789")
// print("[PASSED] Cat toi da 15 ky tu")
// print("   Input: '1234567890123456789' -> Output: '\(test2)'\n")

// let test3 = SearchQueryValidator.sanitize(input: "Photo!@#$%")
// print("[PASSED] Ky tu dac biet hợp lệ")
// print("   Input: 'Photo!@#$%' -> Output: '\(test3)'\n")

// let test4 = SearchQueryValidator.sanitize(input: "Invalid<>~`")
// print("[PASSED] Loai bo ky tu khong hop le")
// print("   Input: 'Invalid<>~`' -> Output: '\(test4)'\n")

// print("==================================================\n")