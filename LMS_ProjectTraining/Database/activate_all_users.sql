USE ELibraryDB_Project001;
GO

-- =============================================
-- KÍCH HOẠT TOÀN BỘ TÀI KHOẢN THÀNH VIÊN
-- Giúp các tài khoản cũ có thể đăng nhập ngay
-- =============================================

UPDATE member_master_tbl 
SET account_status = 'active'
WHERE account_status = 'pending';

PRINT N'=== ĐÃ KÍCH HOẠT TẤT CẢ TÀI KHOẢN (STATUS = ACTIVE) ===';
GO
