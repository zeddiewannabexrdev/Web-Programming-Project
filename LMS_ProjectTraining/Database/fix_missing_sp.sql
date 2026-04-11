USE ELibraryDB_Project001;
GO

-- ============================================
-- CÁC STORED PROCEDURES BỊ THIẾU
-- ============================================

-- 1. sp_getMember_AllRecords: Lấy tất cả thành viên (cho trang UpdateMemberDetails)
IF OBJECT_ID('sp_getMember_AllRecords', 'P') IS NOT NULL DROP PROCEDURE sp_getMember_AllRecords;
GO
CREATE PROCEDURE sp_getMember_AllRecords
AS
BEGIN
    SELECT * FROM member_master_tbl;
END
GO

-- 2. sp_getMemberByID: Lấy thành viên theo ID (cho trang UpdateMemberDetails)
IF OBJECT_ID('sp_getMemberByID', 'P') IS NOT NULL DROP PROCEDURE sp_getMemberByID;
GO
CREATE PROCEDURE sp_getMemberByID
    @member_id INT
AS
BEGIN
    SELECT * FROM member_master_tbl WHERE member_id = @member_id;
END
GO

-- 3. sp_UpdateMemberStatus_ByID: Cập nhật trạng thái tài khoản (active/pending/deactive)
IF OBJECT_ID('sp_UpdateMemberStatus_ByID', 'P') IS NOT NULL DROP PROCEDURE sp_UpdateMemberStatus_ByID;
GO
CREATE PROCEDURE sp_UpdateMemberStatus_ByID
    @member_id INT,
    @account_status NVARCHAR(20)
AS
BEGIN
    UPDATE member_master_tbl SET account_status = @account_status WHERE member_id = @member_id;
END
GO

-- 4. sp_UpdateMember_Records: Cập nhật thông tin thành viên (admin update)
IF OBJECT_ID('sp_UpdateMember_Records', 'P') IS NOT NULL DROP PROCEDURE sp_UpdateMember_Records;
GO
CREATE PROCEDURE sp_UpdateMember_Records
    @member_id INT,
    @full_name NVARCHAR(100),
    @dob NVARCHAR(20),
    @contact_no NVARCHAR(20),
    @email NVARCHAR(100),
    @state NVARCHAR(50),
    @city NVARCHAR(50),
    @pincode NVARCHAR(10),
    @full_address NVARCHAR(500),
    @password NVARCHAR(50),
    @account_status NVARCHAR(20)
AS
BEGIN
    UPDATE member_master_tbl SET
        full_name = @full_name,
        dob = @dob,
        contact_no = @contact_no,
        email = @email,
        [state] = @state,
        city = @city,
        pincode = @pincode,
        full_address = @full_address,
        [password] = @password,
        account_status = @account_status
    WHERE member_id = @member_id;
END
GO

-- 5. sp_DeleteMemberByID: Xóa thành viên theo ID
IF OBJECT_ID('sp_DeleteMemberByID', 'P') IS NOT NULL DROP PROCEDURE sp_DeleteMemberByID;
GO
CREATE PROCEDURE sp_DeleteMemberByID
    @member_id INT
AS
BEGIN
    DELETE FROM book_issue_tbl WHERE member_id = @member_id;
    DELETE FROM BookFineRecord WHERE member_id = @member_id;
    DELETE FROM member_master_tbl WHERE member_id = @member_id;
END
GO

-- 6. sp_FineDetails: Lấy chi tiết phạt của user (cho trang uPayment)
IF OBJECT_ID('sp_FineDetails', 'P') IS NOT NULL DROP PROCEDURE sp_FineDetails;
GO
CREATE PROCEDURE sp_FineDetails
    @mid INT
AS
BEGIN
    SELECT * FROM BookFineRecord WHERE member_id = @mid;
END
GO

-- 7. sp_FineDetails_forAdmin: Lấy tất cả chi tiết phạt (cho admin)
IF OBJECT_ID('sp_FineDetails_forAdmin', 'P') IS NOT NULL DROP PROCEDURE sp_FineDetails_forAdmin;
GO
CREATE PROCEDURE sp_FineDetails_forAdmin
AS
BEGIN
    SELECT * FROM BookFineRecord;
END
GO

-- 8. sp_InsertFineDetials: Ghi nhận phạt (LƯU Ý: code viết sai chính tả "Detials")
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

-- 9. sp_GetAllIssueBookDetails_ForAdmin: Lấy tất cả phiếu mượn (cho Report admin)
IF OBJECT_ID('sp_GetAllIssueBookDetails_ForAdmin', 'P') IS NOT NULL DROP PROCEDURE sp_GetAllIssueBookDetails_ForAdmin;
GO
CREATE PROCEDURE sp_GetAllIssueBookDetails_ForAdmin
AS
BEGIN
    SELECT * FROM book_issue_tbl;
END
GO

-- 10. sp_UpdatePublisher: Cập nhật nhà xuất bản
IF OBJECT_ID('sp_UpdatePublisher', 'P') IS NOT NULL DROP PROCEDURE sp_UpdatePublisher;
GO
CREATE PROCEDURE sp_UpdatePublisher
    @publisher_id INT,
    @publisher_name NVARCHAR(100)
AS
BEGIN
    UPDATE publisher_tbl SET publisher_name = @publisher_name WHERE publisher_id = @publisher_id;
END
GO

-- 11. sp_getPublisherByID: Lấy NXB theo ID
IF OBJECT_ID('sp_getPublisherByID', 'P') IS NOT NULL DROP PROCEDURE sp_getPublisherByID;
GO
CREATE PROCEDURE sp_getPublisherByID
    @publisher_id INT
AS
BEGIN
    SELECT * FROM publisher_tbl WHERE publisher_id = @publisher_id;
END
GO

-- 12. sp_DeletePublisherByID: Xóa NXB theo ID
IF OBJECT_ID('sp_DeletePublisherByID', 'P') IS NOT NULL DROP PROCEDURE sp_DeletePublisherByID;
GO
CREATE PROCEDURE sp_DeletePublisherByID
    @publisher_id INT
AS
BEGIN
    DELETE FROM publisher_tbl WHERE publisher_id = @publisher_id;
END
GO

-- 13. sp_UpdateAuthor: Cập nhật tác giả
IF OBJECT_ID('sp_UpdateAuthor', 'P') IS NOT NULL DROP PROCEDURE sp_UpdateAuthor;
GO
CREATE PROCEDURE sp_UpdateAuthor
    @author_id INT,
    @author_name NVARCHAR(100)
AS
BEGIN
    UPDATE author_tbl SET author_name = @author_name WHERE author_id = @author_id;
END
GO

PRINT '========================================'
PRINT '13 missing Stored Procedures created!'
PRINT '========================================'
GO
