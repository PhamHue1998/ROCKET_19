DROP DATABASE IF EXISTS `Testing_System_Assignment_1`;
-- Tạo CSDL
CREATE DATABASE IF NOT EXISTS `Testing_System_Assignment_1`;

-- Sử dụng database
USE `Testing_System_Assignment_1`;

--
-- Bảng Department
--
CREATE TABLE `department`(
	`DepartmentID`   int NOT NULL AUTO_INCREMENT,
	`DepartmentName` varchar(50) NOT NULL,
	PRIMARY KEY (`DepartmentID`)
);

--
-- Bảng Position
--
CREATE TABLE `position`(
	`PositionID` 	int NOT NULL AUTO_INCREMENT,
	`PositionName` 	ENUM('Dev1', 'Dev2', 'Test', 'Scrum Master', 'PM'),
	PRIMARY KEY (`PositionID`)
);

--
-- Bảng Account
--
	CREATE TABLE `account`(
	`AccountID` 	int NOT NULL AUTO_INCREMENT,
	`Email` 		varchar(50) UNIQUE,
	`Username` 		varchar(50) NOT NULL,
	`Fullname` 		varchar(50),
	`DepartmentID` 	INT NOT NULL,
	`PositionID` 	INT NOT NULL,
	`CreateDate` 	DATE,
	PRIMARY KEY (`AccountID`),

	CONSTRAINT fk_acc_dp
	FOREIGN KEY (`DepartmentID`)
	REFERENCES `department` (`DepartmentID`),

	CONSTRAINT fk_acc_pos
	FOREIGN KEY (`PositionID`)
	REFERENCES `position` (`PositionID`)
	);

	--
	-- Table Group
	--
	CREATE TABLE `group`(
	`GroupID` 	int NOT NULL AUTO_INCREMENT,
	`GroupName` varchar(50) NOT NULL,
	`CreatorID` 	int NOT NULL,
	`CreateDate` DATE,
	PRIMARY KEY (`GroupID`),
	CONSTRAINT fk_gr_acc
	FOREIGN KEY (`CreatorID`)
	REFERENCES `account`(`AccountID`)
);

--
-- Table GroupAccount
--
CREATE TABLE `GroupAccount`(
	`GroupID` 	int NOT NULL,
	`AccountID` int NOT NULL,
	`JoinDate` 	DATETIME DEFAULT NOW(),

	CONSTRAINT fk_groupaccount_gr
	FOREIGN KEY (`GroupID`)
	REFERENCES `group` (`groupID`),

	CONSTRAINT fk_groupaccount_acc
	FOREIGN KEY (`AccountID`)
	REFERENCES `account` (`AccountID`)
);

--
-- Bảng TypeQuestion
--
CREATE TABLE `TypeQuestion`(
	`TypeID` 	int NOT NULL AUTO_INCREMENT,
	`TypeName` 	ENUM ('Essay','Multiple-Choice'),
	PRIMARY KEY (`TypeID`)
);

--
-- Bảng CategoryQuestion
--
CREATE TABLE `CategoryQuestion`(
	`CategoryID`   int NOT NULL AUTO_INCREMENT,
	`CategoryName` ENUM ('Java', 'SQL', '.NET', 'Ruby', 'Python', 'NodeJS' , 'HTML', 'CSS', 'JavaScript'),
	PRIMARY KEY (`CategoryID`)
);

--
-- Bảng Question
--
CREATE TABLE `Question`(
	`QuestionID` int NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`Content`    VARCHAR(50),
	`CategoryID` int NOT NULL,
	`TypeID`     int NOT NULL,
	`CreatorID`  int NOT NULL,
	`CreateDate` DATE,
	CONSTRAINT fk_q1 FOREIGN KEY (`CreatorID`) REFERENCES `Account` (`AccountID`),
	CONSTRAINT fk_q2 FOREIGN KEY (`CategoryID`) REFERENCES `CategoryQuestion` (`CategoryID`),
	CONSTRAINT fk_q3 FOREIGN KEY (`TypeID`) REFERENCES `TypeQuestion` (`TypeID`) 
);

--
-- Bảng Answer
--
CREATE TABLE IF NOT EXISTS `Answer`(
	`AnswerID`   INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`Content`    VARCHAR(50),
	`QuestionID` INT NOT NULL,
	`isCorrect`  BIT,
	 CONSTRAINT fk_ans_ques FOREIGN KEY (`QuestionID`) 
	 REFERENCES `Question` (`QuestionID`)  ON DELETE CASCADE 
);

--
-- Bảng Exam
--
CREATE TABLE `Exam`(
	`ExamID`   	 INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`Code`       VARCHAR(10) NOT NULL,
	`Title`      VARCHAR(50) NOT NULL,
	`CategoryID` INT NOT NULL,
	`Duration`   FLOAT,
	`CreatorID`  INT NOT NULL,
	`CreateDate` DATE,
	CONSTRAINT fk_ex_acc FOREIGN KEY (`CreatorID`)
	REFERENCES `account`(`AccountID`),
	CONSTRAINT fk_ex_cate FOREIGN KEY (`CategoryID`) 
	REFERENCES `CategoryQuestion` (`CategoryID`)  
);

--
-- Bảng ExamQuestion
--
CREATE TABLE `ExamQuestion`(
	`ExamID`   	 INT NOT NULL,
	`QuestionID` INT NOT NULL,
	CONSTRAINT fk_eq1 FOREIGN KEY (`ExamID`)
	REFERENCES `Exam`(`ExamID`)  ON DELETE CASCADE,
	CONSTRAINT fk_eq2 FOREIGN KEY (`QuestionID`) 
	REFERENCES `Question`(`QuestionID`)
    -- dữ liệu bảng examquestion bị thay đổi nếu xóa bảng exam 
    ON DELETE CASCADE 
);


-- ********************************************* THÊM GIÁ TRỊ CHO BẢNG ************************************************ 

-- Table Department
INSERT INTO department VALUES	(1,'Marketing'),
								(2,'Sale'),
                                (3,'IT'),
                                (4,'HR'),
                                (5,'Customer Service'),
                                (6,'MK1'),
                                (7,'MK2');


-- Table Position
INSERT INTO position VALUES	(1,'Dev1'),
							(2,'Dev2'),
							(3,'Test'),
							(4,'Scrum Master'),
							(5,'PM');
                                
-- Table Account
INSERT INTO account VALUES 	(1,'an@gmail.com','an','Nguyễn Văn An',3,1,'2018-1-1'),
							(2,'ho@gmail.com','ho','Do Van Ho',3,1,'2018-1-5'),
                            (3,'ha@gmail.com','ha','Lê Thị Hà',3,2,'2018-5-1'),
							(4,'phi@gmail.com','phi','Đoàn Bảo Phi',3,2,'2019-3-1'),
                            (5,'trang@gmail.com','trang','Trần Thị Huyền Trang',3,2,'2019-1-1'),
							(6,'hong@gmail.com','hong','Vũ Thị Hồng',4,4,'2019-1-1'),
                            (7,'dat@gmail.com','dat','Nguyễn Văn Đạt',4,4,'2018-1-1'),
							(8,'anhdao@gmail.com','dao','Ngô Thị Anh Đào',3,5,'2020-7-2'),
                            (9,'manh@gmail.com','manh','Nguyễn Văn Tiến Mạnh',3,1,'2020-3-2'),
							(10,'dao@gmail.com','abc','Dao',2,5,'2020-5-23'),
                            (11,'mi@gmail.com','trami','Chu Thị Huyền Trà Mi',4,1,'2021-1-1'),
                            (12,'ngoc@gmail.com','ngoc','Phạm Thị Ngọc',2,3,'2021-1-1');
						
						
                        
-- Table Group
INSERT INTO `group` VALUES 	(1,'nhóm 1',1,'2019-2-2'),
							(2,'nhóm 2',3,'2018-8-8'),
							(3,'nhóm 3',5,'2019-5-4'),
							(4,'nhóm 4',4,'2020-5-4'),
							(5,'nhóm 5',4,'2020-5-4'),
							(6,'nhóm 6',4,'2020-3-3'),
							(7,'nhóm 7',4,'2020-9-7'),
							(8,'nhóm 8',7,'2021-1-4');
                            
-- Table GroupAccount
INSERT INTO `groupaccount` VALUES	(1,2,'2019-4-5'),
									(1,6,'2019-3-5'),
									(1,8,'2019-4-8'),
									(2,9,'2019-5-5'),
									(2,8,'2019-5-5'),
									(3,10,'2020-10-12'),
									(4,1,'2021-10-2'),
                                    (4,2,'2021-10-3'),
                                    (4,3,'2021-10-4'),
                                    (4,4,'2021-11-5'),
                                    (4,5,'2021-12-6'),
                                    (4,6,'2021-9-7'),
									(5,6,'2021-10-20'),
									(5,8,'2021-10-7');
								
                                
-- Table TypeQuestion
INSERT INTO `typequestion` VALUES	(1,'Essay'),
									(2,'Multiple-Choice');


        
-- Table CategoryQuestion
INSERT INTO `categoryquestion` VALUES (1,'Java'),
									  (2,'SQL'),
									  (3,'.NET'),
									  (4,'Ruby'),
									  (5,'HTML'),
									  (6,'NodeJS'),
									  (7,'JavaScript');
                                      
-- Table Question
INSERT INTO `question` VALUES  	(1,'Câu hỏi 1',1,1,4,'2020-2-3'),
								(2,'Câu hỏi 2',2,1,4,'2020-2-3'),
								(3,'Câu hỏi 3',2,2,3,'2020-2-3'),
								(4,'Câu hỏi 4',1,1,3,'2020-2-3'),
								(5,'Q5',2,1,4,'2020-2-5'),
								(6,'Q6',3,2,4,'2020-6-9'),
								(7,'Q7',4,1,4,'2020-12-22'),
								(8,'Q8',3,2,5,'2020-9-5'),
								(9,'Q9',3,1,5,'2020-2-8'),
								(10,'Q10',5,1,4,'2020-7-21');
                            
                            
-- Table Answer
 INSERT INTO `answer` VALUES  (1,'Đáp án 1',1,0), 
                              (2,'Đáp án 2',1,1),
                              (3,'Đáp án 3',2,1),
                              (4,'Đáp án 4',3,0),
                              (5,'Đáp án 5',4,0),
                              (6,'Đáp án 6',5,0),
                              (7,'Đáp án 7',6,0),
                              (8,'Đáp án 8',7,1),
                              (9,'Đáp án 9',8,1),
                              (10,'Đáp án 10',9,0),
                              (11,'Đáp án 11',1,1),
                              (12,'Đáp án 12',1,1),
                              (13,'Đáp án 13',1,0),
							  (14,'Đáp án 14',2,1),
                              (15,'Đáp án 15',2,1),
                              (16,'Đáp án 16',2,0);
 
 -- Table Exam
  INSERT INTO `exam` VALUES (1,'1001','Java Basic',1,45,2,'2019-8-19'), 
							(2,'1002','Java Core',1,60,3,'2020-12-30'),
							(3,'1003','SQL',2,50,4,'2019-7-30'),
							(4,'1004','C#',3,60,4,'2020-12-7'),
							(5,'1005','Winform',3,60,6,'2019-12-30'),
							(6,'1006','HTML tag',5,15,5,'2019-5-30'),
							(7,'1007','OOP in Java',1,30,3,'2020-12-12'),
							(8,'1008','C# Basic',3,120,3,'2019-09-02'),
                            (9,'1009','Entity FrameWork',3,80,3,'2019-2-3');
                            
 -- Table ExamQuestion
  INSERT INTO `examquestion` VALUES (1,1),
									(1,4),
									(1,2),
									(1,6),
									(1,7),
									(2,1),
									(2,2),
									(2,3),
									(2,5),
									(2,6),
									(2,7),
									(3,1),
									(3,2),
									(3,6),
									(3,7),
									(3,8),
									(3,9),
									(4,7),
									(4,1),
									(4,6),
									(4,7),
									(4,2),
                                    (5,1),
									(5,2),
									(5,6),
									(5,10);
								
                                    
                                      
/*
==================================================================================================================
============================================ TRUY VẤN CƠ BẢN =====================================================
==================================================================================================================
*/


-- Tạo 1 File SQL đặt tên là "Testing_System_Assignment_4"
-- Tiếp tục với Database Testing System
-- Exercise 1: Join
-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT a.AccountID, a.Email,a.Fullname,d.DepartmentName
FROM `account` a right join `department` d on a.DepartmentID = d.DepartmentID
ORDER BY AccountID ASC;

-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2019
SELECT * FROM `account`
WHERE CreateDate > '2019-12-20';

-- Question 3: Viết lệnh để lấy ra tất cả các developer
SELECT FullName, PositionName
FROM `position` JOIN `account` ON position.PositionID = account.PositionID
WHERE PositionName LIKE 'Dev%'
ORDER BY position.PositionID;

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT d.DepartmentID, d.DepartmentName,COUNT(AccountID) AS SoLuong
FROM `department` d JOIN `account` a ON d.DepartmentID = a.DepartmentID
GROUP BY d.departmentID
HAVING SoLuong > 3;

-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
/*
	1. Đếm số lượng câu hỏi trong bảng examquestion & group theo cau hỏi (QuestionID)
    2. Lấy Max trong (1)
    3. Tìm danh sách câu hỏi với đk số lượng bằng = max
*/ 

SELECT  e.QuestionID, q.Content,COUNT( e.QuestionID) AS SoLuong
FROM question q JOIN examquestion e ON q.QuestionID = e.QuestionID
GROUP BY e.QuestionID
HAVING COUNT( e.QuestionID) =(SELECT MAX(SL) FROM (SELECT COUNT(e.QuestionID) AS SL
												  FROM examquestion e
												  GROUP BY e.QuestionID) AS newTable);
                                                  

-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
SELECT c.CategoryName, COUNT(q.CategoryID) AS SoLuong
FROM categoryquestion c LEFT JOIN question q USING(CategoryID)
GROUP BY c.CategoryName;

-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
SELECT q.QuestionID, q.Content, COUNT(eq.QuestionID) AS SL
FROM question q RIGHT JOIN examquestion eq USING(QuestionID)
GROUP BY q.QuestionID;


-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
/*
	Tìm tổng câu trả lời mỗi câu hỏi
    Tìm Max
*/
SELECT q.Content, COUNT(a.QuestionID) AS SoLuong
FROM question q JOIN answer a USING(QuestionID)
GROUP BY q.QuestionID
HAVING COUNT(a.QuestionID) = (SELECT MAX(SL) FROM (SELECT COUNT(a.QuestionID) AS SL FROM answer a GROUP BY a.QuestionID) AS newTable);


-- Question 9: Thống kê số lượng account trong mỗi group
SELECT g.GroupName, COUNT(ga.AccountID) AS SL
FROM groupaccount ga JOIN `group` g USING(GroupID)
GROUP BY ga.GroupID;

-- Question 10: Tìm chức vụ có ít người nhất
SELECT p.PositionName, COUNT(a.PositionID)
FROM position p JOIN account a USING(PositionID)
GROUP BY p.PositionName
HAVING  COUNT(a.PositionID) = (SELECT MIN(SL) FROM (SELECT COUNT(a.PositionID) AS SL FROM account a GROUP BY a.PositionID) newTable);


-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT t.DepartmentName, t.PositionName, COUNT(a.UserName) AS SoLuong
FROM Account a
RIGHT JOIN (SELECT * FROM department CROSS JOIN position) AS t
ON (a.DepartmentID = t.DepartmentID AND a.PositionID = t.PositionID)
GROUP BY  t.DepartmentID, t.PositionID
ORDER BY t.DepartmentID, t.PositionID;
 


-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của
-- question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ...
SELECT q.Content, tq.TypeName, a.Fullname, an.Content
FROM question q
JOIN typequestion tq USING(TypeID)
JOIN account a ON q.CreatorID = a.AccountID
JOIN answer an USING(QuestionID);

-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT tq.TypeName, COUNT(q.TypeID) AS SL
FROM typequestion tq JOIN question q USING(TypeID)
GROUP BY tq.TypeID;

-- Question 14:Lấy ra group không có account nào
SELECT g.GroupName
FROM `group` g LEFT JOIN groupaccount ga USING(GroupID)
WHERE ga.AccountID IS NULL;

-- Question 15: Lấy ra group không có account nào
SELECT * FROM `Group`
WHERE GroupID NOT IN (SELECT GroupID
FROM GroupAccount);

-- Question 16: Lấy ra question không có answer nào
SELECT QuestionID, Content
FROM question
WHERE QuestionID NOT IN 
(SELECT QuestionID
FROM answer
GROUP BY QuestionID);



-- Exercise 2: Union
-- Question 17:
-- a) Lấy các account thuộc nhóm thứ 1
SELECT a.FullName FROM `account` a
JOIN groupaccount ga USING(AccountID)
WHERE ga.GroupID = 1;

-- b) Lấy các account thuộc nhóm thứ 2
SELECT a.FullName FROM `account` a
JOIN groupaccount ga USING(AccountID)
WHERE ga.GroupID = 2;

-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
SELECT a.FullName FROM `account` a
JOIN groupaccount ga USING(AccountID)
WHERE ga.GroupID = 1
UNION
SELECT a.FullName FROM `account` a
JOIN groupaccount ga USING(AccountID)
WHERE ga.GroupID = 2;

-- Question 18:
-- a) Lấy các group có lớn hơn 5 thành viên
SELECT g.GroupName, COUNT(ga.GroupID) AS SoLuong
FROM GroupAccount ga
JOIN `Group` g USING(GroupID)
GROUP BY g.GroupID
HAVING COUNT(ga.GroupID) > 5;
-- b) Lấy các group có nhỏ hơn 7 thành viên
SELECT g.GroupName, COUNT(ga.GroupID) AS SoLuong
FROM GroupAccount ga
JOIN `Group` g USING(GroupID)
GROUP BY g.GroupID
HAVING COUNT(ga.GroupID) < 7;

-- c) Ghép 2 kết quả từ câu a) và câu b)
SELECT g.GroupName, COUNT(ga.GroupID) AS SoLuong
FROM GroupAccount ga
JOIN `Group` g USING(GroupID)
GROUP BY g.GroupID
HAVING COUNT(ga.GroupID) > 5
UNION
SELECT g.GroupName, COUNT(ga.GroupID) AS SoLuong
FROM GroupAccount ga
JOIN `Group` g USING(GroupID)
GROUP BY g.GroupID
HAVING COUNT(ga.GroupID) < 7;


