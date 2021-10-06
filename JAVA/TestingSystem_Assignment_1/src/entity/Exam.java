package entity;

import java.time.LocalDate;
import java.util.Arrays;

public class Exam {
	public int id;
	public String code;
	public String title;
	public CategoryQuestion categoryQuestion;
	public int duration;
	public Account creator;
	public LocalDate createDate;
	public Question[] question;
	
	
	public Exam(int id, String code, String title, CategoryQuestion categoryQuestion, int duration, Account creator,
			LocalDate createDate) {
		super();
		this.id = id;
		this.code = code;
		this.title = title;
		this.categoryQuestion = categoryQuestion;
		this.duration = duration;
		this.creator = creator;
		this.createDate = createDate;
	}


	@Override
	public String toString() {
		return "Exam [id = " + id + ", code = " + code + ", title = " + title + ", categoryQuestion = " + categoryQuestion
				+ ", duration = " + duration + ", creator = " + creator + ", createDate = " + createDate + ", question = "
				+ Arrays.toString(question) + "]";
	}
	
	
}
