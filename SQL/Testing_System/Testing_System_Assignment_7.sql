-- Exercise 1: Tiếp tục với Database Testing System
-- Question 1: Tạo trigger không cho phép người dùng nhập vào Group có ngày tạo
-- trước 1 năm trước
DROP TRIGGER IF EXISTS tg_insertGroup;
DELIMITER $$
	CREATE TRIGGER tg_insertGroup
    BEFORE INSERT ON `group`
    FOR EACH ROW
    BEGIN
		DECLARE v_cd DATE;
        SET v_cd = DATE_SUB(now(), interval 1 year);
		IF (NEW.CreateDate <= v_cd) THEN
			SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'khong tao duoc';
		END IF;
	END$$
DELIMITER ;

INSERT INTO `group` (`GroupName`, `CreatorID`, `CreateDate`) 
VALUES ('abc', '3', '2019-11-1');

-- Question 2: Tạo trigger Không cho phép người dùng thêm bất kỳ user nào vào
-- department "Sale" nữa, khi thêm thì hiện ra thông báo "Department
-- "Sale" cannot add more user"

DROP TRIGGER IF EXISTS tg_notAddUserToDep;

DELIMITER $$
	CREATE TRIGGER tg_notAddUserToDep
    BEFORE INSERT ON `account`
    FOR EACH ROW
    BEGIN 
		DECLARE v_departmentID INT;
        SELECT d.DepartmentID INTO v_departmentID 
        FROM department d
        WHERE d.DepartmentName = 'IT';
        
        IF(NEW.DepartmentID = v_departmentID) THEN
			SIGNAL SQLSTATE '12346'
            SET MESSAGE_TEXT = 'Cant add more User to Sale Department';

		END IF;
END$$
DELIMITER ;
		
INSERT INTO `testing_system_assignment_1`.`account` (`Email`, `Username`, `Fullname`, `DepartmentID`, `PositionID`, `CreateDate`) 
VALUES ('kimhue@gmail2.com', 'kimhue', 'Pham thi Kim Hue', '3', '1', '2020-1-1');


-- Question 3: Cấu hình 1 group có nhiều nhất là 5 user
DROP TRIGGER IF EXISTS tg_CheckAccountInGroup;
DELIMITER $$
	CREATE TRIGGER tg_CheckAccountInGroup
    BEFORE INSERT ON `groupaccount`
    FOR EACH ROW
    BEGIN
		DECLARE v_CountGroupID INT;
        SELECT count(ga.GroupID) INTO v_CountGroupID
        FROM `groupaccount` ga
        WHERE ga.GroupID = NEW.GroupID;
        IF(v_CountGroupID > 5) THEN 
			SIGNAL SQLSTATE '12345'
			SET MESSAGE_TEXT = 'Cant add more User to This Group';
		END IF;
    END $$
    DELIMITER ;

INSERT INTO `groupaccount` (`GroupID`, `AccountID`, `JoinDate`)
VALUES (1, 1,'2020-05-2');

-- Question 4: Cấu hình 1 bài thi có nhiều nhất là 10 Question
DROP TRIGGER IF EXISTS tg_CheckQuestion;
DELIMITER $$
	CREATE TRIGGER tg_CheckQuestion
    BEFORE INSERT ON `examquestion`
    FOR EACH ROW
    BEGIN
		DECLARE v_QuestionID INT;
        SELECT count(eq.ExamID) INTO v_QuestionID
        FROM `examquestion` eq
        WHERE eq.ExamID = NEW.ExamID;
        IF(v_QuestionID > 10) THEN 
			SIGNAL SQLSTATE '12345'
			SET MESSAGE_TEXT = 'Qua 10 cau trong de thi';
		END IF;
    END $$
    DELIMITER ;

INSERT INTO `examquestion`(`ExamID`, `QuestionID`) VALUES (2, 8);


-- Question 5: Tạo trigger không cho phép người dùng xóa tài khoản có email là
-- admin@gmail.com (đây là tài khoản admin, không cho phép user xóa),
-- còn lại các tài khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông
-- tin liên quan tới user đó

DROP TRIGGER IF EXISTS tg_delete_account;
DELIMITER $$
	CREATE TRIGGER  tg_delete_account
	BEFORE DELETE ON `account`
	FOR EACH ROW
	BEGIN
	DECLARE v_Email VARCHAR(50);
	SET v_Email = 'admin@gmail.com';
	IF (OLD.Email = v_Email) THEN

	SIGNAL SQLSTATE '12345'
	SET MESSAGE_TEXT = 'This User Admin, U cant delete it!!';

	END IF;
	END $$
DELIMITER ;
DELETE FROM account A WHERE A.Email = 'admin@gmail.com';
DELETE FROM account A WHERE A.Email = 'ngoc@gmail.com';

-- Question 6: Không sử dụng cấu hình default cho field DepartmentID của table
-- Account, hãy tạo trigger cho phép người dùng khi tạo account không điền
-- vào departmentID thì sẽ được phân vào phòng ban "waiting Department"
DROP TRIGGER IF EXISTS tg_SetDepWaittingRoom;
DELIMITER $$
CREATE TRIGGER tg_SetDepWaittingRoom
BEFORE INSERT ON `account`

FOR EACH ROW
BEGIN
DECLARE v_WaittingRoom VARCHAR(50);
SELECT D.DepartmentID INTO v_WaittingRoom FROM department D WHERE
D.DepartmentName = 'Phòng Chờ';

IF (NEW.DepartmentID IS NULL ) THEN
SET NEW.DepartmentID = v_WaittingRoom;

END IF;
END $$
DELIMITER ;

SET FOREIGN_KEY_CHECKS=0;
INSERT INTO `account` (`Email`, `Username`, `FullName`, `PositionID`,`CreateDate`)
VALUES ('test@gmail.com','test', 'test', '7', '2017-1-15');



-- Question 7: Cấu hình 1 bài thi chỉ cho phép user tạo tối đa 4 answers cho mỗi
-- question, trong đó có tối đa 2 đáp án đúng.
DROP TRIGGER IF EXISTS tg_SetMax4Answer;
DELIMITER $$
CREATE TRIGGER tg_SetMax4Answer
BEFORE INSERT ON `answer`
FOR EACH ROW
BEGIN

	DECLARE v_CountAnsInQUes INT;
	DECLARE v_CountAns INT;
    
	-- dem cau tra loi trong 1 cau hoi 
	SELECT count(A.QuestionID) INTO v_CountAnsInQUes 
	FROM answer A 
	WHERE A.QuestionID = NEW.QuestionID;
    
    -- dem cau tra loi dung 
	SELECT count(1) INTO v_CountAns
    FROM answer A WHERE A.QuestionID = NEW.QuestionID AND A.isCorrect = 1;
    
	IF (v_CountAnsInQUes > 4 ) OR (v_CountAns >2) THEN

	SIGNAL SQLSTATE '12345'
	SET MESSAGE_TEXT = 'Cant insert more data pls check again!!';

	END IF;
END $$
DELIMITER ;
INSERT INTO `answer` (`Content`, `QuestionID`, `isCorrect`) VALUES ('QA', '1',1);


-- Question 8: Viết trigger sửa lại dữ liệu cho đúng:
-- Nếu người dùng nhập vào gender của account là nam, nữ, chưa xác định
-- Thì sẽ đổi lại thành M, F, U cho giống với cấu hình ở database
DROP TRIGGER IF EXISTS tg_GenderFromInput;
DELIMITER $$
CREATE TRIGGER tg_GenderFromInput
BEFORE INSERT ON `Account`
FOR EACH ROW
BEGIN
IF NEW.Gender = 'Nam' THEN
SET NEW.Gender = 'M';
ELSEIF NEW.Gender = 'Nu' THEN
SET NEW.Gender = 'F';
ELSEIF NEW.Gender = NULL THEN
SET NEW.Gender = 'U';
END IF ;
END $$
DELIMITER ;
INSERT INTO `testing_system_assignment_1`.`account` (`Email`, `Username`, `Fullname`, `DepartmentID`, `PositionID`, `CreateDate`,`Gender`) VALUES ('a@gmail.com', 'abc', 'abc', '2', '2', '2020-1-1','Nam');




-- Question 9: Viết trigger không cho phép người dùng xóa bài thi mới tạo được 2 ngày
DROP TRIGGER IF EXISTS tg_DelExam;
DELIMITER $$
CREATE TRIGGER tg_DelExam
BEFORE DELETE ON `exam`
FOR EACH ROW
BEGIN
DECLARE v_CreateDate DATETIME;
SET v_CreateDate = DATE_SUB(NOW(),INTERVAL 2 DAY);
IF (OLD.CreateDate > v_CreateDate) THEN
SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'Khong dc xoa !!';
END IF ;
END $$
DELIMITER ;
DELETE FROM exam E WHERE E.ExamID =12;

-- Question 10: Viết trigger chỉ cho phép người dùng chỉ được update, delete các
-- question khi question đó chưa nằm trong exam nào
DROP TRIGGER IF EXISTS tg_DelQues;
DELIMITER $$
CREATE TRIGGER tg_DelQues
BEFORE UPDATE ON `question`
FOR EACH ROW
BEGIN
	DECLARE v_CountQuesByID INT;
	SET v_CountQuesByID = 0;
	SELECT count(ex.QuestionID) INTO v_CountQuesByID 
    FROM examquestion ex 
	WHERE ex.QuestionID = NEW.QuestionID;
	IF (v_CountQuesByID > 0) THEN
		SIGNAL SQLSTATE '12345'
		SET MESSAGE_TEXT = 'khong update dc';
	END IF ;
END $$
DELIMITER ;

UPDATE `question` SET `Content` = 'New Question' WHERE (`QuestionID` = '1');


-- delete

DROP TRIGGER IF EXISTS Trg_CheckBefDeleteQues;
DELIMITER $$
CREATE TRIGGER Trg_CheckBefDeleteQues

BEFORE DELETE ON `question`
FOR EACH ROW
BEGIN
	DECLARE v_CountQuesByID INT;
	SET v_CountQuesByID = 0;
	SELECT count(1) INTO v_CountQuesByID 
	FROM examquestion ex
	WHERE ex.QuestionID = OLD.QuestionID;
    
	IF (v_CountQuesByID > 0) THEN
	SIGNAL SQLSTATE '12345'
	SET MESSAGE_TEXT = 'k xoa dc';
END IF ;
END $$
DELIMITER ;
DELETE FROM `question` WHERE (`QuestionID` = 18);

 
-- Question 12: Lấy ra thông tin exam trong đó:
-- Duration <= 30 thì sẽ đổi thành giá trị "Short time"
-- 30 < Duration <= 60 thì sẽ đổi thành giá trị "Medium time"
-- Duration > 60 thì sẽ đổi thành giá trị "Long time"

SELECT *, 
(CASE WHEN Duration <= 30 THEN 'Short time'
	 WHEN Duration <= 60 THEN 'Medium time'
	 ELSE 'Longtime'
END) AS Colum
FROM exam;

-- Question 13: Thống kê số account trong mỗi group và in ra thêm 1 column nữa có tên
-- là the_number_user_amount và mang giá trị được quy định như sau:
-- Nếu số lượng user trong group =< 5 thì sẽ có giá trị là few
-- Nếu số lượng user trong group <= 20 và > 5 thì sẽ có giá trị là normal
-- Nếu số lượng user trong group > 20 thì sẽ có giá trị là higher

SELECT ga.GroupID, g.GroupName, COUNT(ga.GroupID),
CASE
WHEN COUNT(GA.GroupID) <= 5 THEN 'few'
WHEN COUNT(GA.GroupID) <= 20 THEN 'normal'
ELSE 'higher'
END AS 'the_number_user_amount'
FROM groupaccount ga
RIGHT JOIN `group` g USING(GroupID)
GROUP BY ga.GroupID;

-- Question 14: Thống kê số mỗi phòng ban có bao nhiêu user, nếu phòng ban nào
-- không có user thì sẽ thay đổi giá trị 0 thành "Không có User"
SELECT d.DepartmentName, CASE
WHEN COUNT(A.DepartmentID) = 0 THEN 'Không có User'
ELSE COUNT(A.DepartmentID)
END AS resul
FROM department D
LEFT JOIN account A ON D.DepartmentID = A.DepartmentID
GROUP BY d.DepartmentID;