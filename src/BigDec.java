import java.math.BigDecimal;
import java.math.MathContext;

public class BigDec {
	
	public static void main(String [] args){
		
		String initial = "Result: 9.999999999999999999";
		
		String result = initial.substring(7);
		System.out.println("textresult = "+result);
		Double doubled = Double.valueOf(result);
		
		BigDecimal bigD =  new BigDecimal(Math.sqrt(doubled.doubleValue()));
		
		
		System.out.println(bigD);
	}

}
