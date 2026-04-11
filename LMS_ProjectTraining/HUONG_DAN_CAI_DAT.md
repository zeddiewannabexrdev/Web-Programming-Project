# 📘 HƯỚNG DẪN CÀI ĐẶT VÀ CHẠY DỰ ÁN LMS (Library Management System)

Dưới đây là các bước chi tiếp để cài đặt môi trường và chạy dự án Quản lý Thư viện trên máy tính cá nhân (Localhost).

---

## 🛠️ 1. Cài đặt các phần mềm cần thiết

Để dự án chạy ổn định, bạn cần cài đặt 3 công cụ chính sau:

### 1.1 Microsoft SQL Server (Lưu trữ dữ liệu)
- **Bước 1**: Tải [SQL Server Express](https://www.microsoft.com/en-us/sql-server/sql-server-downloads) (chọn bản Express - Miễn phí).
- **Bước 2**: Chạy file cài đặt, chọn kiểu cài đặt **"Basic"**. 
- **Bước 3**: Sau khi cài xong, nó sẽ hiện một cửa sổ. Nhấn vào nút **"Install SSMS"** để tải thêm công cụ quản lý giao diện.

### 1.2 SQL Server Management Studio (SSMS - Quản lý DB)
- **Bước 1**: Tải và cài đặt theo link từ bước trên (hoặc tải trực tiếp tại [đây](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms)).
- **Bước 2**: Cài đặt mặc định và khởi động lại máy nếu được yêu cầu.

### 1.3 Visual Studio (Soạn thảo và Chạy Web)
- **Phiên bản**: Khuyên dùng 2019 hoặc 2022 (Bản Community - Miễn phí).
- **Lưu ý quan trọng**: Khi cài đặt, bạn **PHẢI** tích chọn workload: **"ASP.NET and web development"**. Nếu thiếu workload này, bạn sẽ không thể mở và chạy được dự án web.

---

## 🚀 2. Thiết lập dự án trên Localhost

### Bước 2.1: Clone dự án
Sử dụng Git để lấy mã nguồn:
```bash
git clone https://github.com/zeddiewannabexrdev/Web-Programming-Project.git
```

### Bước 2.2: Tạo Cơ sở dữ liệu và Các Stored Procedure
1. Mở **SSMS**, kết nối vào Server (Server name thường là `.\SQLEXPRESS` hoặc `TÊN-MÁY\SQLEXPRESS`).
2. Nhấn **File -> Open -> File** và chọn tệp **`Database/setup_database.sql`**. Nhấn **Execute (F5)** để chạy. 
   *(Thao tác này sẽ tạo ra Database `ELibraryDB_Project001` và các bảng dữ liệu)*.
3. **TIẾP THEO**: Mở tiếp tệp **`Database/LATEST_FINAL_FIX.sql`** và nhấn **Execute (F5)**. 
   > [!IMPORTANT]
   > Đây là bước bắt buộc để khắc phục các lỗi về đặt tên tham số (như `@book_id`, `@member_id`), đảm bảo các tính năng Thêm sách và Tiền phạt hoạt động đúng.

### Bước 2.3: Cấu hình Kết nối (Web.config)
1. Trong thư mục dự án, tìm file **`Web.config`**.
2. Tìm đến thẻ `<connectionStrings>` và đổi phần `Data Source` thành tên SQL Server trên máy bạn:
   - Cách tìm tên máy: Trong SSMS, dòng đầu tiên của mục Object Explorer chính là tên Server.
```xml
<add name="cn" connectionString="Data Source=TÊN_MÁY_CỦA_BẠN\SQLEXPRESS;Initial Catalog=ELibraryDB_Project001;Integrated Security=true" />
```

### Bước 2.4: Chạy Website
1. Nhấp đúp vào tệp **`LMS_ProjectTraining.sln`** để mở dự án bằng Visual Studio.
2. Chuột phải vào tên dự án (LMS_ProjectTraining) ở panel bên phải -> Chọn **Restore NuGet Packages**.
3. Nhấn **F5** để khởi động trình duyệt. Website sẽ hiện ra tại cổng mặc định (thường là 5500).

---

## 📑 3. Thông tin Đăng nhập mặc định

- **Admin Account**: 
  - ID: `admin` | Pass: `admin123`
- **User Account**: 
  - Bạn có thể tự đăng ký tại mục **Sign Up**, sau đó dùng tài khoản Admin để duyệt (Active) thành viên thì mới đăng nhập được.

---

## 🔧 4. Xử lý lỗi thường gặp

1. **Lỗi cổng 5500 (Port conflict)**: Nếu báo lỗi không thể khởi động IIS Express, hãy mở CMD và chạy lệnh: `taskkill /F /IM iisexpress.exe`, sau đó chạy lại F5 trong Visual Studio.
2. **Lỗi tham số '@id'**: Đảm bảo bạn đã chạy file `LATEST_FINAL_FIX.sql` ở Bước 2.2.
3. **Lỗi thiếu thư viện**: Thử chuột phải vào Solution -> **Rebuild Solution**.

---
*Dự án hỗ trợ đa ngôn ngữ Anh - Việt. Chúc bạn có trải nghiệm tốt nhất với hệ thống!*
