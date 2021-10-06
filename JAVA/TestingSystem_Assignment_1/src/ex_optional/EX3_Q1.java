package ex_optional;

import java.text.DateFormat;
import java.util.List;
import java.util.Locale;

import data.TestingSystemData;
import entity.Exam;

public class EX3_Q1 {

	public static List<Exam> listEx;
	public static void main(String[] args) {
		TestingSystemData tData = new TestingSystemData();
		//listEx.addAll(tData.listExam);
		
//		for (Exam ex : tData.listExam) {
//			System.out.println(ex.toString());
//		}
	
//		Locale locale = new Locale("vn", "VN");
//		DateFormat dateFormat = DateFormat.getDateInstance(DateFormat.DEFAULT, locale);
//		String date = dateFormat.format(listEx.get(0).createDate);
//		
//		System.out.println(listEx.get(0).id + ", "+date);
		
		tData.test();
	}
}