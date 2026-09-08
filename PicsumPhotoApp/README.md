# VNPAYPicsumPhotoApp
Picsum Photo App (iOS) – Ứng dụng quản lý và hiển thị hình ảnh viết bằng ngôn ngữ Swift (UIKit) native, xây dựng theo chuẩn Clean Architecture và không phụ thuộc vào thư viện thứ 3. 

Điểm nổi bật:
1. Hiển thị danh sách UITableView tự động căn chỉnh tỉ lệ, bảo toàn kích thước gốc và không bị móp/méo ảnh.
2. Hệ thống tải ảnh bất đồng bộ tích hợp bộ nhớ đệm NSCache đảm bảo cuộn mượt mà.
3. Phân trang thông minh có loading indicator và tính năng vuốt để làm mới.
4. Tìm kiếm thời gian thực kèm bộ lọc Validation chặt chẽ (giới hạn 15 ký tự, tự động loại bỏ tiếng Việt có dấu, emoji khi dán hoặc gõ Swipe Typing).
5. Bao phủ bởi Unit Test và tự động hóa cấu hình bằng XcodeGen

Hướng dẫn Build & Chạy dự án (Reviewer)
Dự án sử dụng XcodeGen để tự động tạo file cấu hình .xcodeproj chuẩn định dạng

Cách 1: Sử dụng XcodeGen (Recommend)
1. Cài đặt XcodeGen qua Homebrew trên máy Mac (nếu chưa cài):
   Bash
   brew   install   xcodegen
2. Mở Terminal tại thư mục gốc của project và chạy lệnh:
   Bash
   xcodegen   generate
4. Mở file PicsumPhotoApp.xcodeproj được tạo bằng Xcode.
5. Bấm Cmd + R để chạy App trên Simulator hoặc bấm Cmd + U để chạy Unit Tests.

Cách 2: Import thủ công vào Xcode
1. Mở Xcode -> Chọn Create a new Xcode project -> iOS App -> Đặt tên PicsumPhotoApp
2. Kéo các file App, Domain, Data, Presentation, Tests từ thư mục dự án vào Xcode
3. Nhấn Cmd + R để chạy ứng dụng.
