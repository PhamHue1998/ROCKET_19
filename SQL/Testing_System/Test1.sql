DROP DATABASE IF EXISTS `Students_manage`;

CREATE DATABASE IF NOT EXISTS `Students_manage`;

-- Sử dụng database
USE `Students_manage`;

 -- student 
CREATE TABLE `student`(
	`ID`   int NOT NULL AUTO_INCREMENT,
	`Name` varchar(50) NOT NULL,
	`Age` INT NOT NULL,
    `Gender` BIT DEFAULT NULL,
	PRIMARY KEY (`ID`)
);


-- Subject
 CREATE TABLE `subject`(
	`ID`   int NOT NULL AUTO_INCREMENT,
	`Name` varchar(50) NOT NULL,
	PRIMARY KEY (`ID`)
);

-- StudentSubject
 CREATE TABLE `studentsubject`(
	`StudentID`   int NOT NULL ,
    `SubjectID`   int NOT NULL ,
	`Mark` FLOAT NOT NULL,
    `Date` Date ,
	 CONSTRAINT PK_St_Sub PRIMARY KEY (StudentID,SubjectID),
     
	CONSTRAINT fk_student
	FOREIGN KEY (`StudentID`)
	REFERENCES `student` (`ID`),
    
    CONSTRAINT fk_subject
	FOREIGN KEY (`subjectID`)
	REFERENCES `subject` (`ID`)
);

-- Table Department
INSERT INTO student VALUES	(1,'Nguyễn Văn Nam',20,b'1'),
							(2,'Trần Văn Tiến',20,b'1'),
							(3,'Lê Thị Hà',21,b'0'),
							(4,'Phạm Thị Dung',20,b'0'),
							(5,'Nguyễn Văn Duc',20,b'1'),
                            (6,'Nguyễn Văn Dat',20,NULL);
			
INSERT INTO subject VALUES	(1,'Toán'),
							(2,'Lí'),
							(3,'Hóa'),
							(4,'Sinh'),
							(5,'Sủ'),
                            (6,'Địa');

INSERT INTO studentsubject VALUES	(1,1,6,'2021-1-1'),
(1,2,6,'2021-1-1'),(1,3,7,'2021-1-1'),(1,4,6.4,'2021-1-1'),(2,1,6,'2021-1-1'),(2,2,6,'2021-1-1');

							
-- Lấy tất cả môn học không có bất kì điểm nào
SELECT s.Name, Mark
FROM `subject` s LEFT JOIN studentsubject st_sj 
ON s.ID = st_sj.SubjectID 
GROUP BY s.Name 
HAVING Mark IS NULL;


-- lấy danh sách môn học có ít nhất 2 điểm
SELECT s.Name, st_sj.subjectID, COUNT(st_sj.SubjectID) AS diem
FROM `subject` s JOIN studentsubject st_sj 
ON s.ID = st_sj.SubjectID 
GROUP BY s.Name 
HAVING COUNT(st_sj.SubjectID) >= 2;

-- 
-- 3. Tạo view có tên là "StudentInfo" lấy các thông tin về học sinh bao gồm:
-- Student ID,Subject ID, Student Name, Student Age, Student Gender,
-- Subject Name, Mark, Date
-- (Với cột Gender show 'Male' để thay thế cho 0, 'Female' thay thế cho 1 và
-- 'Unknow' thay thế cho null)

DROP VIEW IF EXISTS v_StudenInfo;
CREATE VIEW v_StudenInfo AS
		SELECT st.ID AS stID,sub.ID AS subID,st.Name AS stNAme,st.Age,sub.Name AS subName,ss.Mark,ss.Date,
        CASE  
			WHEN Gender= 1 THEN 'Female'
			WHEN Gender= 0 THEN 'Male'
			ELSE 'Unknow'
		END AS Gender
        FROM student st 
        LEFT JOIN studentsubject ss ON st.ID = ss.StudentID
        LEFT JOIN subject sub ON sub.ID = ss.SubjectID;
        
SELECT * FROM v_StudenInfo;


-- 4. Không sử dụng On Update Cascade & On Delete Cascade
-- a) Tạo trigger cho table Subject có tên là SubjectUpdateID:
-- Khi thay đổi data của cột ID của table Subject, thì giá trị tương
-- ứng với cột SubjectID của table StudentSubject cũng thay đổi theo

DROP TRIGGER IF EXISTS SubjectUpdateID;
DELIMITER $$
	CREATE TRIGGER SubjectUpdateID
    BEFORE UPDATE ON `subject`
    FOR EACH ROW
    BEGIN
		UPDATE `studentsubject` SET `SubjectID` = new.ID WHERE `SubjectID` = OLD.ID;  
	END $$
DELIMITER ;

begin work;
UPDATE `students_manage`.`subject` SET `ID` = 50 WHERE (`ID` = '4');
rollback;

-- b) Tạo trigger cho table Student có tên là StudentDeleteID:
-- Khi xóa data của cột ID của table Student, thì giá trị tương ứng với
-- cột SubjectID của table StudentSubject cũng bị xóa theo

DROP TRIGGER IF EXISTS StudentDeleteID;
DELIMITER $$
	CREATE TRIGGER StudentDeleteID
    BEFORE DELETE ON `subject`
    FOR EACH ROW
    BEGIN
		DELETE FROM `StudentSubject` WHERE (`SubjectID` = OLD.ID); 
	END $$
DELIMITER ;

begin work;
DELETE FROM `subject` WHERE (`ID` = '4');
rollback;


-- 5. Viết 1 store procedure (có 2 parameters: student name) sẽ xóa tất cả các
-- thông tin liên quan tới học sinh có cùng tên như parameter
-- Trong trường hợp nhập vào student name = "*" thì procedure sẽ xóa tất cả
-- các học sinh

DELIMITER $$
CREATE PROCEDURE sp_delInfoStudent(IN v_StudentName VARCHAR(50))
BEGIN
    IF v_StudentName != '*' THEN
		DELETE FROM student WHERE `Name` = v_StudentName;
	ELSE
		DELETE FROM student;
    END IF;
    END $$
    
DELIMITER ;

begin work;
Call sp_delInfoStudent('*');
rollback;
