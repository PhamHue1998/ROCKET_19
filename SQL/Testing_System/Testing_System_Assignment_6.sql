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
	`Gender` 		varchar(50) DEFAULT NULL,
	PRIMARY KEY (`AccountID`),

	CONSTRAINT fk_acc_dp
	FOREIGN KEY (`DepartmentID`)
	REFERENCES `department` (`DepartmentID`) ON DELETE CASCADE ,

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
                                (7,'MK2'),
                                (8,'Phòng Chờ');


-- Table Position
INSERT INTO position VALUES	(1,'Dev1'),
							(2,'Dev2'),
							(3,'Test'),
							(4,'Scrum Master'),
							(5,'PM');
                                
-- Table Account
INSERT INTO account VALUES 	(1,'an@gmail.com','an','Nguyễn Văn An',3,1,'2018-1-1','Nam'),
							(2,'ho@gmail.com','ho','Do Van Ho',3,1,'2018-1-5','Nam'),
                            (3,'ha@gmail.com','ha','Lê Thị Hà',3,2,'2018-5-1','Nu'),
							(4,'phi@gmail.com','phi','Đoàn Bảo Phi',3,2,'2019-3-1','Nam'),
                            (5,'trang@gmail.com','trang','Trần Thị Huyền Trang',3,2,'2019-1-1','Nu'),
							(6,'hong@gmail.com','hong','Vũ Thị Hồng',4,4,'2019-1-1','Nu'),
                            (7,'dat@gmail.com','dat','Nguyễn Văn Đạt',4,4,'2018-1-1','Nam'),
							(8,'anhdao@gmail.com','dao','Ngô Thị Anh Đào',3,5,'2020-7-2','Nu'),
                            (9,'manh@gmail.com','manh','Nguyễn Văn Tiến Mạnh',3,1,'2020-3-2',NULL),
							(10,'dao@gmail.com','abc','Dao',2,5,'2020-5-23',NULL),
                            (11,'mi@gmail.com','trami','Chu Thị Huyền Trà Mi',4,1,'2021-1-1',NULL),
                            (12,'admin@gmail.com','admin','ad',5,1,'2021-1-1',NULL),
                            (13,'ngoc@gmail.com','ngoc','Phạm Thị Ngọc',2,3,'2021-1-1',NULL);
						
						
                        
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
								(14,'Q14',5,1,9,'2021-10-21'),
								(15,'Q15',5,1,1,'2021-9-21'),
								(16,'Q15',5,1,1,'2021-9-11'),
								(17,'Q15',5,1,1,'2021-9-20');
                            
                            
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
                            (9,'1009','Entity FrameWork',3,80,3,'2018-2-3'),
                            (10,'1009','Entity FrameWork',3,80,3,'2018-2-3'),
                            (11,'1009','Entity FrameWork',3,80,3,'2017-2-3');
                            
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

USE  `testing_system_assignment_1`;
-- Exercise 1: Tiếp tục với Database Testing System
-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó
DROP PROCEDURE IF EXISTS `getAccount`;
DELIMITER $$
CREATE PROCEDURE `getAccount`(IN depName NVARCHAR(50))
BEGIN
	SELECT a.AccountID, a.FullName,d.DepartmentName
	FROM account a JOIN department d USING(DepartmentID)
	WHERE d.DepartmentName = depName;
END$$
DELIMITER ;

Call `getAccount`('Sale');

show procedure status;


-- Question 2: Tạo store để in ra số lượng account trong mỗi group
DROP PROCEDURE IF EXISTS listAccountInGroup;
DELIMITER $$
CREATE PROCEDURE listAccountInGroup(IN grName NVARCHAR(50))
BEGIN
	SELECT g.GroupName,Count(ga.AccountID) AS SoLuong 
	FROM `group` g JOIN groupaccount ga USING(GroupID)
	WHERE g.groupNAme = grName;
END$$
DELIMITER ;
Call `listAccountInGroup`('nhóm 1');

-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại
DROP PROCEDURE IF EXISTS countQuestionInMonth;
DELIMITER $$
CREATE PROCEDURE countQuestionInMonth()
BEGIN
	SELECT tq.TypeName, count(q.TypeID) AS SL
    FROM question q
	JOIN typequestion tq USING(TypeID)
	WHERE month(q.CreateDate) = month(now()) AND year(q.CreateDate) = year(now())
	GROUP BY q.TypeID;
END$$
DELIMITER ;
Call  countQuestionInMonth();


-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất

-- sử dụng view 
DROP VIEW IF EXISTS `v_type_questions`;
CREATE OR REPLACE VIEW v_type_questions AS(
			SELECT typeID, Count(*) AS total FROM question q JOIN TypeQuestion tq USING(TypeID) GROUP BY TypeID
		);
SELECT * FROM `v_type_questions`;

DELIMITER $$
CREATE PROCEDURE pr_id_maxCQ(OUT IDQ INT)
BEGIN
		
	   SELECT `TypeID` INTO IDQ
       FROM	v_type_questions WHERE total = (SELECT MAX(total) FROM v_type_questions);

END $$
DELIMITER ;

CALL pr_id_maxCQ(@FF);
SELECT @FF;

-- c2

DROP PROCEDURE IF EXISTS test;
DELIMITER $$
	CREATE PROCEDURE test(Out idQ INT)
	BEGIN
		SELECT TypeID INTO idQ
		FROM typequestion tq JOIN question q USING(TypeID)
		GROUP BY tq.TypeID
		HAVING COUNT(TypeID) = (SELECT MAX(SL) FROM (SELECT COUNT(TypeID) AS SL
									FROM question
									GROUP BY typeID) AS T);
    
    END$$
DELIMITER ;

CALL test(@result);
SELECT @result;
 

-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question
CALL test(@tqID);
SELECT  * FROM typequestion 
WHERE TypeID = @tqID;

-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên
-- chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa
-- chuỗi của người dùng nhập vào
DROP PROCEDURE IF EXISTS `getGNameOrUName`;
DELIMITER $$
CREATE PROCEDURE  `getGNameOrUName`(IN str VARCHAR(50),IN temp INT)
BEGIN
	CASE
		WHEN temp = 1 THEN (SELECT GroupName FROM `group` WHERE GroupName LIKE CONCAT("%",str,"%"));
		ELSE  (SELECT FullName FROM `account` WHERE FullName LIKE CONCAT("%",str,"%"));
	END CASE;
END $$
DELIMITER ;

call `getGNameOrUName`('Nh',0);


-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và
-- trong store sẽ tự động gán:
-- username sẽ giống email nhưng bỏ phần @..mail đi
-- positionID: sẽ có default là developer
-- departmentID: sẽ được cho vào 1 phòng chờ
-- Sau đó in ra kết quả tạo thành công
DROP PROCEDURE IF EXISTS insertAccount;
DELIMITER $$
CREATE PROCEDURE insertAccount(IN v_Email VARCHAR(50), IN v_FullName VARCHAR(50))
	BEGIN 
		DECLARE v_UserName VARCHAR(50) DEFAULT SUBSTRING_INDEX(v_Email,'@',1);
        DECLARE v_DepartmentID INT DEFAULT 8;
        DECLARE v_PositionID INT DEFAULT 1;
        DECLARE v_CreateDate DATETIME DEFAULT now();
        
       INSERT INTO `account` (`Email`, `Username`, `FullName`,`DepartmentID`, `PositionID`, `CreateDate`)
		VALUES (v_Email, v_Username, v_Fullname,v_DepartmentID, v_PositionID, v_CreateDate);
    END $$
DELIMITER ;
Call insertAccount('test@gmail.com','Test');


-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
-- để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất

DROP PROCEDURE IF EXISTS maxContent;
DELIMITER $$
CREATE PROCEDURE maxContent(IN v_Choice VARCHAR(50))
	BEGIN 
		DECLARE v_TypeID INT;
        SELECT typeID INTO v_TypeID
        FROM typequestion
        WHERE TypeName = v_Choice;
        IF v_Choice = 'Essay' THEN 
			WITH CTE_LengContent AS(
				SELECT char_length(Content) AS doDai FROM question 
				WHERE TypeID = v_TypeID)
                
				SELECT * FROM question 
				WHERE TypeID = v_TypeID
				AND char_length(Content) = (SELECT MAX(doDai) FROM CTE_LengContent);
         ELSE
			WITH CTE_LengContent AS(
				SELECT char_length(Content) AS doDai FROM question 
				WHERE TypeID = v_TypeID)
                
				SELECT * FROM question 
				WHERE TypeID = v_TypeID
				AND char_length(Content) = (SELECT MAX(doDai) FROM CTE_LengContent);
         END IF;
    END $$
DELIMITER ;
Call  maxContent('Multiple-Choice');


-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID
DROP PROCEDURE IF EXISTS deleteExam;
DELIMITER $$
CREATE PROCEDURE deleteExam(IN v_ExamID INT)
	BEGIN
		DELETE FROM examquestion WHERE ExamID = v_ExamID;
        DELETE FROM exam WHERE ExamID = v_ExamID;
	END $$
DELIMITER ;
    
Call deleteExam(5);

-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử
-- dụng store ở câu 9 để xóa)
-- Sau đó in số lượng record đã remove từ các table liên quan trong khi
-- removing
DROP PROCEDURE IF EXISTS deleteExamBefore3Year;
DELIMITER $$
CREATE PROCEDURE  deleteExamBefore3Year()
	BEGIN
		DECLARE i INT DEFAULT 1;
        DECLARE countEx INT;
        
        -- Bảng tạm
        CREATE TABLE tbTemp(
			id INT PRIMARY KEY AUTO_INCREMENT,
            idExam INT
        );
        
        
        -- đếm các câu hỏi từ 3 năm trc 
        SELECT COUNT(ExamID) INTO countEx FROM Exam WHERE (year(now()-year(CreateDate)) > 2);
        
        -- set vào bảng tạm 
        INSERT INTO tbTemp(idExam)
        (SELECT ExamID  FROM exam  WHERE (year(now()) - year(createDate)) > 2);
         
         SELECT * FROM tbTemp;
         
         WHILE (i <= countEx) DO
         -- thực hiện xóa  
         SELECT ExamID INTO v_ExamID FROM ExamIDBefore3Year_Temp WHERE ID=i;
		 CALL sp_DeleteExamWithID(v_ExamID);
			Call deleteExam(i);
		-- tăng i++ 
			SET i = i + 1;
         END WHILE;
         
         -- In ra số lượng đã xóa
         SELECT countEx AS 'So luong da xoa';
	END $$
DELIMITER ;

Call deleteExamBefore3Year();

-- Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng
-- nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được
-- chuyển về phòng ban default là phòng ban chờ việc
DROP PROCEDURE IF EXISTS p_deleteDepart;

DELIMITER $$
CREATE PROCEDURE p_deleteDepart(IN in_DepartmentName VARCHAR(50))
BEGIN
UPDATE `account`
SET DepartmentID=0
WHERE DepartmentID=(SELECT DepartmentID
					FROM Department
					WHERE DepartmentName=in_DepartmentName);
DELETE FROM Department
WHERE DepartmentName=in_DepartmentName;
END$$
DELIMITER ;


-- set global log_bin_trust_function_creators = 1;

SET foreign_key_checks = 0;

CALL p_deleteDepart('Sale');






-- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm
-- nay

-- Tạo bảng về tháng (1-12) 
CREATE TABLE monthT(
	id INT PRIMARY KEY
);

INSERT INTO monthT VALUES   (1),(2),
							(3),(4),(5),(6),
							(7),(8),(9),(10),(11),(12);

SELECT* FROM monthT;

DROP VIEW IF EXISTS calender;
CREATE VIEW calender AS (
-- cross join with tb_monthT 
	SELECT id, y FROM monthT CROSS JOIN (
	SELECT DISTINCT year(createDate) AS y FROM question
	) AS T
);

SELECT id AS month, y, COUNT(Content) FROM calender c
LEFT JOIN question q ON year(q.CreateDate) = c.y
AND month(q.CreateDate) = id
WHERE y =year(now())
GROUP BY id
ORDER BY y;



-- Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6
-- tháng gần đây nhất
-- (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong
-- tháng")
DROP PROCEDURE IF EXISTS sp_CountQuestion6Month;
DELIMITER $$
	CREATE PROCEDURE sp_CountQuestion6Month()
    BEGIN
		with cte_6month as
        (
			SELECT month(now()) as m , year(now()) as y
            union
			SELECT month(date_sub(now(), interval 1 month)), year(date_sub(now(), interval 1 month)) as y
            union
			SELECT month(date_sub(now(), interval 2 month)), year(date_sub(now(), interval 2 month)) as y
            union
			SELECT month(date_sub(now(), interval 3 month)), year(date_sub(now(), interval 3 month)) as y
            union
			SELECT month(date_sub(now(), interval 4 month)), year(date_sub(now(), interval 4 month)) as y
            union
			SELECT month(date_sub(now(), interval 5 month)), year(date_sub(now(), interval 5 month)) as y
        )
        select m, y, if (count(questionid) = 0, 'khong co cau nao', count(questionid)) as total
        from cte_6month
		left join question on m = month(createdate) and y = year(createdate)
        group by m, y;
        
    END$$
DELIMITER ;
CALL sp_CountQuestion6Month();




SELECT month(now());
SELECT month(date_sub(now(), interval 1 month));
SELECT month(date_sub(now(), interval 2 month));
SELECT month(date_sub(now(), interval 3 month));
SELECT month(date_sub(now(), interval 4 month));
SELECT month(date_sub(now(), interval 5 month));

