package ex_optional;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

public class EX2_Q5 {

	public static void main(String[] args) {
		// Khởi tạo ngày giờ hiện tại
		
		//use SimpleDateFormat
		String str  = "dd/MM/yyy HH:mm:ss";
		SimpleDateFormat simpleDate = new SimpleDateFormat(str);
		String date = simpleDate.format(new Date());
		System.out.println(date);
		
		//use Localdate
		LocalDate date1 = LocalDate.now();
		System.out.println(date1);
		
		//use LocalDateTime
		LocalDateTime currentDateTime = LocalDateTime.now();
		System.out.println(currentDateTime);
	}
}
