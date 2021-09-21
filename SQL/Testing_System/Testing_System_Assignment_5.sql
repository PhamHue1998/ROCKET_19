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
	`Content`    VARCHAR(100),
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
								(8,'Q8',3,2,1,'2020-9-5'),
								(9,'Q9',3,1,5,'2020-2-8'),
								(10,' Sự khác nhau giữa UNIQUE và PRIMARY KEY constraints là gì?',5,1,9,'2020-7-21'),
								(11,'Sự khác nhau giữa mệnh đề Having và mệnh đề Where?',5,1,4,'2020-7-21'),
								(12,'Sự khác nhau giữa UNIQUE và PRIMARY KEY constraints là gì?',5,1,1,'2020-7-21'),
								(13,'Q10',5,1,4,'2020-7-21'),
								(14,'Q14',5,1,9,'2020-7-21'),
								(15,'Q15',5,1,1,'2020-7-21');
                            
                            
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
								
/*===================================================================================================================*/ 
/*=======================================CTE AND VIEW ===============================================================*/ 
/*===================================================================================================================*/                                  



-- Chú ý: Tạo 1 File SQL đặt tên là "Testing_System_Assignment_5"
-- Exercise 1: Tiếp tục với Database Testing System
-- (Sử dụng subquery hoặc CTE)
/*===================================================================================================================*/ 
/*===================================================================================================================*/ 
/*===================================================================================================================*/ 

-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
DROP VIEW IF EXISTS `list_employee_sale`;
CREATE VIEW `list_employee_sale` AS
	SELECT a.FullName, d.DepartmentName
    FROM `account` a JOIN  department d USING(DepartmentID)
    WHERE DepartmentName LIKE 'Sale';
    
SELECT * FROM `list_employee_sale`;
    
-- CTE:
 WITH `emp_sale` AS(
 SELECT a.FullName, d.DepartmentName
    FROM `account` a JOIN  department d USING(DepartmentID)
    WHERE DepartmentName LIKE 'Sale'
 )    
SELECT * FROM emp_sale;
-- **************************************************************************************************
-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
/*
	Lấy ra ds tổng các group của từng account , nhóm theo AccountID
    Tìm Max
    Lấy thông tin các account = max
*/
DROP VIEW IF EXISTS `list_account`;
CREATE VIEW  `list_account` AS 
	SELECT a.*, COUNT(ga.GroupID) AS SoLuongThamGia
    FROM `account` a JOIN `groupaccount` ga USING(AccountID)
    GROUP BY a.AccountID
    HAVING COUNT(ga.GroupID) = (SELECT MAX(SL) FROM (SELECT COUNT(GroupID) AS SL FROM groupaccount GROUP BY AccountID) AS T);

SELECT * FROM `list_employee_sale`;

-- CTE: 

WITH `tb_account` AS(
	SELECT a.*, COUNT(ga.GroupID) AS SoLuongThamGia
    FROM `account` a JOIN `groupaccount` ga USING(AccountID)
    GROUP BY a.AccountID
    HAVING COUNT(ga.GroupID) = (SELECT MAX(SL) FROM (SELECT COUNT(GroupID) AS SL FROM groupaccount GROUP BY AccountID) AS T)
)
SELECT * FROM `tb_account`;

-- **************************************************************************************************
-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ
-- được coi là quá dài) và xóa nó đi
DROP VIEW IF EXISTS `view_content_50`;
CREATE OR REPLACE VIEW `view_content_50` AS
SELECT * FROM Question
WHERE LENGTH(Content) > 50 ;

-- trước khi xóa
SELECT *FROM question;
SELECT *FROM `view_content_50`;

DELETE FROM `view_content_50`;
-- sau khi xóa
SELECT *FROM question;


-- **************************************************************************************************
-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
DROP VIEW IF EXISTS `view_deparment`;
CREATE OR REPLACE VIEW `view_deparment` AS
	SELECT d.DepartmentName, COUNT(a.DepartmentID)
    FROM department d JOIN account a USING(DepartmentID)
    GROUP BY d.DepartmentName
	HAVING COUNT(a.DepartmentID) = (SELECT MAX(SL) FROM (SELECT COUNT(DepartmentID) AS SL
									FROM account
									GROUP BY DepartmentID) AS T);
                                    
SELECT * FROM `view_deparment`;
	
 -- **************************************************************************************************   
-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
DROP VIEW IF EXISTS `view_question`;
CREATE OR REPLACE VIEW `view_question` AS
	SELECT q.*, a.Fullname
    FROM question q JOIN `account` a ON q.CreatorID = a.AccountID
    WHERE Fullname LIKE 'Nguyễn%';
    
SELECT * FROM `view_question`;
