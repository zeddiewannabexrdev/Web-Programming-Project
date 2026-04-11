using System.Collections.Generic;
using System.Web;

namespace LMS_ProjectTraining
{
    public static class LanguageHelper
    {
        public static string Get(string key)
        {
            string lang = "en"; // Default
            if (HttpContext.Current.Session["lang"] != null)
            {
                lang = HttpContext.Current.Session["lang"].ToString();
            }

            if (lang == "en")
            {
                if (enDict.ContainsKey(key)) return enDict[key];
            }
            else
            {
                if (viDict.ContainsKey(key)) return viDict[key];
            }
            return key; // Fallback to key if not found
        }

        public static Dictionary<string, string> enDict = new Dictionary<string, string>
        {
            // Navbar - Guest
            {"nav_home", "Home"},
            {"nav_about", "About Us"},
            {"nav_terms", "Terms"},
            {"nav_login", "Login"},
            {"nav_signup", "Sign Up"},
            {"nav_logout", "Logout"},
            {"nav_hello", "Hello"},
            {"nav_language", "Language"},
            
            // Footer
            {"footer_copyright", "© Copyright 2026 - Zeddiewannabexrdev. All rights reserved."},

            // Default Page
            {"home_title", "LIBRARY MANAGEMENT SYSTEM"},
            {"home_subtitle", "WELCOME TO LIBRARY"},
            {"home_btn_signup", "Sign Up"},
            {"home_btn_login", "Login"},
            {"nav_brand", "Library Management System"},
            {"home_description", "Building community. Inspiring reading. Expanding access to books!"},
            {"side_filter", "Filter"},
            {"side_category", "Category:"},
            {"side_image", "Image"},
            {"side_info", "Information about the library and our services."},
            {"side_links", "Links"},
            {"side_top_search", "Top Searches"},
            {"side_active", "Active"},
            {"side_disabled", "Disabled"},
            {"home_update_info", "Online Library Management System - Updated 2026"},
            {"home_image_alt", "Illustration Image"},
            {"home_about_title", "About the Library"},
            {"home_about_desc", "The library management system helps you easily search, borrow, and return books. We provide thousands of diverse titles from many different fields, serving your learning and research needs."},
            {"home_service_title", "OUR SERVICES"},
            {"home_service_subtitle", "Outstanding features of the system"},
            {"home_service_detail", "Service details"},
            {"home_service_desc", "The system supports member management, tracking borrowed/returned books, automatic fine calculation, and providing detailed reports. Register as a member today to experience modern library services!"},
            {"home_promo_title", "SPECIAL OFFERS"},
            {"home_promo_desc", "Borrow 5 books and get a VIP membership card"},
            {"home_latest_title", "LATEST BOOKS"},
            {"home_latest_desc", "Weekly updates with the latest titles"},
            {"home_event_title", "LIBRARY EVENTS"},
            {"home_event_desc", "Join free reading sessions and seminars"},
            {"footer_top", "Footer"},
            {"footer_info", "Information"},
            {"footer_payment", "Payment Center"},
            {"footer_news", "News & Updates"},
            {"footer_support", "Support"},
            {"footer_website", "Website"},
            {"footer_terms", "Terms"},
            {"footer_follow", "Follow Us"},
            
            // Login & Signup Pages
            {"login_panel", "Login Panel"},
            {"login_user", "User Login"},
            {"login_admin", "Admin Login"},
            {"lbl_member_id", "Member ID"},
            {"lbl_password", "Password"},
            {"lbl_admin_id", "Admin ID"},
            {"lbl_fullname", "Full Name"},
            {"lbl_dob", "Date of Birth"},
            {"lbl_contact", "Contact No"},
            {"lbl_email", "Email"},
            {"lbl_state", "State/City"},
            {"lbl_city", "District/City"},
            {"lbl_pin", "Pincode"},
            {"lbl_address", "Full Address"},
            {"btn_login", "Login"},
            {"btn_admin_login", "Admin Login"},
            {"btn_signup", "Sign Up"},
            {"back_home", "<< Back to Home"},
            {"signup_member", "Member Sign Up"},
            {"create_account", "Create New Account"},
            
            // Admin Navbar
            {"nav_view_books", "View Books"},
            {"admin_add_author", "Add Author"},
            {"admin_add_pub", "Publisher"},
            {"admin_members", "Members"},
            {"admin_inventory", "Book Inventory"},
            {"admin_issue_return", "Issue/Return Book"},
            {"admin_reports", "Reports"},
            {"admin_fine", "Fines"},

            // Admin Dashboard & Author
            {"admin_dashboard", "Admin Dashboard"},
            {"welcome_admin", "Welcome to Admin Dashboard"},
            {"issued_books", "Issued Books"},
            {"view_all", "View all"},
            {"total_books", "Total Books"},
            {"view_all_books", "View all books"},
            {"total_fines", "Total Fines"},
            {"fines_amount", "Fine Amount"},
            {"add_author_heading", "-:Add Author:-"},
            {"lbl_author_id", "Author ID"},
            {"lbl_author_name", "Author Name"},
            {"btn_add", "Add"},
            {"btn_update", "Update"},
            {"btn_cancel", "Cancel"},
            {"author_list", "Author List"},
            {"confirm_delete_msg", "Do you want to delete this record?"},
            {"add_publisher_heading", "Add Publisher"},
            {"lbl_pub_id", "Publisher ID"},
            {"lbl_pub_name", "Publisher Name"},
            {"publisher_list", "Publisher List:"},
            {"btn_search", "Search"},
            {"btn_active", "Active"},
            {"btn_pending", "Pending"},
            {"btn_deactive", "Deactive"},
            {"member_list", "Members List"},
            
            {"lbl_book_details", "Book Details"},
            {"lbl_book_id", "Book ID"},
            {"lbl_book_name", "Book Name"},
            {"lbl_language", "Language"},
            {"lbl_pub_name_in", "Publisher Name"},
            {"lbl_author_name_in", "Author Name"},
            {"lbl_publish_date", "Publish Date"},
            {"lbl_genre", "Genre"},
            {"lbl_edition", "Edition"},
            {"lbl_book_cost", "Book Cost"},
            {"lbl_pages", "Pages"},
            {"lbl_actual_stock", "Actual Stock"},
            {"lbl_current_stock", "Current Stock"},
            {"lbl_issued_books", "Issued Books"},
            {"lbl_book_desc", "Book Description"},
            {"btn_delete", "Delete"},
            {"book_inventory_list", "Book Inventory List"},
            
            {"issue_book_heading", "Issue Book"},
            {"lbl_mem_name", "Member Name"},
            {"lbl_issue_date", "Issue Date"},
            {"lbl_due_date", "Due Date"},
            {"btn_issue", "Issue"},
            {"btn_return", "Return"},
            {"issued_books_list", "Issued Books List"},
            
            {"report_heading", "Books Issued"},
            {"report_sub", "Issued Book Details"},
            {"empty_report", "No issued book records found."},
            {"fine_heading", "Fine Payment Details"},
            {"empty_fine", "No fine records found."},

            // User Navbar
            {"user_profile", "Profile"},
            {"user_payment", "Payment"},
            {"welcome_user", "Welcome to the User Home"},
            
            {"your_profile", "Your Profile"},
            {"account_status", "Account Status - "},
            {"login_credentials", "Login Credentials"},
            {"old_password", "Old Password"},
            {"new_password", "New Password"},
            {"user_report_heading", "Your Issued Books"},
            {"user_report_sub", "your books info"},
            
            {"session_expired", "Session expired, please login again"},
            {"invalid_code", "Invalid Code"},
            {"validation_error", "Validation error, please try again"},
            {"profile_updated", "Your profile has been updated"},
            {"update_error", "Error updating record... please try again"},
            {"no_data_books", "No books found in inventory."},
            {"no_data_fines", "No fine records found."},
            {"no_data_report", "No issued books found."},

            // Common Terms
            {"success", "Success"},
            {"error", "Error"},
            {"admin_panel_title", "Admin Control Panel"},
            {"no_books_inventory_msg", "There are no books in the library. Please go to Book Inventory to add."},
            {"lbl_avail_stock", "Available Stock"},
            {"lbl_book_info", "Book Information"},
            {"lbl_no_books", "No books found in inventory."}
        };

        public static Dictionary<string, string> viDict = new Dictionary<string, string>
        {
            // Navbar - Guest
            {"nav_home", "Trang Chủ"},
            {"nav_about", "Về Chúng Tôi"},
            {"nav_terms", "Điều Khoản"},
            {"nav_login", "Đăng Nhập"},
            {"nav_signup", "Đăng Ký"},
            {"nav_logout", "Đăng Xuất"},
            {"nav_hello", "Xin chào"},
            {"nav_language", "Ngôn Ngữ"},

            // Footer
            {"footer_copyright", "© Bản quyền 2026 - Zeddiewannabexrdev. Tất cả quyền được bảo lưu."},

            // Default Page
            {"home_title", "HỆ THỐNG QUẢN LÝ THƯ VIỆN"},
            {"home_subtitle", "CHÀO MỪNG ĐẾN VỚI THƯ VIỆN"},
            {"home_btn_signup", "Đăng Ký"},
            {"home_btn_login", "Đăng Nhập"},
            {"nav_brand", "Hệ Thống Quản Lý Thư Viện"},
            {"home_description", "Xây dựng cộng đồng. Truyền cảm hứng đọc sách. Mở rộng khả năng tiếp cận sách!"},
            {"side_filter", "Bộ Lọc"},
            {"side_category", "Danh mục:"},
            {"side_image", "Hình ảnh"},
            {"side_info", "Thông tin giới thiệu về thư viện và các dịch vụ của chúng tôi."},
            {"side_links", "Liên kết"},
            {"side_top_search", "Tìm kiếm hàng đầu"},
            {"side_active", "Đang hoạt động"},
            {"side_disabled", "Vô hiệu hóa"},
            {"home_update_info", "Hệ thống quản lý thư viện trực tuyến - Cập nhật 2026"},
            {"home_image_alt", "Hình ảnh minh họa"},
            {"home_about_title", "Giới thiệu về thư viện"},
            {"home_about_desc", "Hệ thống quản lý thư viện giúp bạn dễ dàng tìm kiếm, mượn và trả sách. Chúng tôi cung cấp hàng ngàn đầu sách đa dạng từ nhiều lĩnh vực khác nhau, phục vụ nhu cầu học tập và nghiên cứu của bạn."},
            {"home_service_title", "DỊCH VỤ CỦA CHÚNG TÔI"},
            {"home_service_subtitle", "Các tính năng nổi bật của hệ thống"},
            {"home_service_detail", "Chi tiết dịch vụ"},
            {"home_service_desc", "Hệ thống hỗ trợ quản lý thành viên, theo dõi sách mượn/trả, tính phí phạt tự động, và cung cấp báo cáo chi tiết. Đăng ký thành viên ngay hôm nay để trải nghiệm dịch vụ thư viện hiện đại!"},
            {"home_promo_title", "ƯU ĐÃI ĐẶC BIỆT"},
            {"home_promo_desc", "Mượn 5 cuốn sách và nhận thẻ thành viên VIP"},
            {"home_latest_title", "SÁCH MỚI NHẤT"},
            {"home_latest_desc", "Cập nhật hàng tuần với các đầu sách mới nhất"},
            {"home_event_title", "SỰ KIỆN THƯ VIỆN"},
            {"home_event_desc", "Tham gia các buổi đọc sách và hội thảo miễn phí"},
            {"footer_top", "Chân trang"},
            {"footer_info", "Thông Tin"},
            {"footer_payment", "Trung tâm thanh toán"},
            {"footer_news", "Tin tức & cập nhật"},
            {"footer_support", "Hỗ Trợ"},
            {"footer_website", "Trang web"},
            {"footer_terms", "Điều khoản"},
            {"footer_follow", "Theo Dõi Chúng Tôi"},
            
            // Login & Signup Pages
            {"login_panel", "Bảng Đăng Nhập"},
            {"login_user", "Đăng Nhập Khách"},
            {"login_admin", "Đăng Nhập Quản Trị"},
            {"lbl_member_id", "Mã Thành Viên"},
            {"lbl_password", "Mật Khẩu"},
            {"lbl_admin_id", "Mã Quản Trị"},
            {"lbl_fullname", "Họ Tên"},
            {"lbl_dob", "Ngày Sinh"},
            {"lbl_contact", "Số Điện Thoại"},
            {"lbl_email", "Email"},
            {"lbl_state", "Tỉnh/Thành Phố"},
            {"lbl_city", "Quận/Huyện"},
            {"lbl_pin", "Mã Bưu Điện"},
            {"lbl_address", "Địa Chỉ Đầy Đủ"},
            {"btn_login", "Đăng Nhập"},
            {"btn_admin_login", "Đăng Nhập Quản Trị"},
            {"btn_signup", "Đăng Ký"},
            {"back_home", "<< Quay lại Trang Chủ"},
            {"signup_member", "Đăng Ký Thành Viên"},
            {"create_account", "Tạo Tài Khoản Mới"},
            
            // Admin Navbar
            {"nav_view_books", "Xem Sách"},
            {"admin_add_author", "Thêm Tác Giả"},
            {"admin_add_pub", "Nhà Xuất Bản"},
            {"admin_members", "Thành Viên"},
            {"admin_inventory", "Kho Sách"},
            {"admin_issue_return", "Mượn/Trả Sách"},
            {"admin_reports", "Báo Cáo"},
            {"admin_fine", "Tiền Phạt"},

            // Admin Dashboard & Author
            {"admin_dashboard", "Bảng Điều Khiển Quản Trị"},
            {"welcome_admin", "Chào mừng đến Bảng điều khiển Quản trị"},
            {"issued_books", "Sách đang mượn"},
            {"view_all", "Xem tất cả"},
            {"total_books", "Tổng số sách"},
            {"view_all_books", "Xem tất cả sách"},
            {"total_fines", "Tổng tiền phạt"},
            {"fines_amount", "Tiền Phạt"},
            {"add_author_heading", "-:Thêm Tác Giả:-"},
            {"lbl_author_id", "Mã Tác Giả"},
            {"lbl_author_name", "Tên Tác Giả"},
            {"btn_add", "Thêm"},
            {"btn_update", "Cập Nhật"},
            {"btn_cancel", "Hủy"},
            {"author_list", "Danh Sách Tác Giả"},
            {"confirm_delete_msg", "Bạn có muốn xóa dòng này không?"},
            {"add_publisher_heading", "Thêm Nhà Xuất Bản"},
            {"lbl_pub_id", "Mã NXB"},
            {"lbl_pub_name", "Tên NXB"},
            {"publisher_list", "Danh sách Nhà Xuất Bản:"},
            {"btn_search", "Tìm Kiếm"},
            {"btn_active", "Kích Hoạt"},
            {"btn_pending", "Chờ Duyệt"},
            {"btn_deactive", "Tạm Khóa"},
            {"member_list", "Danh Sách Thành Viên"},

            {"lbl_book_details", "Chi Tiết Sách"},
            {"lbl_book_id", "Mã Sách"},
            {"lbl_book_name", "Tên Sách"},
            {"lbl_language", "Ngôn Ngữ"},
            {"lbl_pub_name_in", "Tên Nhà Xuất Bản"},
            {"lbl_author_name_in", "Tên Tác Giả"},
            {"lbl_publish_date", "Ngày Xuất Bản"},
            {"lbl_genre", "Thể Loại"},
            {"lbl_edition", "Phiên Bản"},
            {"lbl_book_cost", "Giá Sách"},
            {"lbl_pages", "Số Trang"},
            {"lbl_actual_stock", "Tồn Kho Thực Tế"},
            {"lbl_current_stock", "Tôn Kho Hiện Tại"},
            {"lbl_issued_books", "Sách Đã Cho Mượn"},
            {"lbl_book_desc", "Mô Tả Sách"},
            {"btn_delete", "Xóa"},
            {"book_inventory_list", "Danh Sách Kho Sách"},
            
            {"issue_book_heading", "Cho Mượn Sách"},
            {"lbl_mem_name", "Tên Thành Viên"},
            {"lbl_issue_date", "Ngày Mượn"},
            {"lbl_due_date", "Ngày Hết Hạn"},
            {"btn_issue", "Cho Mượn"},
            {"btn_return", "Trả Sách"},
            {"issued_books_list", "Danh Sách Sách Đang Mượn"},
            
            {"report_heading", "Sách Đang Được Mượn"},
            {"report_sub", "Thông tin sách mượn"},
            {"empty_report", "Chưa có dữ liệu sách đang mượn."},
            {"fine_heading", "Chi Tiết Thanh Toán Tiền Phạt"},
            {"empty_fine", "Chưa có dữ liệu tiền phạt nào."},

            // User Navbar
            {"user_profile", "Hồ Sơ"},
            {"user_payment", "Thanh Toán"},
            {"welcome_user", "Chào mừng đến Trang Chủ Người Dùng"},

            {"your_profile", "Hồ Sơ Của Bạn"},
            {"account_status", "Trạng Thái Tài Khoản - "},
            {"login_credentials", "Thông Tin Đăng Nhập"},
            {"old_password", "Mật Khẩu Cũ"},
            {"new_password", "Mật Khẩu Mới"},
            {"user_report_heading", "Sách Đang Mượn"},
            {"user_report_sub", "thông tin sách"},

            {"session_expired", "Phiên đăng nhập đã hết hạn, vui lòng đăng nhập lại"},
            {"invalid_code", "Mã không hợp lệ"},
            {"validation_error", "Lỗi xác thực, vui lòng thử lại"},
            {"profile_updated", "Hồ sơ của bạn đã được cập nhật"},
            {"update_error", "Lỗi! không thể cập nhật bản ghi...vui lòng thử lại"},
            {"no_data_books", "Không có cuốn sách nào trong kho."},
            {"no_data_fines", "Không có lịch sử tiền phạt nào."},
            {"no_data_report", "Không có lịch sử mượn sách nào."},

            // Common Terms
            {"success", "Thành công"},
            {"error", "Lỗi"},
            {"admin_panel_title", "Bảng Điều Khiển Quản Trị Viên"},
            {"no_books_inventory_msg", "Chưa có quyển sách nào trong thư viện. Vui lòng vào Kho Sách để thêm."},
            {"lbl_avail_stock", "Tồn Kho Sẵn Có"},
            {"lbl_book_info", "Thông Tin Sách"},
            {"lbl_no_books", "Không có cuốn sách nào trong kho."}
        };
    }
}
