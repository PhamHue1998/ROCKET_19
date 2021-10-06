package frontend;

import data.TestingSystemData;


public class Testing_1 {

	// Create Object TestingSystemData
	static TestingSystemData testData = new TestingSystemData();

	public static void main(String[] args) {

		// Q1
		testData.checkAccount2();

		// Q2
		testData.checkGroupInAccount2();

		// Q3
		testData.checkAccountWithTernary();

		// Q4
		testData.checkPositionInAccountWithTernary();

		// Q5
		testData.getAccountInGroup();

		// Q6
		testData.checkAccWithCase();

		//Q7
		testData.checkPosWithCase();
		
		//Q8
		testData.getInfoAccount();
		
		//Q9
		testData.getInfoDep();
		
		//Q10
		testData.printInforAcc();
		
		//Q11
		testData.printInforDep();

		// Q12
		testData.print2Department();

		// Q13
		testData.printAllExceptAcc2();
		
		// Q14
		testData.printAccLessThan4();

		
		//EX2-Q6
		testData.printTable();
		
	}
}
