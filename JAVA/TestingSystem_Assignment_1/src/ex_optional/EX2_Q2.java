package ex_optional;

import java.util.Locale;

public class EX2_Q2 {
	public static void main(String[] args) {
		int a = 1000000000;
		System.out.printf(Locale.GERMAN, "%,d\n", a);
		System.out.println("Alo");
		System.out.printf(Locale.US, "%,d%n", a);
		System.out.println("Alo");
	}
}
