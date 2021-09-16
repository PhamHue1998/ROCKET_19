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
                                (5,'Customer Service');


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
									(3,10,'2020-10-12'),
									(4,1,'2021-10-2'),
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
									  (5,'HTML');
                                      
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
									(2,2),
									(2,3),
									(2,5),
									(3,6),
									(3,8),
									(3,9),
									(4,7),
									(5,10);
								
                                    
                                      
/*
==================================================================================================================
============================================ TRUY VẤN CƠ BẢN =====================================================
==================================================================================================================
*/
                                      
-- lấy ra tất cả các phòng ban
SELECT * FROM department;

-- lấy ra id của phòng ban "Sale"
SELECT DepartmentID FROM department 
WHERE DepartmentName = 'Sale';

-- lấy ra thông tin account có full name dài nhất
SELECT * FROM account
WHERE character_length(FullName) = (SELECT MAX(character_length(FullName)) FROM `account` AS newTable);

-- lấy ra thông tin account có full name dài nhất và thuộc phòng ban id=3
SELECT * FROM account
WHERE character_length(FullName) = (SELECT MAX(character_length(FullName)) FROM `account` AS newTable where DepartmentID = 3) AND DepartmentID = 3;

-- lấy ra tên group đã tham gia trước ngày 20/12/2019
SELECT GroupName
FROM `group`
WHERE CreateDate < '2019-12-20';

-- lấy ra id của question có >= 4 câu trả lời
SELECT QuestionID, COUNT(QuestionID) AS SoLuong
FROM answer
GROUP BY QuestionID
HAVING SoLuong >=4;

-- lấy ra các mã đề thi có thời gian thi >= 60 phút và dc tạo trước ngày 20/12/2019
SELECT Code, Duration, CreateDate
FROM exam
WHERE Duration >= 60 AND CreateDate < '2019-12-20';

-- lấy ra 5 group được tạo gần đây nhất
SELECT * FROM `group`
ORDER BY CreateDate DESC
LIMIT 5;

-- đếm số nhân viên thuộc department có id = 2
SELECT COUNT(DepartmentID) AS soluong
FROM account
WHERE DepartmentID = 2;

-- lấy ra nhân viên có tên bắt đầu bằng chữ 'D' và kết thúc bằng chữ 'o'
SELECT Fullname
FROM `Account`
WHERE (SUBSTRING_INDEX(FullName, ' ', -1)) LIKE 'D%o' ;

-- Xóa tất cả các exam dc tạo trước ngày 20/12/2019
SET SQL_SAFE_UPDATES = 0;
DELETE FROM exam
WHERE CreateDate < '2019-12-20';

-- xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
SET SQL_SAFE_UPDATES = 0;
DELETE FROM question
WHERE Content LIKE 'Câu hỏi%';

-- Update thông tin của account có Id = 5 thành tên "Nguỹen Bá Lộc" và email thành loc.nguyenba@vti.com.vn
SET SQL_SAFE_UPDATES = 0;
UPDATE account
SET FullName = "Nguyễn Bá Lộc", Email= "loc.nguyenba@vti.com.vn"
WHERE AccountID = 5;

-- update thông tin của account id = 5 sẽ thuộc group có id = 4
SET SQL_SAFE_UPDATES = 0;
UPDATE groupaccount
SET GroupID = 4
WHERE AccountID = 5;
									
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
