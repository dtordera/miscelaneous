import java.io.Console;


public class yubotu_main {

	public static void main(String[] args) {			
			
		String[] S = new String[] {
									"     ",
									"     ",
									" V   ",
									"     ",
									"     "
								  };
								  
		int[] SR = new int[] {1,3,0,2,1};
		int[] SC = new int[] {2,1,2,1,1};
		
		int[] M = {3,2,1,1};
		
		grid k = new grid(S,M,SR,SC);
		
		System.out.println();
		
		Resoledor r = new Resoledor(k);
		
		System.out.print(r.toString());
		
		r.resoldre();
		
		System.out.print(r.toString());
		
		SR[3] = 90;
	}
}
