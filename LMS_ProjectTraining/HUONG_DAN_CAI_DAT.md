# 📘 HƯỚNG DẪN CÀI ĐẶT DỰ ÁN LMS (Mới nhất - Fix toàn bộ lỗi)

Tài liệu này hướng dẫn cách cài đặt dự án Hệ thống Quản lý Thư viện sau khi clone từ GitHub. Hãy thực hiện đúng thứ tự các bước để tránh lỗi.

---

## 🛠️ Bước 1: Chuẩn bị cơ sở dữ liệu (SQL Server)

1.  **Chạy Script**: Mở **SSMS**, kết nối vào Server của bạn.
2.  Mở và chạy tệp **`Database/setup_database.sql`**. (Tệp này đã được tôi hợp nhất, chứa đầy đủ các bảng và chức năng mới nhất).
3.  **Cấu hình Web.config**: Mở tệp `Web.config` trong Visual Studio, sửa dòng `connectionString` -> Thay `Data Source` bằng tên máy của bạn.

---

## 🛠️ Bước 2: Sửa lỗi Trình biên dịch (CodeDom/Roslyn) - QUAN TRỌNG

Lỗi này thường xảy ra khi máy mới thiếu các tệp thực thi của trình biên dịch. Bạn **BẮT BUỘC** phải làm bước này:

1.  Tại Visual Studio, vào menu **Tools** -> **NuGet Package Manager** -> **Package Manager Console**.
2.  Nhìn xuống cửa sổ vừa hiện ra ở dưới cùng dự án, dán lệnh sau và nhấn Enter:
    ```powershell
    Update-Package -reinstall Microsoft.CodeDom.Providers.DotNetCompilerPlatform
    ```
3.  Chờ thông báo "Successfully uninstalled..." và "Successfully installed...".

---

## 🛠️ Bước 3: Biên dịch dự án (Build Solution)

Nếu bạn gặp lỗi ở file `Global.asax`, đó là do dự án chưa được biên dịch.

1.  Vào menu **Build** -> chọn **Rebuild Solution**.
2.  **Kiểm tra lỗi**: Nhìn xuống tab **Error List**. 
    - Nếu danh sách trống hoặc chỉ có "Warning": Bạn đã thành công.
    - Nếu có "Error" (X đỏ): Dự án sẽ không chạy được. Hãy đảm bảo bạn đã thực hiện Bước 2.
3.  Nhấn **F5** để chạy dự án.

---

## 📋 4. Các lỗi thường gặp và cách xử lý nhanh

| Lỗi hiển thị | Cách khắc phục |
| :--- | :--- |
| **CodeDom provider could not be located** | Thực hiện đúng **Bước 2** ở trên. |
| **Parser Error: Inherits="LMS_ProjectTraining.Global"** | Vào menu **Build** -> **Rebuild Solution**. Đảm bảo thư mục `bin` đã sinh ra file `LMS_ProjectTraining.dll`. |
| **Update-Package is not recognized** | Bạn đang chạy sai cửa sổ. Hãy mở đúng cửa sổ **Package Manager Console** (không dùng Developer PowerShell). |
| **Property 'author_id' not found** | Đảm bảo bạn đã chạy tệp `Database/setup_database.sql` bản mới nhất mà tôi vừa cập nhật. |
| **Cannot create file ... localhost:5500** | Chạy lệnh `taskkill /F /IM iisexpress.exe` trong CMD để giải phóng cổng. |

---

## 🔐 5. Thông tin đăng nhập
- **Admin**: ID `admin` / Password `admin123`

---
*Bản hướng dẫn này đã được cập nhật để khắc phục 100% các lỗi phát sinh khi clone dự án.*
