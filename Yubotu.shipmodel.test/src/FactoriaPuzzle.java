

import java.util.Arrays;
import java.util.Random;

public class FactoriaPuzzle {

	public void Genera(int C,int R,byte[] Ls){
	
		Flota F;
		CondicionsInicials[] CI = new CondicionsInicials[0];		
		Random rnd = new Random();
						
		ResoledorPuzzle RP;
		
		long t1,t2;
		boolean fet = false;
		
		do{
			F = new Flota(C,R,Ls);
						
			RP = new ResoledorPuzzle(F.SR,F.SC,CI,Ls);
			
			t1 = System.currentTimeMillis();
			
			System.out.println("Checking Resol(2)");
			RP.Resol(2);
	
			t1 = System.currentTimeMillis()-t1;
			
			t2 = System.currentTimeMillis();
			
			System.out.println("Checking Resol(1)");			
			RP.Resol(1);
			
			t2 = System.currentTimeMillis()-t2;
						
			fet = t1 < 2*t2;
			 
		}while(!fet);	
		
		System.out.println("Ok");
		
		byte x,y;
		int s;
		
		if (RP.Resol(2)!=1)
		do {								
			x = (byte)rnd.nextInt(C);
			y = (byte)rnd.nextInt(R);
			
			/*if (F.SR[x]!=0&&F.SC[y]!=0&&F.notocavaixell(x,y))
			{*/			
				CI = Arrays.copyOf(CI,CI.length+1);						
				CI[CI.length-1] = new CondicionsInicials(x,y,F.c(x,y));
			
				s = RP.M(CI).Resol(2);
			
				if (s==0) { CI = Arrays.copyOf(CI,CI.length-1); s = 2;}
			/*}
			else
			s=2;*/ 
				
		} while(s!=1);
		
		char bak;
		
		System.out.println("---");
		
		for (int n=0;n<CI.length;n++){
			bak = CI[n].v;
			CI[n].v = K.I;
			
			if (RP.M(CI).Resol(2)!=1) CI[n].v = bak;
		}
		
		char[][] G = new char[C][R];
		
		for (char[] g:G)
		Arrays.fill(g,K.I);
		
		for (CondicionsInicials ci:CI)
			G[ci.x][ci.y] = ci.v;
			
		String r="";
		
		for (byte j=0;j<R;j++) {
		
			for (byte i=0;i<C;i++) 
				r+=G[i][j] + " ";
				
			r += F.SC[j] + "\n";
		}		
		
		r+="\n";
		for (byte i=0;i<C;i++)
			r+=F.SR[i] + " ";
			
		System.out.println(r);		
		
	}
}
