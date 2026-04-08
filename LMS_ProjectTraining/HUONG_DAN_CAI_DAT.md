# 📘 HƯỚNG DẪN CÀI ĐẶT VÀ CHẠY DỰ ÁN LMS (Library Management System)

## 📋 Mục lục

1. [Yêu cầu phần mềm](#1-yêu-cầu-phần-mềm)
2. [Clone dự án](#2-clone-dự-án)
3. [Cài đặt SQL Server](#3-cài-đặt-sql-server)
4. [Tạo Database](#4-tạo-database)
5. [Cấu hình Connection String](#5-cấu-hình-connection-string)
6. [Restore NuGet Packages](#6-restore-nuget-packages)
7. [Build và chạy dự án](#7-build-và-chạy-dự-án)
8. [Đăng nhập và sử dụng](#8-đăng-nhập-và-sử-dụng)
9. [Xử lý lỗi thường gặp](#9-xử-lý-lỗi-thường-gặp)

---

## 1. Yêu cầu phần mềm

Trước khi bắt đầu, hãy đảm bảo máy bạn đã cài đặt các phần mềm sau:

| Phần mềm | Phiên bản tối thiểu | Link tải |
|---|---|---|
| **Visual Studio** | 2019 trở lên (khuyên dùng 2022) | [https://visualstudio.microsoft.com/](https://visualstudio.microsoft.com/) |
| **SQL Server Express** | 2019 trở lên | [https://www.microsoft.com/en-us/sql-server/sql-server-downloads](https://www.microsoft.com/en-us/sql-server/sql-server-downloads) |
| **SQL Server Management Studio (SSMS)** | 18.x trở lên | [https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms) |
| **Git** | Bất kỳ | [https://git-scm.com/downloads](https://git-scm.com/downloads) |

### ⚠️ Lưu ý khi cài Visual Studio

Khi cài Visual Studio, bạn **BẮT BUỘC** phải chọn workload:
- ✅ **ASP.NET and web development**
- ✅ **.NET desktop development**

Nếu đã cài rồi mà thiếu, mở **Visual Studio Installer** → **Modify** → tích chọn 2 workload trên → **Install**.

---

## 2. Clone dự án

Mở **Command Prompt** hoặc **PowerShell**, chạy:

```bash
git clone https://github.com/zeddiewannabexrdev/Web-Programming-Project.git
```

Hoặc tải ZIP từ GitHub:
1. Vào trang GitHub của dự án
2. Nhấn nút **Code** → **Download ZIP**
3. Giải nén vào thư mục tùy chọn

Sau khi clone/giải nén, bạn sẽ thấy cấu trúc thư mục:
```
Web-Programming-Project/
└── LMS_ProjectTraining/
    ├── LMS_ProjectTraining.sln    ← File chính để mở dự án
    ├── LMS_ProjectTraining.csproj
    ├── Web.config
    ├── setup_database.sql          ← Script tạo database
    ├── Admin/
    ├── UserScreen/
    ├── bootstrap/
    └── ...
```

---

## 3. Cài đặt SQL Server

### Bước 3.1: Cài SQL Server Express

1. Tải **SQL Server Express** từ link ở trên
2. Chạy file cài đặt → Chọn **Basic**
3. Chấp nhận điều khoản → Chờ cài đặt hoàn tất
4. Ghi nhớ **Instance Name** (mặc định là `SQLEXPRESS`)

### Bước 3.2: Cài SQL Server Management Studio (SSMS)

1. Tải SSMS từ link ở trên
2. Chạy file cài đặt → **Install**
3. Khởi động lại máy nếu được yêu cầu

### Bước 3.3: Kiểm tra SQL Server đang chạy

Mở **PowerShell** và chạy:
```powershell
Get-Service -Name "MSSQL*"
```

Kết quả phải hiện:
```
Name              Status
----              ------
MSSQL$SQLEXPRESS  Running
```

Nếu Status là **Stopped**, chạy:
```powershell
Start-Service -Name "MSSQL`$SQLEXPRESS"
```

---

## 4. Tạo Database

### Cách 1: Dùng SSMS (Giao diện) — Khuyên dùng

1. Mở **SQL Server Management Studio (SSMS)**
2. Kết nối: 
   - **Server name**: `TÊN_MÁY_BẠN\SQLEXPRESS`  
     (Ví dụ: `ASUS\SQLEXPRESS`, `DESKTOP-ABC123\SQLEXPRESS`)
   - **Authentication**: `Windows Authentication`
   - Nhấn **Connect**

3. Mở file `setup_database.sql` trong SSMS:
   - **File** → **Open** → **File...**
   - Duyệt tới thư mục dự án, chọn file `setup_database.sql`
   - Nhấn **Open**

4. Nhấn **Execute** (hoặc phím **F5**) để chạy script

5. Kiểm tra: Ở panel bên trái, expand **Databases** → Phải thấy `ELibraryDB_Project001`

### Cách 2: Dùng Command Line

Mở **PowerShell**, chạy:

```powershell
# Tìm tên máy
$env:COMPUTERNAME

# Chạy script (thay TÊN_MÁY bằng tên máy thật)
sqlcmd -S TÊN_MÁY\SQLEXPRESS -i "đường_dẫn_tới\setup_database.sql"
```

Ví dụ:
```powershell
sqlcmd -S ASUS\SQLEXPRESS -i "G:\BTL\LMS_ProjectTraining\setup_database.sql"
```

Kết quả thành công sẽ hiện:
```
========================================
Database setup completed successfully!
Admin account: admin / admin123
========================================
```

### Xác nhận Database đã tạo thành công

Chạy lệnh kiểm tra:
```powershell
sqlcmd -S TÊN_MÁY\SQLEXPRESS -Q "USE ELibraryDB_Project001; SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES" -W
```

Phải hiện ra 7 bảng:
```
TABLE_NAME
-----------
member_master_tbl
admin_tbl
author_tbl
publisher_tbl
book_master_tbl
book_issue_tbl
BookFineRecord
```

---

## 5. Cấu hình Connection String

### Bước 5.1: Tìm tên SQL Server Instance trên máy bạn

Mở **PowerShell** và chạy:
```powershell
$env:COMPUTERNAME
```
→ Ghi nhớ kết quả. Ví dụ: `ASUS`

Connection string sẽ là: `ASUS\SQLEXPRESS`

### Bước 5.2: Sửa file Web.config

1. Mở file `Web.config` trong thư mục dự án (dùng Notepad hoặc Visual Studio)
2. Tìm dòng chứa `connectionStrings`:

```xml
<connectionStrings>
    <add name="cn" connectionString="Data Source=DESKTOP-I69OQPV\SQLEXPRESS;Initial Catalog=ELibraryDB_Project001;Integrated Security=true" />
</connectionStrings>
```

3. **Thay `DESKTOP-I69OQPV`** bằng tên máy của bạn:

```xml
<connectionStrings>
    <add name="cn" connectionString="Data Source=TÊN_MÁY_BẠN\SQLEXPRESS;Initial Catalog=ELibraryDB_Project001;Integrated Security=true" />
</connectionStrings>
```

Ví dụ nếu tên máy là `ASUS`:
```xml
<add name="cn" connectionString="Data Source=ASUS\SQLEXPRESS;Initial Catalog=ELibraryDB_Project001;Integrated Security=true" />
```

4. **Lưu file** (Ctrl+S)

---

## 6. Restore NuGet Packages

Dự án cần package `Microsoft.CodeDom.Providers.DotNetCompilerPlatform`. Thực hiện restore:

### Cách 1: Trong Visual Studio (Dễ nhất)

1. Mở file `LMS_ProjectTraining.sln` bằng Visual Studio
2. Visual Studio sẽ tự hiện thông báo **"Some NuGet packages are missing"**
3. Nhấn **Restore** ở thanh vàng phía trên

Hoặc: Chuột phải vào **Solution** → **Restore NuGet Packages**

### Cách 2: Dùng Command Line

```powershell
# Di chuyển vào thư mục dự án
cd "đường_dẫn_tới\LMS_ProjectTraining"

# Tải nuget.exe (chỉ cần làm 1 lần)
Invoke-WebRequest -Uri "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe" -OutFile "nuget.exe"

# Restore packages
.\nuget.exe restore "LMS_ProjectTraining.sln"
```

### ⚠️ Kiểm tra đường dẫn packages trong .csproj

Mở file `LMS_ProjectTraining.csproj`, kiểm tra dòng 2:

**Nếu thư mục `packages` nằm TRONG thư mục dự án** (cùng cấp với .csproj):
```xml
<Import Project="packages\Microsoft.CodeDom.Providers..." />
```

**Nếu thư mục `packages` nằm Ở THƯ MỤC CHA** (ngoài thư mục dự án):
```xml
<Import Project="..\packages\Microsoft.CodeDom.Providers..." />
```

→ Phải đảm bảo đường dẫn trỏ đúng vào thư mục `packages` thật sự. Nếu sai, sẽ gặp lỗi "Configuration Error" khi chạy.

---

## 7. Build và chạy dự án

### Bước 7.1: Mở dự án trong Visual Studio

1. Mở **Visual Studio**
2. Chọn **File** → **Open** → **Project/Solution**
3. Duyệt tới thư mục dự án, chọn file **`LMS_ProjectTraining.sln`**
4. Nhấn **Open**
5. Chờ Visual Studio tải xong (có thể mất 30 giây - 1 phút)

### Bước 7.2: Build dự án

1. Vào menu **Build** → **Build Solution** (hoặc nhấn **Ctrl+Shift+B**)
2. Xem cửa sổ **Output** ở dưới cùng
3. Phải hiển thị: `Build succeeded` hoặc `Build: 1 succeeded, 0 failed`

### Bước 7.3: Chạy dự án

1. Nhấn **F5** (Debug Mode) hoặc **Ctrl+F5** (không debug)
2. Trình duyệt sẽ tự động mở tại địa chỉ: `http://localhost:XXXX/default.aspx`
3. Bạn sẽ thấy trang chủ Library Management System

> **Lưu ý**: Số port (XXXX) có thể khác nhau mỗi lần. Ví dụ: `localhost:9729`, `localhost:44300`...

---

## 8. Đăng nhập và sử dụng

### 8.1 Đăng nhập Admin

1. Truy cập trang **Login** (nhấn nút **Sign In** trên navbar)
2. Chọn tab **"Admin Login"**
3. Nhập:
   - **Admin ID**: `admin`
   - **Password**: `admin123`
4. Nhấn **Admin Login**

### 8.2 Công việc đầu tiên của Admin

Sau khi đăng nhập Admin, thực hiện theo thứ tự:

1. **Thêm tác giả**: Vào **Add Author** → Nhập tên tác giả → **Add**
2. **Thêm nhà xuất bản**: Vào **Publisher** → Nhập tên NXB → **Add**
3. **Thêm sách**: Vào **Book Inventory** → Nhập thông tin sách → **Add**
4. **Duyệt thành viên**: Vào **Member** → Tìm thành viên pending → Đổi thành **active**

### 8.3 Đăng ký tài khoản User

1. Từ trang chủ, nhấn **Sign Up**
2. Điền thông tin: Member ID (tự sinh), Password, Full Name, DOB, Contact, Email, State, City, PIN, Address
3. Nhấn **Sign Up**
4. Tài khoản sẽ ở trạng thái **pending** → Cần Admin duyệt thành **active**

### 8.4 Đăng nhập User

1. Truy cập trang **Login** → Tab **"User Login"**
2. Nhập **Member ID** và **Password**
3. Nhấn **Login**
4. **Lưu ý**: Tài khoản phải được Admin duyệt (active) mới đăng nhập được

---

## 9. Xử lý lỗi thường gặp

### ❌ Lỗi 1: "Configuration Error - CodeDom provider could not be located"

**Nguyên nhân**: Thiếu NuGet package hoặc đường dẫn sai trong `.csproj`

**Cách fix**:
1. Restore NuGet packages (xem Bước 6)
2. Kiểm tra đường dẫn `packages` trong `.csproj` (xem ghi chú ở Bước 6)

---

### ❌ Lỗi 2: "Cannot open database ELibraryDB_Project001"

**Nguyên nhân**: Database chưa được tạo hoặc connection string sai

**Cách fix**:
1. Chạy script `setup_database.sql` (xem Bước 4)
2. Kiểm tra connection string trong `Web.config` (xem Bước 5)
3. Đảm bảo tên SQL Server instance đúng

---

### ❌ Lỗi 3: "A network-related or instance-specific error occurred"

**Nguyên nhân**: SQL Server chưa chạy hoặc tên instance sai

**Cách fix**:
```powershell
# Kiểm tra SQL Server có đang chạy không
Get-Service -Name "MSSQL*"

# Nếu Stopped, khởi động lại
Start-Service -Name "MSSQL`$SQLEXPRESS"
```

---

### ❌ Lỗi 4: "Object reference not set to an instance of an object" khi truy cập UserHome

**Nguyên nhân**: Chưa đăng nhập hoặc Session hết hạn

**Cách fix**: Quay lại trang Login và đăng nhập lại

---

### ❌ Lỗi 5: "Could not find stored procedure 'sp_xxx'"

**Nguyên nhân**: Stored Procedure chưa được tạo trong database

**Cách fix**: Chạy lại script `setup_database.sql` đầy đủ

---

### ❌ Lỗi 6: Build failed - "The type or namespace 'xxx' could not be found"

**Nguyên nhân**: Thiếu reference hoặc NuGet package

**Cách fix**:
1. Trong Visual Studio: **Tools** → **NuGet Package Manager** → **Package Manager Console**
2. Chạy: `Update-Package -reinstall`

---

## 📝 Tóm tắt các bước nhanh

```
1. Clone repo
2. Cài Visual Studio + SQL Server Express + SSMS
3. Mở SSMS → Kết nối SQL Server → Chạy setup_database.sql
4. Sửa Web.config → Thay tên máy trong connection string
5. Mở .sln bằng Visual Studio → Restore NuGet Packages
6. Nhấn F5 để chạy
7. Đăng nhập Admin: admin / admin123
```

---

*Tài liệu này được tạo để hướng dẫn cài đặt dự án Library Management System - ASP.NET Web Forms.*
