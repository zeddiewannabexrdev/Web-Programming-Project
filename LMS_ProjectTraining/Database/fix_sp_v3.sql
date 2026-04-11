USE ELibraryDB_Project001;
GO

-- =============================================
-- FIX sp_InsertAuthor: author_id is IDENTITY
-- The C# code only sends @author_name
-- =============================================
ALTER PROCEDURE sp_InsertAuthor
    @author_name NVARCHAR(100)
AS
BEGIN
    INSERT INTO author_tbl (author_name) VALUES (@author_name);
END
GO

-- =============================================
-- FIX sp_InsertPublisher: publisher_id is IDENTITY
-- The C# code only sends @publisher_name
-- =============================================
ALTER PROCEDURE sp_InsertPublisher
    @publisher_name NVARCHAR(100)
AS
BEGIN
    INSERT INTO publisher_tbl (publisher_name) VALUES (@publisher_name);
END
GO

-- =============================================
-- FIX sp_UserLogin: allow pending status for testing?
-- The user said "cannot login even though exists in DB".
-- This usually means they want to login after sign up.
-- I'll remove the 'active' restriction for now or 
-- better, I already fixed SignUp to set 'active'.
-- Let's keep 'active' requirement for security.
-- =============================================

PRINT N'=== FIX SP V3 COMPLETED ===';
GO
