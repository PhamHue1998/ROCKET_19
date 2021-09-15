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
	 REFERENCES `Question` (`QuestionID`) 
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
	REFERENCES `Exam`(`ExamID`),
	CONSTRAINT fk_eq2 FOREIGN KEY (`QuestionID`)
	REFERENCES `Question`(`QuestionID`)
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
                            (11,'mi@gmail.com','trami','Chu Thị Huyền Trà Mi',4,1,'2021-1-1');
						
						
                        
-- Table Group
INSERT INTO `group` VALUES 	(1,'nhóm 1',1,'2019-2-2'),
							(2,'nhóm 2',3,'2018-8-8'),
							(3,'nhóm 3',5,'2019-5-4'),
							(4,'nhóm 4',4,'2020-5-4'),
							(5,'nhóm 5',7,'2021-8-4');
                            
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
                              (10,'Đáp án 10',9,0);
 
 -- Table Exam
  INSERT INTO `exam` VALUES (1,'1001','Java Basic',1,45,2,'2019-8-19'), 
							(2,'1002','Java Core',1,60,3,'2020-12-30'),
							(3,'1003','SQL',2,50,4,'2019-7-30'),
							(4,'1004','C#',3,60,4,'2020-12-7'),
							(5,'1005','Winform',3,60,6,'2019-12-30'),
							(6,'1006','HTML tag',5,15,5,'2019-5-30'),
							(7,'1007','OOP in Java',1,30,3,'2020-12-12');
                            
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
								
                                    
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
