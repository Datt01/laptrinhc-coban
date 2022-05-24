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
UPDATE @TB_SinhVien
SET Ten = N'Bảo'
WHERE Id = 1
SELECT * FROM @TB_SinhVien
/*
Bài tập:
1. Sử dụng biến để tính tổng 4 số trong SQL
2. Tính diện tích hình chữ nhật.
3. Sử dụng bài 1.6 triển khai insert 3 dữ liệu và áp dụng câu lệnh UPDATE và DELETE.
Bạn nào làm xong zen DB FPT SHOP ở trên Github.
*/
-- 1.7 Begin và End
/* T-SQL tổ chức theo từng khối lệnh
   Một khối lệnh có thể lồng bên trong một khối lệnh khác
   Một khối lệnh bắt đầu bởi BEGIN và kết thúc bởi
   END, bên trong khối lệnh có nhiều lệnh, và các
   lệnh ngăn cách nhau bởi dấu chấm phẩy	
   BEGIN
    { sql_statement | statement_block}
   END
*/
BEGIN
	SELECT Id,SoLuongTon,GiaNhap
	FROM ChiTietSP
	WHERE SoLuongTon > 900

	IF @@ROWCOUNT = 0
	PRINT N'Không có sản phẩm nào tồn lớn hơn 900'
	ELSE
	PRINT N'Có dữ liệu khi truy vấn'
END
-- 1.8 Begin và End lồng nhau
BEGIN
	DECLARE @MaNV VARCHAR(MAX)
	SELECT TOP 1
		@MaNV = Ma
	FROM NhanVien
	WHERE Ten LIKE 'T%'

	IF @@ROWCOUNT <> 0
	BEGIN
		PRINT N'Có tìm thấy nhân viên có mã: ' + @MaNV
	END
	ELSE
	BEGIN
		PRINT N'Không tìm thấy nhân viên nào bắt đầu bằng chữ T'
	END
END
-- 1.9 CAST ÉP KIỂU DỮ LIỆU
-- Hàm CAST trong SQL Server chuyển đổi một biểu thức từ một kiểu dữ liệu này sang kiểu dữ liệu khác. 
-- Nếu chuyển đổi không thành công, CAST sẽ báo lỗi, ngược lại nó sẽ trả về giá trị chuyển đổi tương ứng.
-- CAST(bieuthuc AS kieudulieu [(do_dai)])
SELECT CAST(4.9 AS INT) -- = 4
SELECT CAST(13.5 AS FLOAT)
SELECT CAST(14.9 AS VARCHAR)
SELECT CAST('14.9' AS FLOAT)
SELECT CAST('2022-05-22' AS DATETIME)

-- 2.0 CONVERT 
-- Hàm CONVERT trong SQL Server cho phép bạn có thể chuyển đổi một biểu thức nào đó sang một kiểu dữ liệu 
-- bất kỳ mong muốn nhưng có thể theo một định dạng nào đó (đặc biệt đối với kiểu dữ liệu ngày).
-- Nếu chuyển đổi không thành công, CONVERT sẽ báo lỗi, ngược lại nó sẽ trả về giá trị chuyển đổi tương ứng.
-- CONVERT(kieudulieu(do_dai), bieuthuc, dinh_dang)
-- dinh_dang (không bắt buộc): là một con số chỉ định việc định dạng cho việc chuyển đổi dữ liệu từ dạng ngày sang dạng chuỗi.
SELECT CONVERT(INT,4.9)
SELECT CONVERT(VARCHAR,4.9)
SELECT CONVERT(FLOAT,'4.9')
SELECT CONVERT(DATE,'2022-05-21')

-- Các định dạng trong convert 101,102.........các tham số định dạng https://www.mssqltips.com/sqlservertip/1145/date-and-time-conversions-using-sql-server/
SELECT CONVERT(VARCHAR,'05/21/2022',101)
SELECT CONVERT(DATE,'2022.05.21',102)
SELECT CONVERT(DATE,'21/05/2022',103)

--Ví dụ:  Bảng nhân viên Ngày sinh
SELECT NgaySinh AS N'Ngày Gốc',
	CAST(NgaySinh AS DATETIME) AS 'CAST',
	CONVERT(VARCHAR,NgaySinh,101) AS '101',
	CONVERT(VARCHAR,NgaySinh,102) AS '102',
	CONVERT(VARCHAR,NgaySinh,112) AS '112'
FROM NhanVien

-- 2.1 Các hàm toán học Các hàm toán học (Math) được dùng để thực hiện các phép toán số học trên các giá trị. 
-- Các hàm toán học này áp dụng cho cả SQL SERVER và MySQL.
-- 1. ABS() Hàm ABS() dùng để lấy giá trị tuyệt đối của một số hoặc biểu thức.
-- Hàm ABS() dùng để lấy giá trị tuyệt đối của một số hoặc biểu thức.
SELECT ABS(-3)
-- 2. CEILING()
-- Hàm CEILING() dùng để lấy giá trị cận trên của một số hoặc biểu thức, tức là lấy giá trị số nguyên nhỏ nhất nhưng lớn hơn số hoặc biểu thức tương ứng.
-- CEILING(num_expr)
SELECT CEILING(3.1)
-- 3. FLOOR()
-- Ngược với CEILING(), hàm FLOOR() dùng để lấy cận dưới của một số hoặc một biểu thức, tức là lấy giá trị số nguyên lớn nhất nhưng nhỏ hơn số hoặc biểu thức tướng ứng.
-- FLOOR(num_expr)
SELECT FLOOR(9.9)
-- 4. POWER()
-- POWER() dùng để tính luỹ thừa của một số hoặc biểu thức.
-- POWER(num_expr,luỹ_thừa)
SELECT POWER(3,2)
-- 5. ROUND()
-- Hàm ROUND() dùng để làm tròn một số hay biểu thức.
-- ROUND(num_expr,độ_chính_xác)
SELECT ROUND(9.123456,2)-- = 9.123500
-- 6. SIGN()
-- Hàm SIGN() dùng để lấy dấu của một số hay biểu thức. Hàm trả về +1 nếu số hoặc biểu thức có giá trị dương (>0),
-- -1 nếu số hoặc biểu thức có giá trị âm (<0) và trả về 0 nếu số hoặc biểu thức có giá trị =0.
SELECT SIGN(-99)
SELECT SIGN(100-50)
-- 7. SQRT()
-- Hàm SQRT() dùng để tính căn bậc hai của một số hoặc biểu thức, giá trị trả về của hàm là số có kiểu float.
-- Nếu số hay biểu thức có giá trị âm (<0) thì hàm SQRT() sẽ trả về NULL đối với MySQL, trả về lỗi đối với SQL SERVER.
-- SQRT(float_expr)
SELECT SQRT(9)
SELECT SQRT(9-5)
-- 8. SQUARE()
-- Hàm này dùng để tính bình phương của một số, giá trị trả về có kiểu float. Ví dụ:
SELECT SQUARE(9)
-- 9. LOG()
-- Dùng để tính logarit cơ số E của một số, trả về kiểu float. Ví dụ:
SELECT LOG(9) AS N'Logarit cơ số E của 9'
-- 10. EXP()
-- Hàm này dùng để tính luỹ thừa cơ số E của một số, giá trị trả về có kiểu float. Ví dụ:
SELECT EXP(2)
-- 11. PI()
-- Hàm này trả về số PI = 3.14159265358979.
SELECT PI()
-- 12. ASIN(), ACOS(), ATAN()
-- Các hàm này dùng để tính góc (theo đơn vị radial) của một giá trị. Lưu ý là giá trị hợp lệ đối với 
-- ASIN() và ACOS() phải nằm trong đoạn [-1,1], nếu không sẽ phát sinh lỗi khi thực thi câu lệnh. Ví dụ:
SELECT ASIN(1) as [ASIN(1)], ACOS(1) as [ACOS(1)], ATAN(1) as [ATAN(1)];

-- 2.2 Các hàm xử lý chuỗi làm việc với kiểu chuỗi
/*
 LEN(string)  Trả về số lượng ký tự trong chuỗi, tính cả ký tự trắng đầu chuỗi
 LTRIM(string) Loại bỏ khoảng trắng bên trái
 RTRIM(string)  Loại bỏ khoảng trắng bên phải
 LEFT(string,length) Cắt chuỗi theo vị trí chỉ định từ trái
 RIGHT(string,legnth) Cắt chuỗi theo vị trí chỉ định từ phải
 TRIM(string) Cắt chuỗi 2 đầu nhưng từ bản SQL 2017 trở lên mới hoạt động
*/
SELECT LEN(N'Học lại')-- =7
SELECT LTRIM(N'        Học lại')
SELECT RTRIM(N'        Học lại         ')
SELECT RTRIM(LTRIM(N'        Học lại      ')) -- Cách cũ
SELECT LEFT(N'Học Lại',3)
/*Nếu chuỗi gồm hai hay nhiều thành phần, bạn có thể phân
tách chuỗi thành những thành phần độc lập.
Sử dụng hàm CHARINDEX để định vị những ký tự phân tách.
Sau đó, dùng hàm LEFT, RIGHT, SUBSTRING và LEN để trích ra
những thành phần độc lập*/
DECLARE @TB_NAMES TABLE(Ten NVARCHAR(50))
INSERT INTO @TB_NAMES
VALUES(N'Dương Ngọc Bảo'),(N'Đào Văn Bảo')
SELECT Ten,
	LEN(Ten) AS N'Độ dài tên',
	CHARINDEX(' ',Ten) AS 'CHARINDEX',
	LEFT(Ten,CHARINDEX(' ',Ten) -1) AS N'Họ',
	RIGHT(Ten,LEN(Ten)- CHARINDEX(' ',Ten)) AS N'Tên' -- Ngọc Bảo
FROM @TB_NAMES
-- Tách tên đệm thành 1 cột.
-- Về Giải bài tách tên cột.

-- 2.3 Charindex Trả về vị trí được tìm thấy của một chuỗi trong chuỗi chỉ định, 
-- ngoài ra có thể kiểm tra từ vị trí mong  muốn
-- CHARINDEX ( string1, string2 ,[  start_location ] ) = 1 số nguyên
SELECT CHARINDEX('POLY','FPT POLYTECHNIC')--= 5
SELECT CHARINDEX('POLY','FPT POLYTECHNIC',6)-- = 0 Không tìm thấy

-- 2.4 Substring Cắt chuỗi bắt đầu từ vị trí và độ dài muốn lấy 
-- SUBSTRING(string,start,length)
SELECT SUBSTRING('FPT POLYTECHNIC',5,LEN('FPT POLYTECHNIC'))
SELECT SUBSTRING('FPT POLYTECHNIC',5,8)

-- 2.5 Replace Hàm thay thế chuỗi theo giá trị cần thay thế và cần thay thế
-- REPLACE(search,find,replace)
SELECT REPLACE('0912-345-678','-','_')

/* 2.6 
REVERSE(string) Đảo ngược chuỗi truyền vào
LOWER(string)	Biến tất cả chuỗi truyền vào thành chữ thường
UPPER(string)	Biến tất cả chuỗi truyền vào thành chữ hoa
SPACE(integer)	Đếm số lượng khoảng trắng trong chuỗi. 
*/
SELECT REVERSE('SQL')
SELECT 'SQ' + '          ' + 'L'
SELECT 'SQ' + SPACE(30) + 'L'

-- 2.7 Các hàm ngày tháng năm
SELECT GETDATE()
SELECT CONVERT(DATE,GETDATE())
SELECT CONVERT(TIME,GETDATE())

SELECT YEAR(GETDATE()) AS YEAR,
		MONTH(GETDATE()) AS MONTH,
		DAY(GETDATE()) AS DAY

-- DATENAME: truy cập tới các thành phần liên quan ngày tháng
SELECT 
	DATENAME(YEAR,GETDATE()) AS YEAR,
	DATENAME(MONTH,GETDATE()) AS MONTH,
	DATENAME(DAY,GETDATE()) AS DAY,
	DATENAME(WEEK,GETDATE()) AS WEEK,
	DATENAME(DAYOFYEAR,GETDATE()) AS DAYOFYEAR,
	DATENAME(WEEKDAY,GETDATE()) AS WEEKDAY,
-- Truyền vào ngày tháng năm sinh lấy thông tin về thời gian.
DECLARE @NgaySinh DATE
SET @NgaySinh = '1980-07-27'
SELECT 
	DATENAME(YEAR,@NgaySinh) AS YEAR,
	DATENAME(MONTH,@NgaySinh) AS MONTH,
	DATENAME(DAY,@NgaySinh) AS DAY,
	DATENAME(WEEK,@NgaySinh) AS WEEK,
	DATENAME(DAYOFYEAR,@NgaySinh) AS DAYOFYEAR,
	DATENAME(WEEKDAY,@NgaySinh) AS WEEKDAY

-- 2.8 Câu điều kiện IF ELSE trong SQL
/* Lệnh if sẽ kiểm tra một biểu thức có đúng  hay không, nếu đúng thì thực thi nội dung bên trong của IF, nếu sai thì bỏ qua.
IF BIỂU THỨC   
BEGIN
    { statement_block }
END		  */
IF 1=2
	PRINT N'Đúng'
ELSE
	PRINT N'Sai'
-- Viết 1 chương trình đánh giá qua môn COM2034
DECLARE @DIEMTHI FLOAT
SET @DIEMTHI = 4.9
IF @DIEMTHI >= 5
	BEGIN
		PRINT N'Chúc mừng Bảo đã qua môn'
	END
ELSE
	BEGIN
		PRINT N'Chúc mừng Bảo đã đã mất 650k'
	END
-- Viết 1 chương trình đánh giá học lực 0 - 4 = Học lại, 5 - 6 = TB, 7 - 9 = Giỏi, Còn lại xuất sắc.
DECLARE @DIEMTHI FLOAT
SET @DIEMTHI = 8
IF @DIEMTHI < 5
	BEGIN
		PRINT N'Chúc mừng Bảo đã học lại'
	END
ELSE IF (@DIEMTHI >=5 AND @DIEMTHI < 7)
	BEGIN 
		PRINT N'TB'
	END
ELSE IF (@DIEMTHI >=7 AND @DIEMTHI < 9)
	BEGIN 
		PRINT N'Giỏi'
	END
-- Xem có ELSE IF HAY KHÔNG?

/*
 3.0 Hàm IIF () trả về một giá trị nếu một điều kiện là TRUE hoặc một giá trị khác nếu một điều kiện là FALSE.
IIF(condition, value_if_true, value_if_false)
*/
SELECT IIF(5>9,N'Đúng',N'Sai')

SELECT Ma,Ten,
	IIF(IdCH =1,N'Cửa Hàng 1',IIF(IdCH =2,N'Cửa Hàng 2',N'Không xác định'))
FROM NhanVien
/*
3.1 Câu lệnh CASE đi qua các điều kiện và trả về một giá trị khi điều kiện đầu tiên được đáp ứng (như câu lệnh IF-THEN-ELSE). 
Vì vậy, một khi một điều kiện là đúng, nó sẽ ngừng đọc và trả về kết quả. 
Nếu không có điều kiện nào đúng, nó sẽ trả về giá trị trong mệnh đề ELSE.
Nếu không có phần ELSE và không có điều kiện nào đúng, nó sẽ trả về NULL.
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    WHEN conditionN THEN resultN
    ELSE result
END;
*/
SELECT Ma,
	Ten = (CASE GioiTinh
	WHEN 'Nam' THEN 'Anh. ' + Ten
	WHEN N'Nữ' THEN N'Chị. ' + Ten
	ELSE N'Không xác định'
	END),
	GioiTinh
FROM NhanVien

SELECT Ma,
	Ten = (CASE 
	WHEN GioiTinh = 'Nam' THEN 'Anh. ' + Ten
	WHEN GioiTinh = N'Nữ' THEN N'Chị. ' + Ten
	ELSE N'Không xác định'
	END),
	GioiTinh
FROM NhanVien
/*Vòng lặp WHILE (WHILE LOOP) được sử dụng nếu bạn muốn 
chạy lặp đi lặp lại một đoạn mã khi điều kiện cho trước trả về giá trị là TRUE.*/
DECLARE @DEM INT = 0
WHILE @DEM < 5
BEGIN
	PRINT N'Lần thứ: ' + CONVERT(VARCHAR,@DEM)
	PRINT N'Muốn học môn COM2034 thì phải code nhiều'
	SET @DEM = @DEM + 1
END