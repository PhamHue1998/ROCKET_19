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




 


