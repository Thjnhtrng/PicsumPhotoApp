# Picsum Photo List App (iOS)

Ứng dụng hiển thị danh sách hình ảnh từ Picsum API. Dự án được xây dựng hoàn toàn bằng ngôn ngữ Swift (UIKit) native, tuân thủ kiến trúc Clean Architecture và không sử dụng bất kỳ thư viện thứ 3 nào.

## Các tính năng đã hoàn thành (Features)
1. Danh sách hình ảnh (Photo List): Hiển thị ảnh, tên tác giả (Author) và kích thước (Size). Ảnh tự động điều chỉnh tỉ lệ theo kích thước gốc, đảm bảo không bị móp/biến dạng ảnh.
2. Phân trang (Paging) & Load More: Mõi trang tải 100 ảnh, có hiển thị indicator "loading..." ở cuối danh sách.
3. Pull to Refresh: Vuốt từ đỉnh danh sách để làm mới nội dung.
4. Bộ lọc & Tìm kiếm (Search & Validation):
5. Hiệu năng cao: Sử dụng NSCache để lưu ảnh tạm thời, cuộn danh sách UITableView mượt mà, không giật lag.
6. Unit Testing: Kiểm thử tự động đầy đủ cho lớp SearchQueryValidator.

## Clean Architecture
Dự án chia làm 3 layer:
- Domain Layer: Entities & UseCases (Business Logic)
- Data Layer: DTOs & Repositories (Networking & Caching)
- Presentation Layer: Controllers & Views (UIKit UI)


## Hướng dẫn Build & Chạy dự án (Reviewer)
Dự án sử dụng XcodeGen để tự động tạo file cấu hình .xcodeproj chuẩn định dạng.

### Cách 1: Sử dụng XcodeGen (Recommend)
1. Cài đặt XcodeGen qua Homebrew trên máy Mac (nếu chưa cài):
Bash
brew install xcodegen
2. Mở Terminal tại thư mục gốc của project và chạy lệnh:
xcodegen generate
3. Mở file PicsumPhotoApp.xcodeproj vừa được tạo bằng Xcode.
4. Bấm Cmd + R để chạy ứng dụng trên Simulator/Device hoặc bấm Cmd + U để thực thi Unit Tests.

### Cách 2: Import thủ công vào Xcode
1. Mở Xcode -> Chọn Create a new Xcode project -> iOS App -> Đặt tên PicsumPhotoApp.
2. Kéo các thư mục App, Domain, Data, Presentation, Tests từ thư mục dự án vào Xcode.
3. Nhấn Cmd + R để chạy thử ứng dụng. 
