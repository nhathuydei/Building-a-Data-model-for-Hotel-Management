create DATABASE qlks1;
USE qlks1;
DROP DATABASE qlks;
CREATE TABLE guest 
(
	id INT PRIMARY KEY,
	first_name NVARCHAR(100),
	last_name NVARCHAR(100),
	phone VARCHAR(20),
	address NVARCHAR(200),
	gender NVARCHAR(10)
);

CREATE TABLE room_type
(
	name NVARCHAR(100) PRIMARY KEY,
	description NVARCHAR(200),
	max_guest INT,
	cost_per_day INT
);

CREATE TABLE department 
(
	id INT PRIMARY KEY,
	name NVARCHAR(100),
	manager_id INT
);

CREATE TABLE employee
(
	id INT PRIMARY KEY,
	first_name NVARCHAR(100),
	last_name NVARCHAR(100),
	phone VARCHAR(20),
	address NVARCHAR(200),
	gender NVARCHAR(5),
	department_id INT
);

-- Tham chiếu mã nhân viên quản lý đến mã nhân viên
ALTER TABLE department
ADD CONSTRAINT fk_manager FOREIGN KEY (manager_id)
REFERENCES employee(id);

-- Tham chiếu department_id -> department.id
ALTER TABLE employee
ADD CONSTRAINT fk_department FOREIGN KEY (department_id)
REFERENCES department(id);

CREATE TABLE reservation
(
	id INT PRIMARY KEY,
	date_in DATE,
	date_out DATE,
	made_by NVARCHAR(100),
	payment_type NVARCHAR(100),
	guest_id INT,
	employee_id INT,
	FOREIGN KEY (guest_id) REFERENCES guest(id),
	FOREIGN KEY (employee_id) REFERENCES employee(id)
);

CREATE TABLE room
(
	id INT PRIMARY KEY,
	smoke NVARCHAR(10),
	room_type_name NVARCHAR(100),
	FOREIGN KEY (room_type_name) REFERENCES room_type(name)
);

CREATE TABLE reserved_room
(
	id INT PRIMARY KEY,
	number_of_rooms INT,
	reservation_id INT,
	room_type_name NVARCHAR(100),
	FOREIGN KEY (reservation_id) REFERENCES reservation(id),
	FOREIGN KEY (room_type_name) REFERENCES room_type(name)
);

CREATE TABLE occupied_room
(
	id INT PRIMARY KEY,
	room_id INT,
	reservation_id INT,
	FOREIGN KEY (room_id) REFERENCES room(id),
	FOREIGN KEY (reservation_id) REFERENCES reservation(id)
);

CREATE TABLE hosted_at
(
	id INT PRIMARY KEY,
	occupied_room_id int,
	guest_id INT,
	FOREIGN KEY (occupied_room_id) REFERENCES occupied_room(id),
	FOREIGN KEY (guest_id) REFERENCES guest(id)
);

CREATE TABLE service
(
	id INT PRIMARY KEY,
	name NVARCHAR(100),
	price INT,
	department_id INT,
	FOREIGN KEY (department_id) REFERENCES department(id)
);

CREATE TABLE used_service
(
	id INT PRIMARY KEY,
	guest_id INT,
	service_id INT,
	date_use DATE,
	FOREIGN KEY (guest_id) REFERENCES guest(id),
	FOREIGN KEY (service_id) REFERENCES service(id)
);

SET DATEFORMAT dmy; /* thiết lập cách nhập ngày dd/mm/yyyy */

SELECT * FROM guest;
/* Insert data bảng guest */
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES ('1', N'Lê Ngọc', N'Cảnh', '064 3854 756', N'73 Phố Cao Vân Bình, Xã Trọng Hồng, Huyện 9, Sóc Trăng', N'Nam');
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES ('2', N'Ngô Vĩnh', N'Toàn', '064 3854 628', N'9673 Phố Cự Băng Lộc, Xã 06, Quận Phạm Phát Tuyết, Hà Nam', N'Nam');
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES ('3', N'Ngô Mộng', N'Vy', '039 6255 255', N'851, Thôn Thạch Mỹ, Phường Phi Thanh, Huyện Quản, Đắk Nông', N'Nữ');
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES ('4', N'Huỳnh Bích', N'San', '090 998 11 06', N'502 Phố Khúc Sinh Đạo, Xã Nga, Quận Cam Phong Dụng, Bình Dương', N'Nữ');
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES ('5', N'Trần Mai', N'Khôi', '064 3511 224', N'39 Phố  u, Phường Hoàng Hạ Châu, Huyện Giáp, Cao Bằng', N'Nam');
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES ('6', N'Lê An', N'Nhàn', '064 3531 147', N'1207 Phố Kính, Phường Thôi Minh Khuyên, Quận 72, Cần Thơ', N'Nam');
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES ('7', N'Chung Hồng', N'Hoa', '064 3655 589', N'31 Phố Cung, Phường 8, Huyện 66, Hà Nội', N'Nữ');
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES ('8', N'Ngư Hoa', N'Thiên', '064 3811 994', N'337 Phố Vương Quỳnh Di, Ấp Cát An, Quận Kiều, Tiền Giang', N'Nam');
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES ('9', N'Bùi Bảo', N'Lâm', '064 3756 666', N'6 Phố Hình Vũ Di, Phường Hy Công Di, Quận Võ Nghiêm, Nam Định', N'Nữ');
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES ('10', N'Trần Hữu', N'Vĩnh', '064 3521 968', N'25, Thôn Thống Mai, Phường 35, Huyện 1, Gia Lai', N'Nữ');
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES ('11', N'Ngô Nhật', N'Quốc', '097 766 00 00', N'7, Thôn Thơ, Thôn Hùng Tú, Quận 5, Hòa Bình', N'Nữ');
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES ('12', N'Thân Gia', N'Uy', '060 6559 655', N'73 Phố Cao Vân Bình, Xã Trọng Hồng, Huyện 9, Sóc Trăng', N'Nam');
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES ('13', N'Chung Việt', N'Anh', '029 3865 139', N'7066 Phố San, Xã Dụng Đan, Quận Bào Ly, Đắk Nông', N'Nữ');
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES ('14', N'Lý Thanh', N'Minh', '063 3833 758', N'49 Phố Bành Phong Phụng, Xã Tòng, Huyện Cát Lễ Thi, Hà Giang', N'Nữ');
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES ('15', N'Nguyễn Giang', N'Thanh', '063 3570 373', N'8371 Phố Mẫn Xuân Kiều, Xã Dân, Huyện Bình Hiệp, Thừa Thiên Huế', N'Nam');
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES ('16', N'Vũ Ngọc', N'Vy', '063 3810 888', N'741 Phố Ngụy Hương Đan, Phường 23, Huyện Vũ Vĩnh, Hà Nội', N'Nam');
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES ('17', N'Văn Tuyết', N'Hồng', '093 588 32 24', N'69 Phố Tòng Châu Tấn, Phường 37, Huyện Công, Kon Tum', N'Nữ');
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES (18', N'Lý Mai', N'Thảo', '063 3834 317', N'83, Ấp Mã Uy, Xã Danh, Quận Anh Hải, Kon Tum', N'Nam');
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES ('19', N'Huỳnh Cát', N'Tường', '063 3531 282', N'31 Phố Hoài, Ấp Bửu Phi, Quận Phi Canh Đài, Quảng Ninh', N'Nữ');
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES ('20', N'Trần Phương', N'Mai', '063 3836 946', N'2 Phố Trung, Phường Hải, Huyện Học, Bắc Giang', N'Nữ');
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES ('21', N'Hoàng Nghĩa', N'Hòa', '063 3822 934', N'99 Phố Phạm, Phường Đại, Quận Thời Thi, Cần Thơ', N'Nữ');
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES ('22', N'Ngô Bảo', N'Trân', '063 3828 007', N'60 Phố Ca, Ấp Thi Kim, Quận Chưởng Tông, Hậu Giang', N'Nam');
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES ('23', N'Kiều Cẩm', N'Thúy', '063 3828 210', N'419 Phố Dã, Ấp Thương Tuệ, Quận Mạch Đức Hậu, Đà Nẵng', N'Nữ');
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES ('24', N'Bùi Ngọc', N'Huyền', '063 3822 724', N'40 Phố Sơn Triệu Thương, Phường 8, Quận Thịnh, Bạc Liêu', N'Nữ');
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES ('25', N'Đặng Anh', N'Thơ', '0710 3814 928', N'039 Phố Cổ Hải Bích, Xã Phú Lai, Huyện Vỹ, Hồ Chí Minh', N'Nam');
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES ('26', N'Quang Tố', N'Nhi', '054 3837 272', N'2, Ấp Cung, Phường Quản Khoát Chưởng, Quận 91, Thanh Hóa', N'Nam');
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES ('27', N'Phạm Thụy', N'Uyên', '066 3827 465', N'069, Ấp 3, Xã Tâm Hán, Huyện 0, Gia Lai', N'Nữ');
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES ('28', N'Phạm Anh', N'Khải', '060 3862 584', N'75, Ấp Sinh Việt, Xã Nhiên, Quận Thiện, Hưng Yên', N'Nữ');
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES ('29', N'Đàm Vĩnh', N'Hải', '064 3531 147', N'55, Ấp Đạt Hán, Ấp Ánh Kim, Huyện Diệu Khương, Phú Yên', N'Nữ');
INSERT INTO guest(id, first_name, last_name, phone, address, gender) 
VALUES ('30', N'Chu Hạo', N'Nhiên', '0500 3842 411', N'6862, Ấp 76, Phường Nhạn Hàn, Quận Nghiêm, Nghệ An', N'Nam');

SELECT * FROM room_type;
DELETE FROM room_type;
/* Insert data bảng room_type */
INSERT INTO room_type(name, description, max_guest, cost_per_day)
VALUES ('SGL', N'Phòng có 1 giường cho 1 người ngủ', 1, 500000);
INSERT INTO room_type(name, description, max_guest, cost_per_day)
VALUES ('TWN', N'Phòng có 2 giường cho 2 người ngủ', 2, 800000);
INSERT INTO room_type(name, description, max_guest, cost_per_day)
VALUES ('DBL', N'Phòng có 1 giường lớn cho 2 người ở ngủ', 2, 800000);
INSERT INTO room_type(name, description, max_guest, cost_per_day)
VALUES ('TRPL', N'Phòng 3 giường nhỏ hoặc 1 giường lớn + 1 giường nhỏ cho 3 người ngủ', 3, 1500000);

SELECT * FROM department;
/* Insert data bảng department */
INSERT INTO department(id, name, manager_id)
VALUES (1, N'Lễ tân', NULL);
INSERT INTO department(id, name, manager_id)
VALUES (2, N'Buồng phòng', NULL);
INSERT INTO department(id, name, manager_id)
VALUES (3, N'Nhà hàng và quầy uống', NULL);
INSERT INTO department(id, name, manager_id)
VALUES (4, N'Kế toán - tài chính', NULL);
INSERT INTO department(id, name, manager_id)
VALUES (5, N'Nhân sự', NULL);
INSERT INTO department(id, name, manager_id)
VALUES (6, N'Kỹ thuật', NULL);
INSERT INTO department(id, name, manager_id)
VALUES (7, N'Bảo vệ', NULL);

SELECT * FROM employee;
/* Insert data bảng employee */
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (1, N'Trần Thanh', N'San', '062 222 2265', N'60 Phố Ca, Ấp Thi Kim, Quận Chưởng Tông, Hậu Giang', N'Nữ', 1);
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (2, N'Đồng Đức', N'Thanh', '0129 010 8990', N'419 Phố Dã, Ấp Thương Tuệ, Quận Mạch Đức Hậu, Đà Nẵng', N'Nam', 1);
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (3, N'Vũ Bảo', N'Hòa', '0163 931 1442', N'40 Phố Sơn Triệu Thương, Phường 8, Quận Thịnh, Bạc Liêu', N'Nam', 1);
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (4, N'Phạm Quỳnh', N'Nhung', '077 399 3489', N'039 Phố Cổ Hải Bích, Xã Phú Lai, Huyện Vỹ, Hồ Chí Minh', N'Nữ', 1);
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (5, N'Huỳnh Trung', N'Ðức', '0500 343 970', N'2, Ấp Cung, Phường Quản Khoát Chưởng, Quận 91, Thanh Hóa', N'Nam', 1);
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (6, N' n Thái', N'Duy', '061 371 4796', N'069, Ấp 3, Xã Tâm Hán, Huyện 0, Gia Lai', N'Nam', 1);
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (7, N'Đinh Thanh', N'An', '0912 234 431', N'75, Ấp Sinh Việt, Xã Nhiên, Quận Thiện, Hưng Yên', N'Nam', 1);
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (8, N'Thảo Thanh', N'Hải', '0840 231 542', N'55, Ấp Đạt Hán, Ấp Ánh Kim, Huyện Diệu Khương, Phú Yên', N'Nam', 2);
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (9, N'Nguyễn Ðức', N'Bình', '0231 567 345', N'6862, Ấp 76, Phường Nhạn Hàn, Quận Nghiêm, Nghệ An', N'Nữ', 2);
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (10, N'Dương Kỳ', N'Duyên', '0980 121 656', N'0, Thôn 6, Xã Nhã Đàn, Huyện Phương Du, Thái Nguyên', N'Nữ', 2);
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (11, N'Tô Tường', N'Phát', '0123 654 432', N'9673 Phố Cự Băng Lộc, Xã 06, Quận Phạm Phát Tuyết, Hà Nam', N'Nam', 2);
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (12, N'Lý Quang', N'Thuận', '0712 321 879', N'851, Thôn Thạch Mỹ, Phường Phi Thanh, Huyện Quản, Đắk Nông', N'Nam', 2);
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (13, N'Mạc Thục', N'Khuê', '044 626 7887', N'502 Phố Khúc Sinh Đạo, Xã Nga, Quận Cam Phong Dụng, Bình Dương', N'Nữ', 2);
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (14, N'Bành Nhật', N'Quân', '0321 012 324', N'39 Phố  u, Phường Hoàng Hạ Châu, Huyện Giáp, Cao Bằng', N'Nam', 3);
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (15, N'Hàn Thủy', N'Minh', '0913 491 203', N'1207 Phố Kính, Phường Thôi Minh Khuyên, Quận 72, Cần Thơ', N'Nữ', 3);
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (16, N'Phùng An', N'Nhiên', '0312 421 126', N'31 Phố Cung, Phường 8, Huyện 66, Hà Nội', N'Nữ', 3);
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (17, N'Liễu Phượng', N'Loan', '0913 123 345', N'337 Phố Vương Quỳnh Di, Ấp Cát An, Quận Kiều, Tiền Giang', N'Nữ', 3);
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (18, N'Trần Ngọc', N'Sơn', '0412 123 643', N'6 Phố Hình Vũ Di, Phường Hy Công Di, Quận Võ Nghiêm, Nam Định', N'Nam', 3);
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (19, N'Trang Quế', N'Phương', '0932 123 512', N'25, Thôn Thống Mai, Phường 35, Huyện 1, Gia Lai', N'Nữ', 3);
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (20, N'Mạc Thịnh', N'Cường', '0876 132 123', N'7, Thôn Thơ, Thôn Hùng Tú, Quận 5, Hòa Bình', N'Nữ', 4);
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (21, N'Cao Quỳnh', N'Thanh', '0909 123 353', N'73 Phố Cao Vân Bình, Xã Trọng Hồng, Huyện 9, Sóc Trăng', N'Nam', 4);
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (22, N'Phan Dạ', N'Yến', '0999 111 222', N'7066 Phố San, Xã Dụng Đan, Quận Bào Ly, Đắk Nông', N'Nữ', 5);
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (23, N'Trần Ðài', N'Trang', '0899 133 222', N'49 Phố Bành Phong Phụng, Xã Tòng, Huyện Cát Lễ Thi, Hà Giang', N'Nữ', 5);
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (24, N'Chu Ngọc', N'Lân', '0789 132 123', N'8371 Phố Mẫn Xuân Kiều, Xã Dân, Huyện Bình Hiệp, Thừa Thiên Huế', N'Nam', 5);
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (25, N'Đoàn Minh', N'Lân', '0451 231 752', N'741 Phố Ngụy Hương Đan, Phường 23, Huyện Vũ Vĩnh, Hà Nội', N'Nam', 6);
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (26, N'Huỳnh Nhật', N'Huy', '0315 325 763', N'69 Phố Tòng Châu Tấn, Phường 37, Huyện Công, Kon Tum', N'Nam', 6);
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (27, N'Phùng Hữu', N'Trí', '0151 999 888', N'83, Ấp Mã Uy, Xã Danh, Quận Anh Hải, Kon Tum', N'Nam', 6);
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (28, N'Hàn Ðức', N'Trung', '0132 341 000', N'31 Phố Hoài, Ấp Bửu Phi, Quận Phi Canh Đài, Quảng Ninh', N'Nam', 7);
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (29, N'Bùi Ðức', N'Siêu', '0900 133 222', N'2 Phố Trung, Phường Hải, Huyện Học, Bắc Giang', N'Nam', 7);
INSERT INTO employee(id, first_name, last_name, phone, address, gender, department_id)
VALUES (30, N'Nguyễn Nam', N'Phương', '0871 324 452', N'99 Phố Phạm, Phường Đại, Quận Thời Thi, Cần Thơ', N'Nữ', 7);

SELECT * FROM department;
/* Update manager_id vào bảng department */
UPDATE department SET manager_id = 1 WHERE id = 1;
UPDATE department SET manager_id = 8 WHERE id = 2;
UPDATE department SET manager_id = 14 WHERE id = 3;
UPDATE department SET manager_id = 20 WHERE id = 4;
UPDATE department SET manager_id = 22 WHERE id = 5;
UPDATE department SET manager_id = 25 WHERE id = 6;
UPDATE department SET manager_id = 28 WHERE id = 7;

SELECT * FROM reservation;
/* Insert data bảng reservation */
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type, guest_id, employee_id)
VALUES (1, '2022-02-20', '2022-02-23', N'Trực tiếp', N'Tiền mặt', 1, 1);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type, guest_id, employee_id)
VALUES (2, '2022-02-20', '2022-02-23', N'Điện thoại', N'Ví điện tử', 5, 2);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type, guest_id, employee_id)
VALUES (3, '2022-02-21', '2022-02-25', N'Email', N'Thẻ', 7, 3);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type, guest_id, employee_id)
VALUES (4, '2022-02-23', '2022-02-24', N'Online', N'Séc trực tuyến', 8, 4);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type, guest_id, employee_id)
VALUES (5, '2022-02-23', '2022-02-27', N'Điện thoại', N'Chuyển khoản', 11, 5);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type, guest_id, employee_id)
VALUES (6, '2022-02-25', '2022-02-26', N'Email', N'Cổng điện tử', 13, 4);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type, guest_id, employee_id)
VALUES (7, '2022-02-26', '2022-03-01', N'Trực tiếp', N'Séc trực tuyến', 16, 7);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type, guest_id, employee_id)
VALUES (8, '2022-02-26', '2022-03-03', N'Online', N'Chuyển khoản', 17, 1);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type, guest_id, employee_id)
VALUES (9, '2022-02-28', '2022-03-04', N'Điện thoại', N'Cổng điện tử', 19, 7);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type, guest_id, employee_id)
VALUES (10, '2022-03-02', '2022-03-04', N'Điện thoại', N'Ví điện tử', 20, 2);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type, guest_id, employee_id)
VALUES (11, '2022-03-02', '2022-03-02', N'Email', N'Thẻ', 26, 3);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type, guest_id, employee_id)
VALUES (12, '2022-03-03', '2022-03-06', N'Online', N'Séc trực tuyến', 28, 4);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type, guest_id, employee_id)
VALUES (13, '2022-03-04', '2022-03-05', N'Điện thoại', N'Chuyển khoản', 1, 5);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type, guest_id, employee_id)
VALUES (14, '2022-03-08', '2022-03-09', N'Email', N'Thẻ', 7, 3);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type, guest_id, employee_id)
VALUES (15, '2022-03-08', '2022-03-10', N'Trực tiếp', N'Thẻ', 2, 7);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type, guest_id, employee_id)
VALUES (16, '2022-03-08', '2022-03-10', N'Online', N'Chuyển khoản', 8, 1);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type, guest_id, employee_id)
VALUES (17, '2022-03-09', '2022-03-09', N'Online', N'Cổng điện tử', 9, 2);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type, guest_id, employee_id)
VALUES (18, '2022-03-11', '2022-03-14', N'Điện thoại', N'Ví điện tử', 10, 5);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type, guest_id, employee_id)
VALUES (19, '2022-03-12', '2022-03-14', N'Trực tiếp', N'Thẻ', 20, 4);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type, guest_id, employee_id)
VALUES (20, '2022-03-13', '2022-03-14', N'Online', N'Ví điện tử', 25, 1);

SELECT * FROM room;
/* Insert data bảng room */
INSERT INTO room(id, smoke, room_type_name)
VALUES (101, N'Có', 'SGL');
INSERT INTO room(id, smoke, room_type_name)
VALUES (102, N'Có', 'TWN');
INSERT INTO room(id, smoke, room_type_name)
VALUES (103, N'Không', 'DBL');
INSERT INTO room(id, smoke, room_type_name)
VALUES (104, N'Không', 'TRPL');
INSERT INTO room(id, smoke, room_type_name)
VALUES (105, N'Có', 'TRPL');
INSERT INTO room(id, smoke, room_type_name)
VALUES (201, N'Không', 'SGL');
INSERT INTO room(id, smoke, room_type_name)
VALUES (202, N'Không', 'TWN');
INSERT INTO room(id, smoke, room_type_name)
VALUES (203, N'Có', 'DBL');
INSERT INTO room(id, smoke, room_type_name)
VALUES (204, N'Có', 'TRPL');
INSERT INTO room(id, smoke, room_type_name)
VALUES (205, N'Không', 'TRPL');
INSERT INTO room(id, smoke, room_type_name)
VALUES (206, N'Không', 'TRPL');
INSERT INTO room(id, smoke, room_type_name)
VALUES (301, N'Không', 'SGL');
INSERT INTO room(id, smoke, room_type_name)
VALUES (302, N'Có', 'TWN');
INSERT INTO room(id, smoke, room_type_name)
VALUES (303, N'Không', 'DBL');
INSERT INTO room(id, smoke, room_type_name)
VALUES (304, N'Không', 'TRPL');
INSERT INTO room(id, smoke, room_type_name)
VALUES (401, N'Có', 'SGL');
INSERT INTO room(id, smoke, room_type_name)
VALUES (402, N'Không', 'TWN');
INSERT INTO room(id, smoke, room_type_name)
VALUES (403, N'Có', 'DBL');
INSERT INTO room(id, smoke, room_type_name)
VALUES (404, N'Không', 'TRPL');
INSERT INTO room(id, smoke, room_type_name)
VALUES (405, N'Có', 'SGL');
INSERT INTO room(id, smoke, room_type_name)
VALUES (406, N'Có', 'SGL');
INSERT INTO room(id, smoke, room_type_name)
VALUES (407, N'Có', 'TWN');
INSERT INTO room(id, smoke, room_type_name)
VALUES (501, N'Có', 'SGL');
INSERT INTO room(id, smoke, room_type_name)
VALUES (502, N'Không', 'TWN');
INSERT INTO room(id, smoke, room_type_name)
VALUES (503, N'Có', 'DBL');
INSERT INTO room(id, smoke, room_type_name)
VALUES (504, N'Có', 'TRPL');
INSERT INTO room(id, smoke, room_type_name)
VALUES (505, N'Không', 'TWN');
INSERT INTO room(id, smoke, room_type_name)
VALUES (601, N'Không', 'SGL');
INSERT INTO room(id, smoke, room_type_name)
VALUES (602, N'Không', 'TWN');
INSERT INTO room(id, smoke, room_type_name)
VALUES (603, N'Không', 'DBL');

SELECT * FROM reserved_room;
/* Insert data bảng reserved_room */
INSERT INTO reserved_room(id, number_of_rooms, reservation_id, room_type_name)
VALUES (1, 2, 1, 'SGL');
INSERT INTO reserved_room(id, number_of_rooms, reservation_id, room_type_name)
VALUES (2, 1, 1, 'TWN');
INSERT INTO reserved_room(id, number_of_rooms, reservation_id, room_type_name)
VALUES (3, 1, 2, 'DBL');
INSERT INTO reserved_room(id, number_of_rooms, reservation_id, room_type_name)
VALUES (4, 1, 3, 'SGL');
INSERT INTO reserved_room(id, number_of_rooms, reservation_id, room_type_name)
VALUES (5, 1, 4, 'TRPL');
INSERT INTO reserved_room(id, number_of_rooms, reservation_id, room_type_name)
VALUES (6, 2, 5, 'SGL');
INSERT INTO reserved_room(id, number_of_rooms, reservation_id, room_type_name)
VALUES (7, 1, 6, 'TRPL');
INSERT INTO reserved_room(id, number_of_rooms, reservation_id, room_type_name)
VALUES (8, 1, 7, 'SGL');
INSERT INTO reserved_room(id, number_of_rooms, reservation_id, room_type_name)
VALUES (9, 1, 8, 'TWN');
INSERT INTO reserved_room(id, number_of_rooms, reservation_id, room_type_name)
VALUES (10, 1, 9, 'SGL');
INSERT INTO reserved_room(id, number_of_rooms, reservation_id, room_type_name)
VALUES (11, 1, 10, 'SGL');
INSERT INTO reserved_room(id, number_of_rooms, reservation_id, room_type_name)
VALUES (12, 1, 10, 'DBL');
INSERT INTO reserved_room(id, number_of_rooms, reservation_id, room_type_name)
VALUES (13, 1, 10, 'TRPL');
INSERT INTO reserved_room(id, number_of_rooms, reservation_id, room_type_name)
VALUES (14, 1, 11, 'TWN');
INSERT INTO reserved_room(id, number_of_rooms, reservation_id, room_type_name)
VALUES (15, 1, 12, 'TRPL');
INSERT INTO reserved_room(id, number_of_rooms, reservation_id, room_type_name)
VALUES (16, 1, 13, 'DBL');
INSERT INTO reserved_room(id, number_of_rooms, reservation_id, room_type_name)
VALUES (17, 1, 13, 'SGL');
INSERT INTO reserved_room(id, number_of_rooms, reservation_id, room_type_name)
VALUES (18, 1, 14, 'TWN');
INSERT INTO reserved_room(id, number_of_rooms, reservation_id, room_type_name)
VALUES (19, 1, 14, 'SGL');
INSERT INTO reserved_room(id, number_of_rooms, reservation_id, room_type_name)
VALUES (20, 1, 15, 'TRPL');
INSERT INTO reserved_room(id, number_of_rooms, reservation_id, room_type_name)
VALUES (21, 1, 16, 'DBL');
INSERT INTO reserved_room(id, number_of_rooms, reservation_id, room_type_name)
VALUES (22, 1, 16, 'SGL');
INSERT INTO reserved_room(id, number_of_rooms, reservation_id, room_type_name)
VALUES (23, 1, 17, 'SGL');
INSERT INTO reserved_room(id, number_of_rooms, reservation_id, room_type_name)
VALUES (24, 1, 18, 'DBL');
INSERT INTO reserved_room(id, number_of_rooms, reservation_id, room_type_name)
VALUES (25, 1, 19, 'TWN');
INSERT INTO reserved_room(id, number_of_rooms, reservation_id, room_type_name)
VALUES (26, 1, 19, 'DBL');
INSERT INTO reserved_room(id, number_of_rooms, reservation_id, room_type_name)
VALUES (27, 1, 20, 'SGL');
INSERT INTO reserved_room(id, number_of_rooms, reservation_id, room_type_name)
VALUES (28, 1, 20, 'TWN');

SELECT * FROM occupied_room;
/* Insert data bảng occupied_room */
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (1, 101, 1);
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (2, 201, 1);
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (3, 102, 1);
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (4, 103, 2);
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (5, 301, 3);
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (6, 104, 4);
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (7, 401, 5);
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (8, 405, 5);
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (9, 105, 6);
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (10, 406, 7);
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (11, 202, 8);
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (12, 501, 9);
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (13, 601, 10);
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (14, 203, 10);
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (15, 204, 10);
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (16, 302, 11);
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (17, 205, 12);
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (18, 303, 13);
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (19, 101, 13);
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (20, 201, 14);
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (21, 102, 14);
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (22, 206, 15);
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (23, 301, 16);
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (24, 103, 16);
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (25, 401, 17);
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (26, 403, 18);
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (27, 402, 19);
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (28, 503, 19);
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (29, 405, 20);
INSERT INTO occupied_room(id, room_id, reservation_id)
VALUES (30, 602, 20);

SELECT * FROM hosted_at;
/* Insert data bảng hosted_at */
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (1, 1, 1);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (2, 2, 2);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (3, 3, 3);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (4, 3, 4);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (5, 4, 5);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (6, 4, 6);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (7, 5, 7);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (8, 6, 8);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (10, 6, 10);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (11, 7, 11);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (12, 8, 12);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (13, 9, 13);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (14, 9, 14);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (15, 9, 15);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (16, 10, 16);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (17, 11, 17);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (18, 11, 18);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (19, 12, 19);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (20, 13, 20);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (21, 14, 21);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (22, 14, 22);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (23, 15, 23);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (24, 15, 24);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (25, 15, 25);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (26, 16, 26);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (27, 16, 27);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (28, 17, 28);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (29, 17, 29);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (30, 17, 30);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (31, 18, 1);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (32, 18, 3);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (33, 19, 4);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (34, 20, 7);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (35, 21, 12);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (36, 21, 14);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (37, 22, 2);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (38, 22, 5);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (39, 22, 6);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (40, 23, 8);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (41, 24,	11);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (42,	24,	13);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (43,	25,	9);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (44,	26,	10);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (45,	26,	15);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (46,	27,	20);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (47,	27,	26);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (48,	28,	27);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (49,	28,	30);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (50,	29,	25);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (51,	30,	28);
INSERT INTO hosted_at(id, occupied_room_id, guest_id)
VALUES (52,	30,	29);

SELECT * FROM service;
/* Insert data bảng service */
INSERT INTO service(id, name, price, department_id)
VALUES (1, N'Dọn phòng', 0, 2);
INSERT INTO service(id, name, price, department_id)
VALUES (2, N'Giặt ủi quần áo', 50000, 2);
INSERT INTO service(id, name, price, department_id)
VALUES (3, N'Buffet', 60000, 3);
INSERT INTO service(id, name, price, department_id)
VALUES (4, N'Đưa đón khách', 100000, 7);

SELECT * FROM used_service;
/* Insert data bảng used_service */
INSERT INTO used_service(id, guest_id, service_id, date_use)
VALUES (1, 1, 2, '2022-02-20');
INSERT INTO used_service(id, guest_id, service_id, date_use)
VALUES (2, 1, 4, '2022-02-23');
INSERT INTO used_service(id, guest_id, service_id, date_use)
VALUES (3, 3, 1, '2022-02-21');
INSERT INTO used_service(id, guest_id, service_id, date_use)
VALUES (4, 4, 1, '2022-02-22');
INSERT INTO used_service(id, guest_id, service_id, date_use)
VALUES (5, 4, 3, '2022-02-23');
INSERT INTO used_service(id, guest_id, service_id, date_use)
VALUES (6, 4, 4, '2022-02-23');
INSERT INTO used_service(id, guest_id, service_id, date_use)
VALUES (7, 10, 2, '2022-02-24');
INSERT INTO used_service(id, guest_id, service_id, date_use)
VALUES (8, 15, 1, '2022-02-26');
INSERT INTO used_service(id, guest_id, service_id, date_use)
VALUES (9, 15, 2, '2022-02-26');
INSERT INTO used_service(id, guest_id, service_id, date_use)
VALUES (10, 17, 3, '2022-03-01');
INSERT INTO used_service(id, guest_id, service_id, date_use)
VALUES (11, 18, 4, '2022-02-26');
INSERT INTO used_service(id, guest_id, service_id, date_use)
VALUES (12, 20, 1, '2022-03-02');
INSERT INTO used_service(id, guest_id, service_id, date_use)
VALUES (13, 22, 3, '2022-03-03');
INSERT INTO used_service(id, guest_id, service_id, date_use)
VALUES (14, 24, 3, '2022-03-04');
INSERT INTO used_service(id, guest_id, service_id, date_use)
VALUES (15, 26, 1, '2022-03-02');
INSERT INTO used_service(id, guest_id, service_id, date_use)
VALUES (16, 26, 3, '2022-03-02');
INSERT INTO used_service(id, guest_id, service_id, date_use)
VALUES (17, 26, 4, '2022-03-02');
INSERT INTO used_service(id, guest_id, service_id, date_use)
VALUES (18, 28, 3, '2022-03-06');
INSERT INTO used_service(id, guest_id, service_id, date_use)
VALUES (19, 29, 4, '2022-03-03');
INSERT INTO used_service(id, guest_id, service_id, date_use)
VALUES (20, 30, 1, '2022-03-05');

--------------------------------------------------
/* Change */
DELETE FROM reserved_room;
DELETE FROM hosted_at;
DELETE FROM occupied_room;
DELETE FROM reservation;
DELETE FROM used_service;

ALTER TABLE reservation
DROP COLUMN payment_type;

ALTER TABLE reservation
ADD payment_type_id INT;

CREATE TABLE payment_type(
	id INT primary key,
	name NVARCHAR(30)
);


ALTER TABLE reservation
ADD FOREIGN KEY (payment_type_id) REFERENCES payment_type(id);

ALTER TABLE used_service
ADD payment_type_id INT;

ALTER TABLE used_service
ADD FOREIGN KEY (payment_type_id) REFERENCES payment_type(id);

CREATE TABLE payment_type
(
	id INT PRIMARY KEY,
	name NVARCHAR(100)
);

/* Insert data bảng payment_type (insert mới) */
INSERT INTO payment_type (id, name) VALUES ('1', N'Tiền mặt');
INSERT INTO payment_type (id, name) VALUES ('2', N'Ví điện tử');
INSERT INTO payment_type (id, name) VALUES ('3', N'Thẻ');
INSERT INTO payment_type (id, name) VALUES ('4', N'Séc trực tuyến');
INSERT INTO payment_type (id, name) VALUES ('5', N'Chuyển khoản');
INSERT INTO payment_type (id, name) VALUES ('6', N'Cổng điện tử');

/* Insert data bảng used_service (insert mới) */
INSERT INTO used_service(id, guest_id, service_id, date_use, payment_type_id)
VALUES (1, 1, 2, '2022-02-20', 1);
INSERT INTO used_service(id, guest_id, service_id, date_use, payment_type_id)
VALUES (2, 1, 4, '2022-02-23', 4);
INSERT INTO used_service(id, guest_id, service_id, date_use, payment_type_id)
VALUES (3, 3, 1, '2022-02-21', 3);
INSERT INTO used_service(id, guest_id, service_id, date_use, payment_type_id)
VALUES (4, 4, 1, '2022-02-22', 2);
INSERT INTO used_service(id, guest_id, service_id, date_use, payment_type_id)
VALUES (5, 4, 3, '2022-02-23', 6);
INSERT INTO used_service(id, guest_id, service_id, date_use, payment_type_id)
VALUES (6, 4, 4, '2022-02-23', 5);
INSERT INTO used_service(id, guest_id, service_id, date_use, payment_type_id)
VALUES (7, 10, 2, '2022-02-24', 3);
INSERT INTO used_service(id, guest_id, service_id, date_use, payment_type_id)
VALUES (8, 15, 1, '2022-02-26', 6);
INSERT INTO used_service(id, guest_id, service_id, date_use, payment_type_id)
VALUES (9, 15, 2, '2022-02-26', 1);
INSERT INTO used_service(id, guest_id, service_id, date_use, payment_type_id)
VALUES (10, 17, 3, '2022-03-01', 2);
INSERT INTO used_service(id, guest_id, service_id, date_use, payment_type_id)
VALUES (11, 18, 4, '2022-02-26', 5);
INSERT INTO used_service(id, guest_id, service_id, date_use, payment_type_id)
VALUES (12, 20, 1, '2022-03-02', 4);
INSERT INTO used_service(id, guest_id, service_id, date_use, payment_type_id)
VALUES (13, 22, 3, '2022-03-03', 2);
INSERT INTO used_service(id, guest_id, service_id, date_use, payment_type_id)
VALUES (14, 24, 3, '2022-03-04', 5);
INSERT INTO used_service(id, guest_id, service_id, date_use, payment_type_id)
VALUES (15, 26, 1, '2022-03-02', 3);
INSERT INTO used_service(id, guest_id, service_id, date_use, payment_type_id)
VALUES (16, 26, 3, '2022-03-02', 4);
INSERT INTO used_service(id, guest_id, service_id, date_use, payment_type_id)
VALUES (17, 26, 4, '2022-03-02', 6);
INSERT INTO used_service(id, guest_id, service_id, date_use, payment_type_id)
VALUES (18, 28, 3, '2022-03-06', 1);
INSERT INTO used_service(id, guest_id, service_id, date_use, payment_type_id)
VALUES (19, 29, 4, '2022-03-03', 2);
INSERT INTO used_service(id, guest_id, service_id, date_use, payment_type_id)
VALUES (20, 30, 1, '2022-03-05', 4);

/* Insert data bảng reservation (insert mới) */
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type_id, guest_id, employee_id)
VALUES (1, '2022-02-20', '2022-02-23', N'Trực tiếp', 1, 1, 1);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type_id, guest_id, employee_id)
VALUES (2, '2022-02-20', '2022-02-23', N'Điện thoại', 2, 5, 2);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type_id, guest_id, employee_id)
VALUES (3, '2022-02-21', '2022-02-25', N'Email', 3, 7, 3);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type_id, guest_id, employee_id)
VALUES (4, '2022-02-23', '2022-02-24', N'Online', 4, 8, 4);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type_id, guest_id, employee_id)
VALUES (5, '2022-02-23', '2022-02-27', N'Điện thoại', 5, 11, 5);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type_id, guest_id, employee_id)
VALUES (6, '2022-02-25', '2022-02-26', N'Email', 6, 13, 4);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type_id, guest_id, employee_id)
VALUES (7, '2022-02-26', '2022-03-01', N'Trực tiếp', 4, 16, 7);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type_id, guest_id, employee_id)
VALUES (8, '2022-02-26', '2022-03-03', N'Online', 5, 17, 1);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type_id, guest_id, employee_id)
VALUES (9, '2022-02-28', '2022-03-04', N'Điện thoại', 6, 19, 7);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type_id, guest_id, employee_id)
VALUES (10, '2022-03-02', '2022-03-04', N'Điện thoại', 2, 20, 2);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type_id, guest_id, employee_id)
VALUES (11, '2022-03-02', '2022-03-02', N'Email', 3, 26, 3);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type_id, guest_id, employee_id)
VALUES (12, '2022-03-03', '2022-03-06', N'Online', 4, 28, 4);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type_id, guest_id, employee_id)
VALUES (13, '2022-03-04', '2022-03-05', N'Điện thoại', 5, 1, 5);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type_id, guest_id, employee_id)
VALUES (14, '2022-03-08', '2022-03-09', N'Email', 3, 7, 3);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type_id, guest_id, employee_id)
VALUES (15, '2022-03-08', '2022-03-10', N'Trực tiếp', 3, 2, 7);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type_id, guest_id, employee_id)
VALUES (16, '2022-03-08', '2022-03-10', N'Online', 5, 8, 1);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type_id, guest_id, employee_id)
VALUES (17, '2022-03-09', '2022-03-09', N'Online', 6, 9, 2);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type_id, guest_id, employee_id)
VALUES (18, '2022-03-11', '2022-03-14', N'Điện thoại', 2, 10, 5);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type_id, guest_id, employee_id)
VALUES (19, '2022-03-12', '2022-03-14', N'Trực tiếp', 3, 20, 4);
INSERT INTO reservation(id, date_in, date_out, made_by, payment_type_id, guest_id, employee_id)
VALUES (20, '2022-03-13', '2022-03-14', N'Online', 2, 25, 1);

/*
Insert data bảng reserved_room --> phần insert cũ
Insert data bảng occupied_room --> phần insert cũ
Insert data bảng hosted_at --> phần insert cũ
*/

------------------------------------------------


SELECT * FROM payment_type

