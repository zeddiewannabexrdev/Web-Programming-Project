USE ELibraryDB_Project001;
GO

-- =============================================
-- 1. FIX sp_InsertAuthor: CHỈ nhận 1 tham số tên
-- author_id là IDENTITY nên KHÔNG được truyền từ ngoài vào.
-- =============================================
IF OBJECT_ID('sp_InsertAuthor', 'P') IS NOT NULL DROP PROCEDURE sp_InsertAuthor;
GO
CREATE PROCEDURE sp_InsertAuthor
    @author_name NVARCHAR(100)
AS
BEGIN
    INSERT INTO author_tbl (author_name) VALUES (@author_name);
END
GO

-- =============================================
-- 2. FIX sp_InsertPublisher: CHỈ nhận 1 tham số tên
-- publisher_id là IDENTITY nên KHÔNG được truyền từ ngoài vào.
-- =============================================
IF OBJECT_ID('sp_InsertPublisher', 'P') IS NOT NULL DROP PROCEDURE sp_InsertPublisher;
GO
CREATE PROCEDURE sp_InsertPublisher
    @publisher_name NVARCHAR(100)
AS
BEGIN
    INSERT INTO publisher_tbl (publisher_name) VALUES (@publisher_name);
END
GO

-- =============================================
-- 3. FIX sp_Insert_Up_Del_BookInventory
-- Đảm bảo tên tham số khớp 100% với code C#
-- =============================================
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

PRINT N'=== ĐÃ CẬP NHẬT TOÀN BỘ STORED PROCEDURES THẾ HỆ MỚI! ===';
PRINT N'=== HỦY BỎ YÊU CẦU THAM SỐ @id CHO AUTHOR VÀ PUBLISHER. ===';
GO
