import Foundation

// 1. TEST VALIDATOR LOGIC
print("--------------------------------------------------")
print("1. KIỂM TRA VALIDATION SEARCH QUERY")
print("--------------------------------------------------")

let testCases = [
    ("Nguyễn Văn A", "Nguyn Vn A", "Lọc tiếng Việt có dấu"),
    ("1234567890123456789", "123456789012345", "Cắt tối đa 15 ký tự"),
    ("Hello 😀 World", "Hello  World", "Loại bỏ Emoji"),
    ("Photo!@#$%", "Photo!@#$%", "Cho phép ký tự đặc biệt hợp lệ"),
    ("Invalid<>~`", "Invalid<>", "Loại bỏ ký tự đặc biệt không nằm trong danh sách")
]

for (input, expected, description) in testCases {
    let result = SearchQueryValidator.sanitize(input: input)
    let status = (result == expected) ? "PASSED" : "FAILED"
    print("[\(status)] \(description)")
    print("   Input: '\(input)' -> Output: '\(result)' (Expected: '\(expected)')\n")
}

// 2. TEST CALL API THỰC TẾ & PARSE JSON
print("--------------------------------------------------")
print("2. KIỂM TRA GỌI API PICSUM VÀ PARSE DATA")
print("--------------------------------------------------")

let urlString = "https://picsum.photos/v2/list?page=1&limit=5"
guard let url = URL(string: urlString) else {
    print("URL không hợp lệ")
    exit(1)
}

let semaphore = DispatchSemaphore(value: 0)

let task = URLSession.shared.dataTask(with: url) { data, response, error in
    defer { semaphore.signal() }
    
    if let error = error {
        print("Lỗi gọi API: \(error.localizedDescription)")
        return
    }
    
    guard let data = data else {
        print("Không nhận được dữ liệu từ API")
        return
    }
    
    do {
        let dtos = try JSONDecoder().decode([PhotoDTO].self, from: data)
        let photos = dtos.map { $0.toDomain() }
        
        print("Tải thành công \(photos.count) ảnh từ API Picsum!\n")
        for (index, photo) in photos.enumerated() {
            print("[\(index + 1)] Author: \(photo.author)")
            print("     Size: \(photo.width)x\(photo.height)")
            print("     Aspect Ratio Multiplier: \(photo.aspectRatioMultiplier)")
            print("     URL: \(photo.downloadUrl)\n")
        }
    } catch {
        print("Lỗi Parse JSON: \(error)")
    }
}

task.resume()
semaphore.wait()
print("=== HOÀN TẤT CHECK LOGIC TRÊN WINDOWS ===")