USE qlks1

-- TRUY VẤN 1 BẢNG
-- THÔNG TIN KHÁCH HÀNG
SELECT * FROM guest;
-- THÔNG TIN NHÂN VIÊN
SELECT * FROM employee;
-- THÔNG TIN CÁC LOẠI PHÒNG
SELECT * FROM room_type;

-- KET HOP
-- THỎNG TIN NHÂN VIÊN KÉT HỢP VỚI THÔNG TIN PHÒNG BAN GỒM TÊN PHÒNG BAN VÀ MÃ NHÂN VIÊN QUẢN LÝ
SELECT employee.id as employee_id, CONCAT(first_name,' ' ,last_name) AS full_name, employee.phone, employee.address, employee.gender, department.name AS department_name, department.manager_id 
FROM employee
JOIN department ON employee.department_id = department.id;
-- THÔNG TIN TỪNG PHÒNG KẾT HỢP VỚI THÔNG TIN LOẠI PHÒNG
SELECT id, smoke, room_type_name, description, max_guest, cost_per_day 
FROM room
JOIN room_type on room.room_type_name = room_type.name;
-- THÔNG TIN NGƯỜI ĐẶT PHÒNG KẾT HỢP THÔNG TIN PHÒNG
SELECT hosted_at.id AS hosted_at_id, occupied_room.id AS ocp_id, guest.id AS g_id,CONCAT(first_name,' ' ,last_name) AS full_name , phone, room_id
FROM hosted_at
JOIN occupied_room ON occupied_room.id = hosted_at.occupied_room_id
JOIN guest ON guest.id = hosted_at.guest_id;

-- DIEU KIEN
-- phong ban co sl 5-10 nvien
SELECT id, name, manager_id, employee_quantity
FROM department
JOIN
(SELECT  department_id, COUNT(*) AS employee_quantity 
FROM employee
GROUP BY department_id) AS temp ON temp.department_id = department.id
WHERE employee_quantity >= 5 AND employee_quantity <= 10
;
-- lietke nhung phong cho phep hut thuoc, >1 nguoi 
SELECT id, room_type_name, description, max_guest, cost_per_day 
FROM room 
JOIN room_type ON room.room_type_name = room_type.name
WHERE smoke = 'Có' AND max_guest > 1;
-- liệt kê phòng không hút thuốc
SELECT *
FROM room
WHERE smoke = N'Không';

-- gom nhóm (GROUP BY)
-- số lượng nhân viên của các phòng ban
SELECT name, employee_quantity FROM (SELECT department_id, COUNT(*) AS employee_quantity FROM employee
GROUP BY department_id) AS temp
JOIN department ON temp.department_id = department.id;
-- số lượng nam, nữ nhân viên 
SELECT gender, COUNT(*) AS quantity FROM employee
GROUP BY gender;
-- số lượng các phương thức thanh toán của các giao dịch
SELECT payment_type_id, COUNT(*) quantity FROM reservation
GROUP BY payment_type_id;
-- số lượng các loại phòng của khách sạn
SELECT room_type_name, COUNT(*) AS quantity FROM room
GROUP BY room_type_name;

--  HAVING
-- các phương thức có số lượng sử dụng là 3, 4
SELECT payment_type, COUNT(*) quantity 
FROM reservation
GROUP BY payment_type
HAVING COUNT(*) IN ('3','4');
-- các loại phòng có số lượng phòng không phải là 6
SELECT room_type_name, COUNT(*) AS quantity 
FROM room
GROUP BY room_type_name
HAVING COUNT(*) NOT IN ('6');
-- các phòng ban có số lượng nhân viên > 5
SELECT name, employee_quantity 
FROM 
(SELECT department_id, COUNT(*) AS employee_quantity FROM employee
GROUP BY department_id
HAVING COUNT(*) > 5)
AS temp
JOIN department ON temp.department_id = department.id;

-- Truy vấn có sử dụng phép giao, hội, trừ
-- nhan vien co thuc hien reservation
SELECT temp.id, CONCAT(first_name,' ',last_name) AS full_name FROM employee 
JOIN (
    SELECT id  FROM employee 
    INTERSECT
    SELECT employee_id FROM reservation
    ) AS temp 
    ON temp.id = employee.id
;
-- khách không trực tiếp đặt phòng(người đi cùng đặt)
SELECT id FROM guest
EXCEPT
SELECT guest_id FROM reservation;
-- id các khách thanh toán hóa đơn hoặc sử dụng dịch vụ
SELECT guest_id FROM used_service
UNION
SELECT guest_id FROM reservation
;

-- TRUY VAN CON
-- sdt cua cac khach la NAM lam chu phong`
SELECT phone FROM guest
WHERE id in (SELECT id from hosted_at WHERE gender = 'Nam');
-- thông tin khách hàng sử dụng điện thoại thanh toán giao dịch
SELECT * FROM guest
WHERE id IN (SELECT id from reservation WHERE made_by = N'Điện thoại');
-- thông tin các nhân viên tạo giao dịch cho khách hàng bằng ví điện tử
SELECT * FROM employee
WHERE id IN (SELECT id FROM reservation WHERE payment_type = N'Ví điện tử');

-- TRUY VAN CHEO
-- THÊM KHÁCH HÀNG MỚI
CREATE PROCEDURE setNewGuest (@id int, @first_name NVARCHAR(100), @last_name NVARCHAR(100), @phone VARCHAR(20), @address NVARCHAR(200), gender NVARCHAR(10))
AS
BEGIN
    IF(NOT EXISTS(SELECT id FROM guest WHERE id =@id))
        BEGIN
            PRINT N'Id đã tồn tại';
        END
    ELSE
        BEGIN
            INSERT INTO guest(id, first_name, last_name, phone, address, gender) VALUES (@id, @first_name, @last_name, @phone, @address);
            PRINT N'Thêm khách hàng thành công';
        END
END
-- XÓA KHÁCH HÀNG
CREATE PROCEDURE deleteGuest
-- 
CREATE PROCEDURE setNewReservation (@id int, @first_name NVARCHAR(100), @last_name NVARCHAR(100), @phone VARCHAR(20), @address NVARCHAR(200), gender NVARCHAR(10))
AS
BEGIN
    IF(NOT EXISTS(SELECT id FROM guest WHERE id =@id))
        BEGIN
            PRINT N'Id đã tồn tại';
        END
    ELSE
        BEGIN
            INSERT INTO guest(id, first_name, last_name, phone, address, gender) VALUES (@id, @first_name, @last_name, @phone, @address);
            PRINT N'Thêm khách hàng thành công';
        END
END




SELECT * FROM hosted_at
ORDER BY guest_id aSC

-- 
SELECT * FROM department;
SELECT * FROM employee order BY last_name asc;
SELECT * FROM guest;
SELECT * FROM hosted_at;
SELECT * FROM occupied_room;
SELECT * FROM payment_type;
SELECT * FROM reservation;
SELECT * FROM reserved_room;
SELECT * FROM room;
SELECT * FROM room_type;
SELECT * FROM service;
SELECT * FROM used_service;