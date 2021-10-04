package entity;

import java.time.LocalDate;
import java.util.Arrays;

public class Account {
	public int id;
	public String email;
	public String userName;
	public String fullName;
	public Department department;
	public Position position;
	public LocalDate createDate;
	public Group[] groups;

	public Account() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Account(int id, String email, String userName, String fullName, Department department, Position position,
			LocalDate createDate, Group[] groups) {
		super();
		this.id = id;
		this.email = email;
		this.userName = userName;
		this.fullName = fullName;
		this.department = department;
		this.position = position;
		this.createDate = createDate;
		this.groups = groups;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public Position getPosition() {
		return position;
	}

	public void setPosition(Position position) {
		this.position = position;
	}

	public LocalDate getCreateDate() {
		return createDate;
	}

	public void setCreateDate(LocalDate createDate) {
		this.createDate = createDate;
	}

	public Group[] getGroups() {
		return groups;
	}

	public void setGroups(Group[] groups) {
		this.groups = groups;
	}

	@Override
	public String toString() {
		return "AccountID : " + id + "\n" + "Email: " + email + "\n" + "UserName: " + userName + "\n" + "FullName: "
				+ fullName + "\n" + "Department: " + department.name + "\n" + "Position: " + position.name + "\n"
				+ "Group: " + Arrays.toString(groups) + "\n" + "CreateDate: " + createDate;
	}

	public void print() {
		System.out.println("Id: " + id + "\n" + "FullName: " + fullName + "\n" + "Email: " + email);
	}

	public void print1() {
		System.out.printf("%15s | %15s | %15s | %15s\n",id,email,userName,fullName);

	}
}
