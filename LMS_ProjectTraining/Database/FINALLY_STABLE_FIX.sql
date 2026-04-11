USE ELibraryDB_Project001;
GO

-- =============================================
-- BẢN VÁ LỖI CỐ ĐỊNH PHIÊN BẢN CUỐI CÙNG
-- Tác vụ: Xóa bỏ hoàn toàn tham số @id dư thừa
-- =============================================

-- 1. Sửa Procedure Thêm Tác Giả
IF OBJECT_ID('sp_InsertAuthor', 'P') IS NOT NULL DROP PROCEDURE sp_InsertAuthor;
GO
CREATE PROCEDURE sp_InsertAuthor
    @author_name NVARCHAR(100)
AS
BEGIN
    -- author_id tự động tăng (IDENTITY), không cần truyền vào.
    INSERT INTO author_tbl (author_name) VALUES (@author_name);
END
GO

-- 2. Sửa Procedure Thêm Nhà Xuất Bản
IF OBJECT_ID('sp_InsertPublisher', 'P') IS NOT NULL DROP PROCEDURE sp_InsertPublisher;
GO
CREATE PROCEDURE sp_InsertPublisher
    @publisher_name NVARCHAR(100)
AS
BEGIN
    -- publisher_id tự động tăng (IDENTITY), không cần truyền vào.
    INSERT INTO publisher_tbl (publisher_name) VALUES (@publisher_name);
END
GO

-- 3. Sửa Procedure Thêm/Sửa/Xóa Sách (Đồng bộ tham số)
IF OBJECT_ID('sp_Insert_Up_Del_BookInventory', 'P') IS NOT NULL DROP PROCEDURE sp_Insert_Up_Del_BookInventory;
GO
CREATE PROCEDURE sp_Insert_Up_Del_BookInventory
    @StatementType NVARCHAR(20) = '',
    @book_id INT = 0,
    @book_name NVARCHAR(200) = '',
    @author_name NVARCHAR(100) = '',
    @publisher_name NVARCHAR(100) = '',
    @publish_date NVARCHAR(20) = '',
    @language NVARCHAR(50) = '',
    @edition NVARCHAR(50) = '',
    @book_cost NVARCHAR(20) = '',
    @no_of_pages NVARCHAR(10) = '',
    @book_description NVARCHAR(1000) = '',
    @genre NVARCHAR(200) = '',
    @actual_stock INT = 0,
    @current_stock INT = 0,
    @book_img_link NVARCHAR(500) = ''
AS
BEGIN
    IF @StatementType = 'Insert'
    BEGIN
        INSERT INTO book_master_tbl (book_id, book_name, author_name, publisher_name, publisher_date, [language], edition, book_cost, no_of_pages, book_description, genre, actual_stock, current_stock, book_img_link)
        VALUES (@book_id, @book_name, @author_name, @publisher_name, @publish_date, @language, @edition, @book_cost, @no_of_pages, @book_description, @genre, @actual_stock, @current_stock, @book_img_link);
    END
    ELSE IF @StatementType = 'Update'
    BEGIN
        UPDATE book_master_tbl SET
            book_name = @book_name,
            author_name = @author_name,
            publisher_name = @publisher_name,
            publisher_date = @publish_date,
            [language] = @language,
            edition = @edition,
            book_cost = @book_cost,
            no_of_pages = @no_of_pages,
            book_description = @book_description,
            genre = @genre,
            actual_stock = @actual_stock,
            current_stock = @current_stock,
            book_img_link = @book_img_link
        WHERE book_id = @book_id;
    END
    ELSE IF @StatementType = 'Delete'
    BEGIN
        DELETE FROM book_master_tbl WHERE book_id = @book_id;
    END
    ELSE IF @StatementType = 'Select'
    BEGIN
        SELECT * FROM book_master_tbl;
    END
END
GO

PRINT N'=== HỆ THỐNG ĐÃ ĐƯỢC CẬP NHẬT PHIÊN BẢN SIÊU ỔN ĐỊNH ===';
GO
