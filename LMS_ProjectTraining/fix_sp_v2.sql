USE ELibraryDB_Project001;
GO

-- ====================================
-- FIX 1: spGetAuthor - thieu author_id
-- Code C# can ca author_id va author_name
-- ====================================
ALTER PROCEDURE spGetAuthor
AS
BEGIN
    SELECT author_id, author_name FROM author_tbl;
END
GO

-- ====================================
-- FIX 2: sp_InsertAuthor - sai parameter
-- Code C# gui @id va @name
-- ====================================
ALTER PROCEDURE sp_InsertAuthor
    @id INT,
    @name NVARCHAR(100)
AS
BEGIN
    INSERT INTO author_tbl (author_id, author_name) VALUES (@id, @name);
END
GO

-- ====================================
-- FIX 3: sp_DeleteAuthor - sai parameter
-- Code C# gui @ID (la author_id, khong phai author_name)
-- ====================================
ALTER PROCEDURE sp_DeleteAuthor
    @ID INT
AS
BEGIN
    DELETE FROM author_tbl WHERE author_id = @ID;
END
GO

-- ====================================
-- FIX 4: sp_UpdateAuthor - sai parameter names
-- Code C# gui @id va @name
-- ====================================
ALTER PROCEDURE sp_UpdateAuthor
    @id INT,
    @name NVARCHAR(100)
AS
BEGIN
    UPDATE author_tbl SET author_name = @name WHERE author_id = @id;
END
GO

-- ====================================
-- FIX 5: TAO spGetAuthorByID - HOAN TOAN THIEU
-- Code C# goi sp nay khi bam Edit
-- ====================================
CREATE PROCEDURE spGetAuthorByID
    @ID INT
AS
BEGIN
    SELECT author_id, author_name FROM author_tbl WHERE author_id = @ID;
END
GO

-- ====================================
-- FIX 6: sp_getPublisher - thieu publisher_id
-- Code C# can ca publisher_id va publisher_name
-- ====================================
ALTER PROCEDURE sp_getPublisher
AS
BEGIN
    SELECT publisher_id, publisher_name FROM publisher_tbl;
END
GO

-- ====================================
-- FIX 7: sp_InsertPublisher - sai parameter
-- Code C# gui @id va @name
-- ====================================
ALTER PROCEDURE sp_InsertPublisher
    @id INT,
    @name NVARCHAR(100)
AS
BEGIN
    INSERT INTO publisher_tbl (publisher_id, publisher_name) VALUES (@id, @name);
END
GO

-- ====================================
-- FIX 8: sp_getPublisherByID - sai parameter name
-- Code C# gui @id (lowercase)
-- ====================================
ALTER PROCEDURE sp_getPublisherByID
    @id INT
AS
BEGIN
    SELECT publisher_id, publisher_name FROM publisher_tbl WHERE publisher_id = @id;
END
GO

-- ====================================
-- FIX 9: sp_DeletePublisherByID - sai parameter name
-- Code C# gui @id (lowercase)
-- ====================================
ALTER PROCEDURE sp_DeletePublisherByID
    @id INT
AS
BEGIN
    DELETE FROM publisher_tbl WHERE publisher_id = @id;
END
GO

-- ====================================
-- FIX 10: sp_UpdatePublisher - sai parameter names
-- Code C# gui @id va @name
-- ====================================
ALTER PROCEDURE sp_UpdatePublisher
    @id INT,
    @name NVARCHAR(100)
AS
BEGIN
    UPDATE publisher_tbl SET publisher_name = @name WHERE publisher_id = @id;
END
GO

-- ====================================
-- FIX 11: spgetBookBYID - check va sua
-- ====================================
ALTER PROCEDURE spgetBookBYID
    @bookid INT
AS
BEGIN
    SELECT * FROM book_master_tbl WHERE book_id = @bookid;
END
GO

PRINT N'=== TAT CA STORED PROCEDURES DA DUOC SUA THANH CONG! ===';
GO
