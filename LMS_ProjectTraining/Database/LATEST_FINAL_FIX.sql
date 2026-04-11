USE ELibraryDB_Project001;
GO

-- =============================================
-- BẢN VÁ LỖI TỔNG HỢP: ĐỒNG BỘ TÊN THAM SỐ
-- Các procedure dưới đây được đồng bộ để khớp hoàn toàn với mã C#
-- =============================================

-- 1. Sửa spgetBookBYID (Khớp @book_id)
IF OBJECT_ID('spgetBookBYID', 'P') IS NOT NULL DROP PROCEDURE spgetBookBYID;
GO
CREATE PROCEDURE spgetBookBYID
    @book_id INT
AS
BEGIN
    SELECT * FROM book_master_tbl WHERE book_id = @book_id;
END
GO

-- 2. Sửa sp_FineDetails (Khớp @member_id)
IF OBJECT_ID('sp_FineDetails', 'P') IS NOT NULL DROP PROCEDURE sp_FineDetails;
GO
CREATE PROCEDURE sp_FineDetails
    @member_id NVARCHAR(50)
AS
BEGIN
    SELECT * FROM BookFineRecord WHERE member_id = @member_id;
END
GO

-- 3. Sửa sp_InsertFineDetials (Đảm bảo đúng tên và tham số)
IF OBJECT_ID('sp_InsertFineDetials', 'P') IS NOT NULL DROP PROCEDURE sp_InsertFineDetials;
GO
CREATE PROCEDURE sp_InsertFineDetials
    @book_id INT,
    @member_id INT,
    @member_name NVARCHAR(100),
    @book_name NVARCHAR(200),
	@fineamount DECIMAL(10,2),
    @number_of_day INT,
    @fine_date NVARCHAR(20)
AS
BEGIN
    INSERT INTO BookFineRecord (book_id, member_id, member_name, book_name, fineamount, number_of_day, fine_date)
    VALUES (@book_id, @member_id, @member_name, @book_name, @fineamount, @number_of_day, @fine_date);
END
GO

-- 4. Loại bỏ các Procedure dư thừa để dọn dẹp (nếu có)
IF OBJECT_ID('sp_InsertFineRecord', 'P') IS NOT NULL DROP PROCEDURE sp_InsertFineRecord;
GO

PRINT N'=== ĐỒNG BỘ THÀNH CÔNG: @book_id VÀ @member_id ===';
GO
