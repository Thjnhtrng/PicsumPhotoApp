# Script tự động khởi tạo cấu trúc Clean Architecture cho iOS App

$directories = @(
    "App",
    "Domain\Entities",
    "Domain\UseCases",
    "Data\DTOs",
    "Data\Repositories",
    "Presentation\Views",
    "Presentation\Controllers",
    "Presentation\ViewModels",
    "Tests"
)

# Tạo các thư mục
foreach ($dir in $directories) {
    if (!(Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir | Out-Null
        Write-Host "Created directory: $dir" -ForegroundColor Green
    }
}

# 1. Domain/Entities/Photo.swift
@"
import Foundation

struct Photo {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let downloadUrl: String
    
    var aspectRatio: Double {
        guard height > 0 else { return 1.0 }
        return Double(width) / Double(height)
    }
}
"@ | Out-File -FilePath "Domain\Entities\Photo.swift" -Encoding utf8

# 2. Domain/UseCases/SearchQueryValidator.swift
@"
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
"@ | Out-File -FilePath "Domain\UseCases\SearchQueryValidator.swift" -Encoding utf8

# 3. Data/DTOs/PhotoDTO.swift
@"
import Foundation

struct PhotoDTO: Decodable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let download_url: String
    
    func toDomain() -> Photo {
        return Photo(id: id, author: author, width: width, height: height, downloadUrl: download_url)
    }
}
"@ | Out-File -FilePath "Data\DTOs\PhotoDTO.swift" -Encoding utf8

# 4. Data/Repositories/ImageLoader.swift
@"
import Foundation

// File này chứa logic Cache Image native
final class ImageLoader {
    static let shared = ImageLoader()
    private init() {}
}
"@ | Out-File -FilePath "Data\Repositories\ImageLoader.swift" -Encoding utf8

# 5. Presentation/Views/PhotoTableViewCell.swift
@"
// UI Component cho Cell - Viết giao diện UIKit
"@ | Out-File -FilePath "Presentation\Views\PhotoTableViewCell.swift" -Encoding utf8

# 6. Presentation/Controllers/PhotoListViewController.swift
@"
// Controller chính quản lý TableView, Paging, Search
"@ | Out-File -FilePath "Presentation\Controllers\PhotoListViewController.swift" -Encoding utf8

# 7. Tests/SearchQueryValidatorTests.swift
@"
// Unit Test cho logic Validator
"@ | Out-File -FilePath "Tests\SearchQueryValidatorTests.swift" -Encoding utf8

# 8. README.md
@"
# Picsum Photo List App (Clean Architecture)

## Architecture
- **Domain**: Entities & UseCases (Business Logic)
- **Data**: DTOs & Repositories (Networking & Caching)
- **Presentation**: Controllers & Views (UIKit UI)

## Requirements
- iOS 12.0+
- Xcode 11.0+
- No Third-party libraries used.
"@ | Out-File -FilePath "README.md" -Encoding utf8

Write-Host "`nProject structure created successfully!" -ForegroundColor Cyan