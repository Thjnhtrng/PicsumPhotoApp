Picsum Photo List App (iOS)
Ứng dụng hiển thị danh sách hình ảnh từ Picsum API. Dự án được xây dựng hoàn toàn bằng ngôn ngữ Swift (UIKit) native, tuân thủ kiến trúc Clean Architecture và không sử dụng bất kỳ thư viện thứ 3 nào.

Các tính năng đã hoàn thành (Features)
Danh sách hình ảnh (Photo List): Hiển thị ảnh, tên tác giả (Author) và kích thước (Size). Ảnh tự động điều chỉnh tỉ lệ theo kích thước gốc, đảm bảo không bị móp/biến dạng ảnh.
Phân trang (Paging) & Load More: Mõi trang tải 100 ảnh, có hiển thị indicator "loading..." ở cuối danh sách.
Pull to Refresh: Vuốt từ đỉnh danh sách để làm mới nội dung.
Bộ lọc & Tìm kiếm (Search & Validation):
Hiệu năng cao: Sử dụng NSCache để lưu ảnh tạm thời, cuộn danh sách UITableView mượt mà, không giật lag.
Unit Testing: Kiểm thử tự động đầy đủ cho lớp SearchQueryValidator.

Clean Architecture
Dự án chia làm 3 layer:
Domain Layer: Entities & UseCases (Business Logic)
Data Layer: DTOs & Repositories (Networking & Caching)
Presentation Layer: Controllers & Views (UIKit UI)


Hướng dẫn Build & Chạy dự án (Reviewer)
Dự án sử dụng XcodeGen để tự động tạo file cấu hình .xcodeproj chuẩn định dạng.

Cách 1: Sử dụng XcodeGen (Recommend)
Cài đặt XcodeGen qua Homebrew trên máy Mac (nếu chưa cài):
Bash
brew install xcodegen

Mở Terminal tại thư mục gốc của project và chạy lệnh:
xcodegen generate
Mở file PicsumPhotoApp.xcodeproj vừa được tạo bằng Xcode.
Bấm Cmd + R để chạy ứng dụng trên Simulator/Device hoặc bấm Cmd + U để thực thi Unit Tests.

Cách 2: Import thủ công vào Xcode
Mở Xcode -> Chọn Create a new Xcode project -> iOS App -> Đặt tên PicsumPhotoApp.
Kéo các thư mục App, Domain, Data, Presentation, Tests từ thư mục dự án vào Xcode.
Nhấn Cmd + R để chạy thử ứng dụng. 
