-- Các phím tắt cơ bản:
-- Ctrl + /: Dùng comment code
-- F5: Dùng để chạy câu lệnh SQL

-- Sử dụng SQL: 
-- Chạy câu lệnh SQL đang được chọn (Ctrl + E)
-- Chuyển câu lệnh đang chọn thành chữ hoa, chữ thường (Ctrl + Shift + U, Ctrl + Shift + L)
-- Comment và bỏ comment dòng lệnh ( Ctrl + K + C; Ctrl + K + U)

-- Bài 1 Tạo biến bằng lệnh Declare trong SQL SERVER
-- 1.1 Để khai báo biến thì các bạn sử dụng từ khóa Declare với cú pháp như sau:
-- DECLARE @var_name data_type;
-- @var_name là tên của biến, luôn luôn bắt đầu bằng ký tự @
-- data_type là kiểu dữ liệu của biến

DECLARE @YEAR AS INT
DECLARE @a1 AS INT,@a2 AS VARCHAR,@a3 AS FLOAT

-- 1.2 Gán giá trị cho biến
-- SQL Server để gán giá trị thì bạn sử dụng từ khóa SET và toán tử = với cú pháp sau
-- SET @var_name = value
SET @YEAR = 2022
SELECT @YEAR

-- 1.2 Truy xuất giá trị của biến SELECT @<Tên biến> 
-- 1.3 Lưu trữ câu truy vấn vào biến
DECLARE @SL_HANGTONMAX INT
SET @SL_HANGTONMAX = (SELECT MAX(SoLuongTon) FROM ChiTietSP)
--SELECT @SL_HANGTONMAX
PRINT N'Số lượng hàng tồn:' + CONVERT(VARCHAR,@SL_HANGTONMAX)

-- 1.4 Biến Bảng 
DECLARE @TB_NhanVien TABLE(Id INT,MaNV VARCHAR(50),TenNV NVARCHAR(50))
-- 1.5 Chèn dữ liệu vào biến bảng
INSERT INTO @TB_NhanVien
SELECT Id,Ma,Ten FROM NhanVien
WHERE Ten LIKE 'T%'
SELECT * FROM @TB_NhanVien

--1.6 Chèn dữ liệu vào biến bảng
DECLARE @TB_SinhVien TABLE(Id INT,Ma VARCHAR(50),Ten NVARCHAR(50))
INSERT INTO @TB_SinhVien
VALUES(1,'PH123',N'Dũng')
SELECT * FROM @TB_SinhVien
/*
Bài tập:
1. Sử dụng biến để tính tổng 4 số trong SQL
2. Tính diện tích hình chữ nhật.
3. Sử dụng bài 1.6 triển khai insert 3 dữ liệu và áp dụng câu lệnh UPDATE và DELETE.
Bạn nào làm xong zen DB FPT SHOP ở trên Github.
*/
