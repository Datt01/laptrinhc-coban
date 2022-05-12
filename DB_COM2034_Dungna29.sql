CREATE DATABASE FINALASS_FPTShop_SP22_BL2_DUNGNA29
USE FINALASS_FPTShop_SP22_BL2_DUNGNA29

-- ChucVu
CREATE TABLE ChucVu(
Id INT PRIMARY KEY IDENTITY,
Ma VARCHAR(20) UNIQUE,
Ten NVARCHAR(50) DEFAULT NULL
)

-- CuaHang
CREATE TABLE CuaHang(
Id INT PRIMARY KEY IDENTITY,
Ma VARCHAR(20) UNIQUE,
Ten NVARCHAR(50) DEFAULT NULL,
DiaChi NVARCHAR(100) DEFAULT NULL,
ThanhPho NVARCHAR(50) DEFAULT NULL,
QuocGia NVARCHAR(50) DEFAULT NULL
)

-- NhanVien
CREATE TABLE NhanVien(
Id INT PRIMARY KEY IDENTITY,
Ma VARCHAR(20) UNIQUE,
Ten NVARCHAR(30) DEFAULT NULL,
TenDem NVARCHAR(30) DEFAULT NULL,
Ho NVARCHAR(30) DEFAULT NULL,
GioiTinh NVARCHAR(10) DEFAULT NULL,
NgaySinh DATE DEFAULT NULL,
DiaChi NVARCHAR(100) DEFAULT NULL,
Sdt VARCHAR(30) DEFAULT NULL,
IdCH INT,
IdCV INT,
IdGuiBC INT,
TrangThai INT DEFAULT 0
)
-- KhachHang
CREATE TABLE KhachHang(
Id INT PRIMARY KEY IDENTITY,
Ma VARCHAR(20) UNIQUE,
Ten NVARCHAR(30),
TenDem NVARCHAR(30) DEFAULT NULL,
Ho NVARCHAR(30) DEFAULT NULL,
NgaySinh DATE DEFAULT NULL,
Sdt VARCHAR(30) DEFAULT NULL,
DiaChi NVARCHAR(100) DEFAULT NULL,
ThanhPho NVARCHAR(50) DEFAULT NULL,
QuocGia NVARCHAR(50) DEFAULT NULL
)
--HoaDon
CREATE TABLE HoaDon(
Id INT PRIMARY KEY IDENTITY,
IdKH INT,
IdNV INT,
Ma VARCHAR(20) UNIQUE,
NgayTao DATE DEFAULT NULL,
NgayThanhToan DATE DEFAULT NULL,
NgayShip DATE DEFAULT NULL,
NgayNhan DATE DEFAULT NULL,
TinhTrang INT DEFAULT 0,
TenNguoiNhan NVARCHAR(50) DEFAULT NULL,
DiaChi NVARCHAR(100) DEFAULT NULL,
Sdt VARCHAR(30) DEFAULT NULL,
)
-- SanPham
CREATE TABLE SanPham(
Id INT PRIMARY KEY IDENTITY,
Ma VARCHAR(20) UNIQUE,
Ten NVARCHAR(30)
)

-- NSX
CREATE TABLE NSX(
Id INT PRIMARY KEY IDENTITY,
Ma VARCHAR(20) UNIQUE,
Ten NVARCHAR(30)
)

-- MauSac
CREATE TABLE MauSac(
Id INT PRIMARY KEY IDENTITY,
Ma VARCHAR(20) UNIQUE,
Ten NVARCHAR(30)
)

-- DongSP
CREATE TABLE DongSP(
Id INT PRIMARY KEY IDENTITY,
Ma VARCHAR(20) UNIQUE,
Ten NVARCHAR(30)
)

-- ChiTietSP
CREATE TABLE ChiTietSP(
Id INT PRIMARY KEY IDENTITY,
IdSP INT,
IdNsx INT,
IdMauSac INT,
IdDongSP INT,
NamBH INT DEFAULT NULL,
MoTa NVARCHAR(50) DEFAULT NULL,
SoLuongTon INT,
GiaNhap DECIMAL(20,0) DEFAULT 0,
GiaBan DECIMAL(20,0) DEFAULT 0,
)

-- HoaDonChiTiet
CREATE TABLE HoaDonChiTiet(
IdHoaDon INT,
IdChiTietSP INT,
SoLuong INT,
DonGia DECIMAL(20,0) DEFAULT 0,
CONSTRAINT PK_HoaDonCT PRIMARY KEY (IdHoaDon,IdChiTietSP),
CONSTRAINT FK1 FOREIGN KEY(IdHoaDon) REFERENCES HoaDon(Id),
CONSTRAINT FK2 FOREIGN KEY(IdChiTietSP) REFERENCES ChiTietSP(Id),
)
--TẠO QUAN HỆ GIỮA CÁC BẢNG
--NhanVien - CuaHang
ALTER TABLE NhanVien ADD FOREIGN KEY (IdCH) REFERENCES CuaHang(Id)
--NhanVien - ChucVu
ALTER TABLE NhanVien ADD FOREIGN KEY (IdCV) REFERENCES ChucVu(Id)
--NhanVien - GuiBaoCao
ALTER TABLE NhanVien ADD FOREIGN KEY (IdGuiBC) REFERENCES NhanVien(Id)
-- HoaDon - KhachHang
ALTER TABLE HoaDon ADD FOREIGN KEY (IdKH) REFERENCES KhachHang(Id)
-- HoaDon - NhanVien
ALTER TABLE HoaDon ADD FOREIGN KEY (IdNV) REFERENCES NhanVien(Id)
-- ChiTietSP - SanPham
ALTER TABLE ChiTietSP ADD FOREIGN KEY(IdSP) REFERENCES SanPham(Id)
-- ChiTietSP - NSX
ALTER TABLE ChiTietSP ADD FOREIGN KEY(IdNsx) REFERENCES Nsx(Id)
-- ChiTietSP - MauSac
ALTER TABLE ChiTietSP ADD FOREIGN KEY(IdMauSac) REFERENCES MauSac(Id)
-- ChiTietSP - DongSP
ALTER TABLE ChiTietSP ADD FOREIGN KEY(IdDongSP) REFERENCES DongSP(Id)

-- Tạo Data--
-- INSERT VALUES ChucVu
INSERT INTO ChucVu
VALUES	('CT',N'Chủ Tịch'),
		('GD',N'Giám Đốc'),
		('PGD',N'Phó Giám Đốc'),
		('GDDH',N'Giám Đốc Điều Hành'),
		('GDTC',N'Giám Đốc Tài Chính'),
		('GDCN',N'Giám Đốc Công Nghệ'),
		('GDMKT',N'Giám Đốc Marketing'),
		('GDTM',N'Giám Đốc Thương Mại'),
		('GDPC',N'Giám Đốc Pháp Chế'),
		('GDVH',N'Giám Đốc Vận Hành'),
		('GDSX',N'Giám Đốc Sản Xuất'),
		('QLNL',N'Quản Lý Nhân Lực'),
		('TCH',N'Trưởng Cửa Hàng'),
		('PCH',N'Phó Cửa Hàng'),
		('TP',N'Trưởng Phòng'),
		('TN',N'Trưởng Nhóm'),
		('NV',N'Nhân Viên'),
		('TT',N'Tiếp Thị'),
		('LC',N'Lao Công'),
		('KT',N'Kế Toán'),
		('LT',N'Lễ Tân'),
		('BV',N'Bảo Vệ')

-- INSERT VALUES CuaHang
INSERT INTO CuaHang
VALUES ('CH1',N'Cửa Hàng FPT SHOP',N'Số 45 Thái Hà',N'Hải Phòng',N'Việt Nam'),
	('CH2',N'Cửa Hàng FPT SHOP',N'Số 92 Hai Bà Trưng',N'Hà Nội',N'Việt Nam'),
	('CH3',N'Cửa Hàng FPT SHOP',N'Số 46 Hồ Tùng Mậu',N'Hà Nội',N'Việt Nam'),
	('CH4',N'Cửa Hàng FPT SHOP',N'Số 3-5 Đại La',N'Hà Nội',N'Việt Nam'),
	('CH5',N'Cửa Hàng FPT SHOP',N'Số 325 Phố Huế',N'Bắc Ninh',N'Việt Nam'),
	('CH6',N'Cửa Hàng FPT SHOP',N'Số 190 Xã Đàn',N'Hà Nội',N'Việt Nam'),
	('CH7',N'Cửa Hàng FPT SHOP',N'Số 216 Thái Hà',N'Hải Phòng',N'Việt Nam'),
	('CH8',N'Cửa Hàng FPT SHOP',N'Số 422 Cầu Giấy',N'Hà Nội',N'Việt Nam'),
	('CH9',N'Cửa Hàng FPT SHOP',N'Số 182 Lê Duẩn',N'Hà Nội',N'Việt Nam'),
	('CH10',N'Cửa Hàng FPT SHOP',N'Số 20 Đông Các',N'Bắc Ninh',N'Việt Nam'),
	('CH11',N'Cửa Hàng FPT SHOP',N'Số 495A Trương Định',N'Hồ Chính Minh',N'Việt Nam'),
	('CH12',N'Cửa Hàng FPT SHOP',N'Số 656 Núi Đôi',N'Hà Nội',N'Việt Nam'),
	('CH13',N'Cửa Hàng FPT SHOP',N'Số 217 Quang Trung',N'Hà Nội',N'Việt Nam'),
	('CH14',N'Cửa Hàng FPT SHOP',N'Số 160 Cầu Giấy',N'Bắc Ninh',N'Việt Nam'),
	('CH15',N'Cửa Hàng FPT SHOP',N'Số 22 Nguyễn Khang',N'Hồ Chí Minh',N'Việt Nam'),
	('CH16',N'Cửa Hàng FPT SHOP',N'Số 03 Xuân Thủy',N'Hà Nội',N'Việt Nam'),
	('CH17',N'Cửa Hàng FPT SHOP',N'Số 233 Trung Kính',N'Hà Nội',N'Việt Nam'),
	('CH18',N'Cửa Hàng FPT SHOP',N'Số 61 Trần Duy Hưng',N'Hà Nội',N'Việt Nam'),
	('CH19',N'Cửa Hàng FPT SHOP',N'Số 1 Bắc Linh Đàm',N'Bắc Ninh',N'Việt Nam'),
	('CH20',N'Cửa Hàng FPT SHOP',N'Số 24 Lĩnh Nam',N'Hà Nội',N'Việt Nam')

DBCC CHECKIDENT ('[NhanVien]', RESEED, 0);
-- INSERT VALUES NhanVien
INSERT INTO NhanVien
VALUES ('NV1',N'Dũng',N'Anh',N'Nguyễn','Nam','1991-05-03',N'152 Hàng Buồm Hà Nội','0988147200',1,17,null,1),
('NV2',N'Minh',N'Ba',N'Tiến','Nam','1992-05-11',N'251 Hàng Mã Hà Nội','0988147123',1,17,null,1),
('NV3',N'Tiến',N'Minh',N'Trần','Nam','1993-11-04',N'2 Hang Ma Hà Nội','0998147321',1,17,null,1),
('NV4',N'Thiện',N'Trần',N'Nguyễn','Nam','1998-05-01',N'2 Hàng Vải Hà Nội','093147456',1,1,null,1),
('NV5',N'Đạt',N'Trần',N'Nguyễn','Nam','1997-05-05',N'3 Hai Bà Trưng Hà Nội','0928147345',1,14,null,0),
('NV6',N'Long',N'Lê',N'Trần','Nam','1998-05-01',N'4 Thái Hà Hà Nội','0918147987',1,17,null,1),
('NV7',N'Loan',N'Hữu',N'Lê',N'Nữ','1999-08-08',N'1 Giảng Võ Hà Nội','0938147325',1,17,null,1),
('NV8',N'Thủy',N'Thị',N'Nguyễn',N'Nữ','1994-05-08',N'13 Hàng Vải Hà Nội','0988147325',1,17,null,1),
('NV9',N'Dũng',N'Tiến',N'Hoàng','Nam','1991-09-01',N'12 Hàng Gà Hà Nội','0948147890',5,17,null,1),
('NV10',N'Tùng',N'Nguyên',N'Trần','Nam','1990-05-08',N'15 Hàng Thùng Hà Nội','097884333',6,13,null,1),
('NV11',N'Nghĩa',N'Văn',N'Nguyễn','Nam','1992-05-09',N'55 Nguyễn Hoàng Tôn Hà Nội','0988147222',7,13,null,0),
('NV12',N'Toàn',N'Văn',N'Hoàng','Nam','1993-05-01',N'5 Trịnh Văn Bô Hà Nội','0928147333',8,17,null,1),
('NV13',N'Tồn',N'Như',N'Nguyễn','Nam','1992-05-02',N'555 Cầu Giấy Hà Nội','0978147333',2,17,null,1),
('NV14',N'Hà',N'Hoàng',N'Lê',N'Nữ','1998-05-01',N'66 Hoàng Hoa Thám Hà Nội','0998147235',2,17,null,1),
('NV15',N'Linh',N'Văn',N'Hoàng',N'Nữ','1999-09-02',N'77 Hoàng Quốc Việt Hà Nội','091814777',2,17,null,1),
('NV16',N'Trang',N'Tú',N'Lê',N'Nữ','1992-05-01',N'234 Nguyễn Hoàng Tôn Hà Nội','0918147779',2,17,null,0),
('NV17',N'Thủy',N'Thị',N'Nguyễn',N'Nữ','1993-05-01',N'345 Hàng Vải Hà Nội','0928147779',3,17,null,0),
('NV18',N'Tiến',N'Thị',N'Lê','Nam','1997-05-03',N'12 Trịnh Văn Bô Hà Nội','0928147222',4,17,null,1),
('NV19',N'Đô',N'Thanh',N'Lê','Nam','1997-05-01',N'213 Hàng Vải Hà Nội','0938147222',5,17,null,1),
('NV20',N'Thụ',N'Văn',N'Hoàng','Nam','1999-08-01',N'12 Hàng Buồm Hà Nội','0958147200',6,17,null,1)

DBCC CHECKIDENT ('[KhachHang]', RESEED, 0);

-- INSERT VALUES KhachHang
INSERT INTO KhachHang
VALUES('KH1',N'Anh',N'Ngọc',N'Nguyễn','2003-01-01','0916574700',N'1 Hàng Gà',N'Hà Nội',N'Việt Nam'),
('KH2',N'Thi',N'Xuân',N'Phạm','1992-02-07','0926574701',N'2 Trịnh Văn Bô',N'Hải Phòng',N'Việt Nam'),
('KH3',N'Bá',N'Xuân',N'Nguyễn','1993-03-08','0936574702',N'3 Hoàng Hoa Thám',N'Hà Nội',N'Việt Nam'),
('KH4',N'Tồn',N'Bá',N'Trần','1994-04-09','0946574703',N'4 Trịnh Văn Bô',N'Hải Phòng',N'Việt Nam'),
('KH5',N'Long',N'Đỗ',N'Nguyễn','1995-05-01','0956574704',N'5 Giang Văn Minh',N'Hải Dương',N'Việt Nam'),
('KH6',N'Diệp',N'Văn',N'Phạm','1996-06-01','0966574705',N'6 Hồng Hà',N'Hà Nam',N'Việt Nam'),
('KH7',N'Ánh',N'Ngọc',N'Nguyễn','1997-07-01','0976574706',N'7 Trịnh Văn Bô',N'Bình Dương',N'Việt Nam'),
('KH8',N'Thắng',N'Đức',N'Nguyễn','1998-01-07','0986574707',N'8 Hàng Gà',N'Hòa Bình',N'Việt Nam'),
('KH9',N'Mai Thanh',N'Thị',N'Lê','1999-09-01','0996574708',N'9 Hàng Buồm',N'Hà Nội',N'Việt Nam'),
('KH10',N'Mai Hương',N'Thị',N'Trần','1992-10-01','0916574709',N'10 Nguyễn Hoàng Tôn',N'Hà Nam',N'Việt Nam'),
('KH11',N'Duyệt',N'Thế',N'Đào','1993-11-01','0926574710',N'11 Trịnh Văn Bô',N'Hà Nam',N'Việt Nam'),
('KH12',N'Vinh',N'Công',N'Nguyễn','1994-12-01','0936574711',N'12 Hoàng Quốc Việt',N'Vinh',N'Việt Nam'),
('KH13',N'Anh',N'Đức',N'Nguyễn','1995-02-02','0946574712',N'13 Trịnh Văn Bô',N'Vinh',N'Việt Nam'),
('KH14',N'Chi',N'Mai',N'Lê','1996-03-03','0956574713',N'14 Hoàng Quốc Việt',N'Bình Định',N'Việt Nam'),
('KH15',N'Chi',N'Quỳnh',N'Nguyễn','1997-04-04','0966574714',N'15 Hoàng Quốc Việt',N'Hòa Bình',N'Việt Nam'),
('KH16',N'Chi',N'Mai',N'Kiều','1998-05-05','0976574715',N'16 Trịnh Văn Bô',N'Thái Nguyên',N'Việt Nam'),
('KH17',N'Anh',N'Thế',N'Nguyễn','1999-06-06','0986574716',N'17 Hàng Gà',N'Hà Nội',N'Việt Nam'),
('KH18',N'Lộc',N'Văn',N'Nguyễn','1992-07-07','0996574717',N'18 Hàng Gà',N'Hà Nội',N'Việt Nam'),
('KH19',N'Ninh',N'Mạnh',N'Phạm','1993-08-08','0916574718',N'19 Hàng Gà',N'Hà Nội',N'Việt Nam'),
('KH20',N'My',N'Trà',N'Nguyễn','1994-09-09','0916574719',N'20 Trịnh Văn Bô',N'Hà Nội',N'Việt Nam')

-- INSERT VALUES HoaDon
DBCC CHECKIDENT ('[HoaDon]', RESEED, 0);
INSERT INTO HoaDon
VALUES ('1','1','HD1','2022-01-01','2022-01-01','2022-01-01','2022-01-01','1',N'Nguyễn Ngọc Anh',N'1 Trịnh Văn Bô Hà Nội','0826574700'),
	('2','2','HD2','2022-02-22','2022-02-22','2022-01-22','2022-01-25','1',N'Trần Quốc Hoàn',N'103 Phú Diễn Hà Nội','0913043020'),
	('3','3','HD3','2022-03-23','2022-02-22','2022-02-27','2022-02-28','1',N'Lê Ngọc Sáng',N'104 Hoàng Tôn Hà Nội','0923043021'),
	('4','4','HD4','2022-04-22','2022-04-22','2022-04-29','2022-05-05','1',N'Trần Quốc Anh',N'105 Phú Diễn Hà Nội','0933043022'),
	('5','5','HD5','2022-05-13','2022-05-13','2022-05-18','2022-05-19','1',N'Trần Quốc Đan',N'106 Phạm Hùng Hà Nội','0943043023'),
	('6','6','HD6','2022-06-13','2022-06-13','2022-06-19','2022-06-20','1',N'Trần Hải Phong',N'107 Hùng VƯơng Hà Nội','0953043024'),
	('7','7','HD7','2022-07-03','2022-07-03',NULL,NULL,'0',N'Trần Quốc Nghĩa',N'108 Trần Phú Hà Nội','0953043025'),
	('8','8','HD8','2022-08-03','2022-08-03','2022-08-05','2022-08-08','1',N'Nguyễn Quốc Hoàn',N'109 Văn Điển Hà Nội','0973043026'),
	('9','9','HD9','2022-09-03','2022-09-03','2022-09-03','2022-09-09','1',N'Phạm Quốc Hoàn',N'110 Hoàng Hoa Thám Hà Nội','0913043027'),
	('10','10','HD10','2022-01-23','2022-01-23','2022-01-24',NULL,'0',N'Nguyễn Đỗ Việt',N'111 Phú Diễn Hà Nội','0923043028'),
	('11','11','HD11','2022-02-23','2022-02-23','2022-02-25','2022-02-27','1',N'Nguyễn Khắc Việt',N'112 Lê DUẩn Hà Nội','0923043029'),
	('12','12','HD12','2022-03-13','2022-03-13','2022-03-17','2022-03-18','1',N'Nguyễn Khắc Hưng',N'113 Hàng Gà Hà Nội','0933043030'),
	('13','13','HD13','2022-04-14','2022-04-14','2022-04-19','2022-04-20','1',N'Trần Đức Phúc',N'114 Hàng Buồm Hà Nội','0944043031'),
	('14','14','HD14','2022-05-14','2022-05-14','2022-05-14',NULL,'0',N'Trần Quốc Hòa',N'115 Phan Đình Phùng Hà Nội','0943043032'),
	('15','15','HD15','2022-06-11','2022-06-11','2022-06-17',NULL,'0',N'Nguyễn Tuấn Anh',N'116 Hoàng Hoa Thám Hà Nội','0923043033'),
	('16','16','HD16','2022-07-11','2022-07-11','2022-07-11','2022-07-12','1',N'Nguyễn Quang Hải',N'117 Hoàng Quốc Việt Hà Nội','0933043034'),
	('17','17','HD17','2022-08-12','2022-08-12','2022-08-15','2022-08-17','1',N'Đoàn Văn Hậu',N'118 Từ Liêm Hà Nội','0983043035'),
	('18','18','HD18','2022-09-21','2022-09-21','2022-09-25','2022-09-28','1',N'Nguyễn Công Phượng',N'119 Phú Diễn Hà Nội','0983043036'),
	('19','19','HD19','2022-10-22','2022-10-22','2022-10-25','2022-10-29','1',N'Bùi Tấn Trường',N'120 Long Biên Hà Nội','0983043037'),
	('20','20','HD20','2022-10-02','2022-10-02','2022-10-06','2022-10-20','1',N'Quế Ngọc Hải',N'121 Hàng Gà Hà Nội','093043038'),
	('1','1','HD21','2022-05-01','2022-05-01','2022-05-01','2022-05-04','1',N'Nguyễn Ngọc Anh',N'1 Trịnh Văn Bô Hà Nội','0826574700'),
	('1','1','HD22','2022-06-01','2022-06-01','2022-06-02','2022-06-05','1',N'Nguyễn Ngọc Anh',N'1 Trịnh Văn Bô Hà Nội','0826574700'),
	('1','1','HD23','2022-07-01','2022-07-01','2022-07-03','2022-07-06','1',N'Nguyễn Ngọc Anh',N'1 Trịnh Văn Bô Hà Nội','0826574700'),
	('1','1','HD24','2022-08-01','2022-08-01','2022-08-04','2022-08-07','1',N'Nguyễn Ngọc Anh',N'1 Trịnh Văn Bô Hà Nội','0826574700'),
	('17','18','HD25','2022-09-12','2022-09-12','2022-09-15','2022-09-17','1',N'Đoàn Văn Hậu',N'118 Từ Liêm Hà Nội','0983043035'),
	('17','19','HD26','2022-10-12','2022-10-12','2022-10-15','2022-10-17','1',N'Đoàn Văn Hậu',N'118 Từ Liêm Hà Nội','0983043035'),
	('17','1','HD27','2022-08-12','2022-08-12','2022-08-15','2022-08-17','1',N'Đoàn Văn Hậu',N'118 Từ Liêm Hà Nội','0983043035'),
	('17','12','HD28','2022-07-12','2022-07-12','2022-07-15','2022-07-17','1',N'Đoàn Văn Hậu',N'118 Từ Liêm Hà Nội','0983043035'),
	('17','13','HD29','2022-06-12','2022-06-12','2022-06-15','2022-06-17','1',N'Đoàn Văn Hậu',N'118 Từ Liêm Hà Nội','0983043035'),
	('17','14','HD30','2022-05-12','2022-05-12','2022-05-15','2022-05-17','1',N'Đoàn Văn Hậu',N'118 Từ Liêm Hà Nội','0983043035')

-- INSERT VALUES SanPham
INSERT INTO SanPham
VALUES	('SP1','Laptop'),
		('SP2','Ipad'),
		('SP3','PC Gaming'),
		('SP4','PC Streaming'),
		('SP5','PC Design'),
		('SP6','PC Render'),
		('SP7','PC MMO'),
		('SP8','PC Trading'),
		('SP9','MainBoard Intel'),
		('SP10','MainBoard AMD'),
		('SP11','Chipset'),
		('SP12','Ram DDR3'),
		('SP13','Ram DDR4'),
		('SP14','Ram DDR5'),
		('SP15','VGA NVIDIA'),
		('SP16','VGA AMD'),
		('SP17','G-Desk'),
		('SP18','Webcam-Logitech'),
		('SP19','Webcam-Microsoft'),
		('SP20','Microphone Kingston')

--INSERT VALUES NSX
INSERT INTO NSX
VALUES	('DL','Dell'),
		('AR','Acer'),
		('AS','Asus'),
		('HP','HP'),
		('LO','Lenovo'),
		('AE','Apple'),
		('MSI','MSI'),
		('LG','LG'),
		('GGB','Gigabyte'),
		('CCD','ConceptD'),
		('IL','Intel'),
		('SS','SamSung'),
		('AVT','Avita'),
		('MCS','Microsoft'),
		('SoV','Sony Vaio'),
		('ToSB','Toshiba'),
		('Rz','Razer'),
		('ALW','Alienware'),
		('FJS','Fujitsu'),
		('MaT','Masstel')

INSERT INTO MauSac
VALUES	('MS1',N'Đen'),
		('MS2',N'Xám'),
		('MS3',N'Trắng'),
		('MS4',N'Đỏ'),
		('MS5',N'Xanh'),
		('MS6',N'Vàng'),
		('MS7',N'Bạc'),
		('MS8',N'Hồng'),
		('MS9',N'Nâu'),
		('MS10',N'Cam'),
		('MS11',N'Đen Đỏ'),
		('MS12',N'Xanh Đen'),
		('MS13',N'Xanh Băng'),
		('MS14',N'Bạch Kim'),
		('MS15',N'Đen Mờ'),
		('MS16',N'Than Chì'),
		('MS17',N'Sa Thạch'),
		('MS18',N'Xanh Cô Ban'),
		('MS19',N'Nâu Sẫm'),
		('MS20',N'Nâu Đỏ')

-- INSERT VALUE DongSP

INSERT INTO DongSP
VALUES	('DSP1','Inspiron'),
		('DSP2','Vostro'),
		('DSP3','Latitude'),
		('DSP4','XPS'),
		('DSP5','Precision'),
		('DSP6','Aspire'),
		('DSP7','Swift'),
		('DSP8','Nitro'),
		('DSP9','Predator'),
		('DSP10','VivoBook'),
		('DSP11','ZenBook'),
		('DSP12','ProArt'),
		('DSP13','TUF'),
		('DSP14','ROG'),
		('DSP15','ProBook'),
		('DSP16','Envy'),
		('DSP17','Zbook'),
		('DSP18','Legion'),
		('DSP19','MacBook Air'),
		('DSP20','MacBook Pro')
-- INSERT VALUE ChiTietSP

INSERT INTO ChiTietSP
VALUES ('1','2','1','20',2,'',160,22000000,23000000),
		('9','1','2','19',2,'',250,22500000,24000000),
		('8','3','3','18',1,'',150,22000000,25000000),
		('1','4','4','17',1,'',250,20500000,26000000),
		('7','5','5','16',2,'',250,19000000,21000000),
		('5','5','6','15',3,'',350,18000000,23000000),
		('2','4','7','14',3,'',50,20000000,25000000),
		('3','2','8','13',3,'',150,21000000,23000000),
		('4','7','9','12',2,'',40,21500000,24000000),
		('6','4','10','11',2,'',30,27000000,29000000),
		('11','11','11','10',2,'',20,21000000,23000000),
		('13','10','12','9',2,'',10,19000000,21000000),
		('12','9','13','8',1,'',450,18000000,20000000),
		('10','8','14','7',1,'',550,28000000,30000000),
		('17','8','15','6',2,'',650,27000000,29000000),
		('18','7','16','5',2,'',750,26000000,29500000),
		('19','5','17','4',2,'',850,24000000,26500000),
		('20','4','18','3',2,'',950,22000000,23500000),
		('15','2','19','2',3,'',650,21000000,24000000),
		('16','1','20','1',2,'',550,25000000,27000000)

INSERT INTO HoaDonChiTiet
VALUES (1,1,1,23000000),
	   (1,2,2,24000000),
	   (1,3,1,25000000),
	   (1,4,1,26000000),
	   (2,1,1,21000000),
	   (3,2,1,22000000),
	   (4,3,1,23000000),
	   (5,4,1,24000000),
	   (6,5,1,25000000),
	   (7,6,1,22000000),
	   (8,7,1,23000000),
	   (9,8,1,24000000),
	   (10,9,1,25000000),
	   (11,10,1,24000000),
	   (12,11,1,25000000),
	   (13,12,1,26000000),
	   (14,13,6,27000000),
	   (15,14,1,28000000),
	   (16,15,3,29000000),
	   (17,16,1,28000000),
	   (18,17,1,30000000),
	   (19,18,2,46000000),
	   (20,4,1,24000000),
	   (21,5,1,26000000),
	   (22,6,5,25000000),
	   (24,7,1,27000000),
	   (25,8,4,29000000),
	   (26,9,1,28000000),
	   (27,10,1,22000000),
	   (28,11,3,23000000),
	   (29,12,1,24000000),
	   (30,13,3,25000000)

