-- ============================================
-- LMS Database Setup Script
-- ============================================

-- 1. Tao Database
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'ELibraryDB_Project001')
BEGIN
    CREATE DATABASE ELibraryDB_Project001;
END
GO

USE ELibraryDB_Project001;
GO

-- ============================================
-- 2. Tao cac bang
-- ============================================

-- Bang thanh vien
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'member_master_tbl')
CREATE TABLE member_master_tbl (
    member_id INT PRIMARY KEY,
    full_name NVARCHAR(100),
    dob NVARCHAR(20),
    contact_no NVARCHAR(20),
    email NVARCHAR(100),
    [state] NVARCHAR(50),
    city NVARCHAR(50),
    pincode NVARCHAR(10),
    full_address NVARCHAR(500),
    [password] NVARCHAR(50),
    account_status NVARCHAR(20) DEFAULT 'pending'
);
GO

-- Bang admin
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'admin_tbl')
CREATE TABLE admin_tbl (
    username NVARCHAR(50) PRIMARY KEY,
    [password] NVARCHAR(50),
    full_name NVARCHAR(100)
);
GO

-- Bang tac gia
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'author_tbl')
CREATE TABLE author_tbl (
    author_id INT IDENTITY(1,1) PRIMARY KEY,
    author_name NVARCHAR(100)
);
GO

-- Bang nha xuat ban
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'publisher_tbl')
CREATE TABLE publisher_tbl (
    publisher_id INT IDENTITY(1,1) PRIMARY KEY,
    publisher_name NVARCHAR(100)
);
GO

-- Bang sach
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'book_master_tbl')
CREATE TABLE book_master_tbl (
    book_id INT PRIMARY KEY,
    book_name NVARCHAR(200),
    author_name NVARCHAR(100),
    publisher_name NVARCHAR(100),
    publisher_date NVARCHAR(20),
    [language] NVARCHAR(50),
    edition NVARCHAR(50),
    book_cost NVARCHAR(20),
    no_of_pages NVARCHAR(10),
    book_description NVARCHAR(1000),
    genre NVARCHAR(200),
    actual_stock INT DEFAULT 0,
    current_stock INT DEFAULT 0,
    book_img_link NVARCHAR(500)
);
GO

-- Bang muon sach
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'book_issue_tbl')
CREATE TABLE book_issue_tbl (
    issue_id INT IDENTITY(1,1) PRIMARY KEY,
    book_id INT,
    member_id INT,
    member_name NVARCHAR(100),
    book_name NVARCHAR(200),
    issue_date NVARCHAR(20),
    due_date NVARCHAR(20)
);
GO

-- Bang phat
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'BookFineRecord')
CREATE TABLE BookFineRecord (
    fine_id INT IDENTITY(1,1) PRIMARY KEY,
    book_id INT,
    member_id INT,
    member_name NVARCHAR(100),
    book_name NVARCHAR(200),
    fineamount DECIMAL(10,2),
    number_of_day INT,
    fine_date NVARCHAR(20)
);
GO

-- ============================================
-- 3. Them tai khoan admin mac dinh
-- ============================================
IF NOT EXISTS (SELECT * FROM admin_tbl WHERE username = 'admin')
    INSERT INTO admin_tbl VALUES ('admin', 'admin123', 'Administrator');
GO

-- ============================================
-- 4. Tao Stored Procedures
-- ============================================

-- SP: Dang nhap User
IF OBJECT_ID('sp_UserLogin', 'P') IS NOT NULL DROP PROCEDURE sp_UserLogin;
GO
CREATE PROCEDURE sp_UserLogin
    @member_id INT,
    @password NVARCHAR(50)
AS
BEGIN
    SELECT full_name, member_id, email, account_status
    FROM member_master_tbl
    WHERE member_id = @member_id AND [password] = @password AND account_status = 'active';
END
GO

-- SP: Dang nhap Admin
IF OBJECT_ID('sp_AdminLogin', 'P') IS NOT NULL DROP PROCEDURE sp_AdminLogin;
GO
CREATE PROCEDURE sp_AdminLogin
    @username NVARCHAR(50),
    @password NVARCHAR(50)
AS
BEGIN
    SELECT username, [password], full_name
    FROM admin_tbl
    WHERE username = @username AND [password] = @password;
END
GO

-- SP: Dang ky tai khoan
IF OBJECT_ID('sp_InsertSignup', 'P') IS NOT NULL DROP PROCEDURE sp_InsertSignup;
GO
CREATE PROCEDURE sp_InsertSignup
    @full_name NVARCHAR(100),
    @dob NVARCHAR(20),
    @contact_no NVARCHAR(20),
    @email NVARCHAR(100),
    @state NVARCHAR(50),
    @city NVARCHAR(50),
    @pincode NVARCHAR(10),
    @full_address NVARCHAR(500),
    @member_id INT,
    @password NVARCHAR(50),
    @account_status NVARCHAR(20)
AS
BEGIN
    INSERT INTO member_master_tbl (member_id, full_name, dob, contact_no, email, [state], city, pincode, full_address, [password], account_status)
    VALUES (@member_id, @full_name, @dob, @contact_no, @email, @state, @city, @pincode, @full_address, @password, @account_status);
END
GO

-- SP: Kiem tra trung thanh vien
IF OBJECT_ID('sp_CheckDuplicateMember', 'P') IS NOT NULL DROP PROCEDURE sp_CheckDuplicateMember;
GO
CREATE PROCEDURE sp_CheckDuplicateMember
    @member_id INT,
    @email NVARCHAR(100)
AS
BEGIN
    SELECT * FROM member_master_tbl WHERE member_id = @member_id OR email = @email;
END
GO

-- SP: Lay tac gia
IF OBJECT_ID('spGetAuthor', 'P') IS NOT NULL DROP PROCEDURE spGetAuthor;
GO
CREATE PROCEDURE spGetAuthor
AS
BEGIN
    SELECT author_name FROM author_tbl;
END
GO

-- SP: Lay nha xuat ban
IF OBJECT_ID('sp_getPublisher', 'P') IS NOT NULL DROP PROCEDURE sp_getPublisher;
GO
CREATE PROCEDURE sp_getPublisher
AS
BEGIN
    SELECT publisher_name FROM publisher_tbl;
END
GO

-- SP: CRUD Sach
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
    ELSE IF @StatementType = 'SelectByID'
    BEGIN
        SELECT * FROM book_master_tbl WHERE book_id = @book_id;
    END
END
GO

-- SP: Tim sach theo ID
IF OBJECT_ID('spgetBookBYID', 'P') IS NOT NULL DROP PROCEDURE spgetBookBYID;
GO
CREATE PROCEDURE spgetBookBYID
    @book_id INT
AS
BEGIN
    SELECT * FROM book_master_tbl WHERE book_id = @book_id;
END
GO

-- SP: Kiem tra ton kho sach
IF OBJECT_ID('sp_CheckBookStockExist', 'P') IS NOT NULL DROP PROCEDURE sp_CheckBookStockExist;
GO
CREATE PROCEDURE sp_CheckBookStockExist
    @book_id INT
AS
BEGIN
    SELECT * FROM book_master_tbl WHERE book_id = @book_id AND current_stock > 0;
END
GO

-- SP: Lay thanh vien theo ID
IF OBJECT_ID('sp_getMember_ByID', 'P') IS NOT NULL DROP PROCEDURE sp_getMember_ByID;
GO
CREATE PROCEDURE sp_getMember_ByID
    @ID INT
AS
BEGIN
    SELECT * FROM member_master_tbl WHERE member_id = @ID;
END
GO

-- SP: Kiem tra da muon chua
IF OBJECT_ID('sp_checkIssueexistOrnot', 'P') IS NOT NULL DROP PROCEDURE sp_checkIssueexistOrnot;
GO
CREATE PROCEDURE sp_checkIssueexistOrnot
    @bid INT,
    @mid INT
AS
BEGIN
    SELECT * FROM book_issue_tbl WHERE book_id = @bid AND member_id = @mid;
END
GO

-- SP: Muon sach
IF OBJECT_ID('sp_InsertBookIssue', 'P') IS NOT NULL DROP PROCEDURE sp_InsertBookIssue;
GO
CREATE PROCEDURE sp_InsertBookIssue
    @book_id INT,
    @member_id INT,
    @member_name NVARCHAR(100),
    @book_name NVARCHAR(200),
    @issue_date NVARCHAR(20),
    @due_date NVARCHAR(20)
AS
BEGIN
    INSERT INTO book_issue_tbl (book_id, member_id, member_name, book_name, issue_date, due_date)
    VALUES (@book_id, @member_id, @member_name, @book_name, @issue_date, @due_date);
END
GO

-- SP: Cap nhat ton kho khi muon
IF OBJECT_ID('sp_UpdateIssueBookStock', 'P') IS NOT NULL DROP PROCEDURE sp_UpdateIssueBookStock;
GO
CREATE PROCEDURE sp_UpdateIssueBookStock
    @book_id INT
AS
BEGIN
    UPDATE book_master_tbl SET current_stock = current_stock - 1 WHERE book_id = @book_id;
END
GO

-- SP: Tra sach + tang ton kho
IF OBJECT_ID('sp_returnBook_Updatestock', 'P') IS NOT NULL DROP PROCEDURE sp_returnBook_Updatestock;
GO
CREATE PROCEDURE sp_returnBook_Updatestock
    @book_id INT,
    @member_id INT
AS
BEGIN
    DELETE FROM book_issue_tbl WHERE book_id = @book_id AND member_id = @member_id;
    UPDATE book_master_tbl SET current_stock = current_stock + 1 WHERE book_id = @book_id;
END
GO

-- SP: Lay danh sach muon sach
IF OBJECT_ID('sp_GetIssueBook', 'P') IS NOT NULL DROP PROCEDURE sp_GetIssueBook;
GO
CREATE PROCEDURE sp_GetIssueBook
AS
BEGIN
    SELECT * FROM book_issue_tbl;
END
GO

-- SP: Tinh so ngay qua han
IF OBJECT_ID('sp_GetNumOfDay', 'P') IS NOT NULL DROP PROCEDURE sp_GetNumOfDay;
GO
CREATE PROCEDURE sp_GetNumOfDay
    @book_id INT,
    @member_id INT
AS
BEGIN
    SELECT DATEDIFF(DAY, CAST(due_date AS DATE), GETDATE()) AS number_of_day
    FROM book_issue_tbl
    WHERE book_id = @book_id AND member_id = @member_id;
END
GO

-- SP: Lay profile thanh vien
IF OBJECT_ID('sp_getMemberProfileByID', 'P') IS NOT NULL DROP PROCEDURE sp_getMemberProfileByID;
GO
CREATE PROCEDURE sp_getMemberProfileByID
    @member_id INT
AS
BEGIN
    SELECT * FROM member_master_tbl WHERE member_id = @member_id;
END
GO

-- SP: Cap nhat profile thanh vien
IF OBJECT_ID('sp_UpdateMember_Profile', 'P') IS NOT NULL DROP PROCEDURE sp_UpdateMember_Profile;
GO
CREATE PROCEDURE sp_UpdateMember_Profile
    @full_name NVARCHAR(100),
    @dob NVARCHAR(20),
    @contact_no NVARCHAR(20),
    @email NVARCHAR(100),
    @state NVARCHAR(50),
    @city NVARCHAR(50),
    @pincode NVARCHAR(10),
    @full_address NVARCHAR(500),
    @member_id INT,
    @password NVARCHAR(50)
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
        [password] = @password
    WHERE member_id = @member_id;
END
GO

-- SP: Lay sach dang muon cua user
IF OBJECT_ID('sp_GetUserIssueBookDetails', 'P') IS NOT NULL DROP PROCEDURE sp_GetUserIssueBookDetails;
GO
CREATE PROCEDURE sp_GetUserIssueBookDetails
    @mid INT
AS
BEGIN
    SELECT * FROM book_issue_tbl WHERE member_id = @mid;
END
GO

-- SP: Cap nhat thanh vien (admin)
IF OBJECT_ID('sp_UpdateMemberByAdmin', 'P') IS NOT NULL DROP PROCEDURE sp_UpdateMemberByAdmin;
GO
CREATE PROCEDURE sp_UpdateMemberByAdmin
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

-- SP: Xoa thanh vien
IF OBJECT_ID('sp_DeleteMember', 'P') IS NOT NULL DROP PROCEDURE sp_DeleteMember;
GO
CREATE PROCEDURE sp_DeleteMember
    @member_id INT
AS
BEGIN
    DELETE FROM member_master_tbl WHERE member_id = @member_id;
END
GO

-- SP: Lay tat ca thanh vien
IF OBJECT_ID('sp_GetAllMembers', 'P') IS NOT NULL DROP PROCEDURE sp_GetAllMembers;
GO
CREATE PROCEDURE sp_GetAllMembers
AS
BEGIN
    SELECT * FROM member_master_tbl;
END
GO

-- SP: Them tac gia
IF OBJECT_ID('sp_InsertAuthor', 'P') IS NOT NULL DROP PROCEDURE sp_InsertAuthor;
GO
CREATE PROCEDURE sp_InsertAuthor
    @author_name NVARCHAR(100)
AS
BEGIN
    INSERT INTO author_tbl (author_name) VALUES (@author_name);
END
GO

-- SP: Xoa tac gia
IF OBJECT_ID('sp_DeleteAuthor', 'P') IS NOT NULL DROP PROCEDURE sp_DeleteAuthor;
GO
CREATE PROCEDURE sp_DeleteAuthor
    @author_name NVARCHAR(100)
AS
BEGIN
    DELETE FROM author_tbl WHERE author_name = @author_name;
END
GO

-- SP: Them nha xuat ban
IF OBJECT_ID('sp_InsertPublisher', 'P') IS NOT NULL DROP PROCEDURE sp_InsertPublisher;
GO
CREATE PROCEDURE sp_InsertPublisher
    @publisher_name NVARCHAR(100)
AS
BEGIN
    INSERT INTO publisher_tbl (publisher_name) VALUES (@publisher_name);
END
GO

-- SP: Xoa nha xuat ban
IF OBJECT_ID('sp_DeletePublisher', 'P') IS NOT NULL DROP PROCEDURE sp_DeletePublisher;
GO
CREATE PROCEDURE sp_DeletePublisher
    @publisher_name NVARCHAR(100)
AS
BEGIN
    DELETE FROM publisher_tbl WHERE publisher_name = @publisher_name;
END
GO

-- SP: Ghi nhan phat
IF OBJECT_ID('sp_InsertFineRecord', 'P') IS NOT NULL DROP PROCEDURE sp_InsertFineRecord;
GO
CREATE PROCEDURE sp_InsertFineRecord
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

PRINT '========================================'
PRINT 'Database setup completed successfully!'
PRINT 'Admin account: admin / admin123'
PRINT '========================================'
GO
