package data;

import java.time.LocalDate;
import java.time.Month;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import entity.Account;
import entity.Department;
import entity.Group;
import entity.Position;
import entity.Position.PositionName;

public class TestingSystemData {
	public List<Account> listAccount;
	public List<Position> listPosition;
	public List<Department> listDepartment;
	public List<Group> listGroup;

	// Khởi tạo data
	public TestingSystemData() {
		// Create Group
		Group group1 = new Group(1, "G1");
		Group group2 = new Group(2, "G2");
		Group group3 = new Group(3, "G3");
		Group group4 = new Group(4, "G4");

		// Array Group
		Group[] groupArr1 = { group1, group2, group3 };
		Group[] groupArr2 = { group2, group3 };
		Group[] groupArr3 = { group1, group3 };
		Group[] groupArr4 = { group1, group2 };

		// Create Department
		Department dep1 = new Department(1, "Sale");
		Department dep2 = new Department(2, "Marketing");
		Department dep3 = new Department(3, "IT");
		Department dep4 = new Department(4, "HR");
		listDepartment = new ArrayList<>(Arrays.asList(dep1, dep2, dep3, dep4));

		// Create Position
		Position pos1 = new Position(1, PositionName.DEV);
		Position pos2 = new Position(2, PositionName.PM);
		Position pos3 = new Position(3, PositionName.TEST);

		// Create Account
		Account ac1 = new Account(1, "ac1@gmail.com", "A", "Nguyen Van A", dep1, pos1,
				LocalDate.of(2018, Month.MAY, 15), groupArr1);
		Account ac2 = new Account(2, "ac2@gmail.com", "B", "Nguyen Van B", dep2, pos2,
				LocalDate.of(2019, Month.MAY, 16), groupArr2);
		Account ac3 = new Account(3, "ac3@gmail.com", "C", "Nguyen Van C", dep3, pos3,
				LocalDate.of(2021, Month.MAY, 19), groupArr3);
		listAccount = new ArrayList<>(Arrays.asList(ac1, ac2, ac3));
		// listAccount.add()

		// add Accounts to Group
		group1.accounts = new Account[] { ac1, ac2, ac3 };
		group2.accounts = new Account[] { ac2 };
		group3.accounts = new Account[] { ac1, ac3 };
		group4.accounts = new Account[] {};

		// add Group to List
		listGroup = new ArrayList<Group>(Arrays.asList(group1, group2, group3, group4));
	}

//	Question 1
	public void checkAccount2() {
		System.out.println(" --------------Q1--------------");
		if (listAccount.get(1).department == null)
			System.out.println("Nhân viên này chưa có phòng ban");
		else
			System.out.println("Phòng ban của nv này là: " + listAccount.get(1).department.name);
	}

	// Question 2
	public void checkGroupInAccount2() {
		System.out.println(" --------------Q2--------------");
		// lấy ra độ dài của mảng group[] trong acc
		int count = listAccount.get(1).groups.length;

		if (count == 1 || count == 2) {
			System.out.println("Group của nhân viên này là Java Fresher, C# Fresher");
		} else if (count == 3) {
			System.out.println("Nhân viên này là người quan trọng, tham gia nhiều group");
		} else if (count >= 4) {
			System.out.println("Nhân viên này là người hóng chuyện, tham gia tất cả các group");
		} else {
			System.out.println("Nhân viên  này chưa có group");
		}
	}

	// Question 3
	public void checkAccountWithTernary() {
		System.out.println(" --------------Q3--------------");
		String message = listAccount.get(1).department == null ? "Nhân viên này chưa có phòng ban"
				: "Phòng ban của nv này là: " + listAccount.get(1).department.name;
		System.out.println(message);
	}

	// Question 4
	public void checkPositionInAccountWithTernary() {
		System.out.println(" --------------Q4--------------");
		String msg = listAccount.get(0).position.name.toString() == "DEV" ? "Đây là Developer"
				: "Người này không phải là Developer";
		System.out.println(msg);
	}

	// Question 5
	public void getAccountInGroup() {
		System.out.println(" --------------Q5--------------");
		int cnt = listGroup.get(0).accounts.length;
		switch (cnt) {
		case 0:
			System.out.println("Group chưa có thành viên nào tham gia");
			break;
		case 1:
			System.out.println("Nhóm có một thành viên");
			break;
		case 2:
			System.out.println("Nhóm có hai thành viên");
			break;
		case 3:
			System.out.println("Nhóm có ba thành viên");
			break;
		default:
			System.out.println("Nhóm có nhiều thành viên");
			break;
		}
	}

	// Question 6
	public void checkAccWithCase() {
		System.out.println(" --------------Q6--------------");
		int cnt = listAccount.get(1).groups.length;
		switch (cnt) {
		case 0:
			System.out.println("Nhân viên này chưa có group");
			System.out.println("Group chưa có thành viên nào tham gia");
			break;
		case 1:
		case 2:
			System.out.println("Group của nhân viên này là Java Fresher, C# Fresher");
			break;
		case 3:
			System.out.println("Nhân viên này là người quan trọng, tham gia nhiều group");
			break;
		default:
			System.out.println("Nhân viên này là người hóng chuyện, tham gia tất cả các group");
			break;
		}
	}

	// Question 7
	public void checkPosWithCase() {
		System.out.println(" --------------Q7--------------");
		String posName = listAccount.get(0).position.name.toString();
		switch (posName) {
		case "DEV":
			System.out.println("Đây là developer");
			break;
		default:
			System.out.println("Người này không phải là Developer");
			break;
		}
	}

	// Question 8
	// In ra thông tin các account bao gồm: Email, FullName và tên phòng ban của họ
	public void getInfoAccount() {
		for (Account account : listAccount) {
			account.print();
			System.out.println("-----------------------------------------");
		}
	}

	// Question 9
	// In ra thông tin các phòng ban bao gồm: id vs name
	public void getInfoDep() {
		for (Department department : listDepartment) {
			System.out.println(department.toString());
		}
	}

	// Q10 In thong tin Account
	public void printInforAcc() {
		for (int i = 0; i < listAccount.size(); i++) {
			System.out.println("Thông tin account thứ " + (i + 1) + " là:");
			System.out.println("Email: " + listAccount.get(i).email);
			System.out.println("Full name: " + listAccount.get(i).fullName);
			System.out.println("Phòng ban: " + listAccount.get(i).department.name);
			System.out.println("--------------------------------------------");
		}
	}

	// Q11 In thong tin Department
	public void printInforDep() {
		for (int i = 0; i < listDepartment.size(); i++) {
			System.out.println("Thông tin account thứ " + (i + 1) + " là:");
			System.out.println("ID: " + listDepartment.get(i).id);
			System.out.println("Name: " + listDepartment.get(i).name);
			System.out.println("--------------------------------------------");
		}
	}

	// Q12
	public void print2Department() {
		for (int i = 0; i < 2; i++) {
			System.out.println("Thông tin account thứ " + (i + 1) + " là:");
			System.out.println("ID: " + listDepartment.get(i).id);
			System.out.println("Name: " + listDepartment.get(i).name);
			System.out.println("--------------------------------------------");
		}
	}

	// Q13 In ra thông tin tất cả các account ngoại trừ account thứ 2
	public void printAllExceptAcc2() {
		for (int i = 0; i < listAccount.size(); i++) {
			if (i != 1) {
				System.out.println("Thông tin account thứ " + (i + 1) + " là:");
				System.out.println("Email: " + listAccount.get(i).email);
				System.out.println("Full name: " + listAccount.get(i).fullName);
				System.out.println("Phòng ban: " + listAccount.get(i).department.name);
				System.out.println("--------------------------------------------");
			}
		}
	}

	// Q14 In ra thông tin tất cả các account có id < 4
	public void printAccLessThan4() {
		for (int i = 0; i < listAccount.size(); i++) {
			if (listAccount.get(i).id < 4) {
				System.out.println("Thông tin account thứ " + (i + 1) + " là:");
				System.out.println("Email: " + listAccount.get(i).email);
				System.out.println("Full name: " + listAccount.get(i).fullName);
				System.out.println("Phòng ban: " + listAccount.get(i).department.name);
				System.out.println("--------------------------------------------");
			}
		}
	}

	//EX2-Q6
	public void printTable() {
		System.out.printf("%15s | %15s | %15s | %15s\n","Id","Email","UserName","FullName");
		System.out.printf("%10s--------------------------------------------------------------------\n","");
		for (Account account : listAccount) {
			account.print1();
		}
	}
}
