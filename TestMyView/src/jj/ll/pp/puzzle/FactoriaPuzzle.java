package jj.ll.pp.puzzle;

import java.util.Arrays;
import java.util.Random;

public class FactoriaPuzzle {
	int C,R;
	int[] B;
	boolean Recursiu;
	long ms;
	
	Random rnd;
	
	public FactoriaPuzzle(int c,int r,int[] b, boolean rec){
	C = c;
	R = r;
	
	rnd = new Random();	
	
	Recursiu = rec;
	B = b.clone();		
	}
	
	public Puzzle Genera(){
		
		CI[] I = new CI[1];
		boolean Totfet = false;
		int i,j;
		int x,y;				
	
		ms = System.currentTimeMillis();	
					
		Puzzle P = new Puzzle(C,R);				
		
		while (!Totfet){
		
			P = new Puzzle(C,R);							
			if (!P.Coloca(B)) {System.out.println("Imposible colocar aquests vaixells");return null;}

			P.recursiu = Recursiu;			
			P.generant = true;			
				
			for (j=0;j<P.R;j++)
				for (i=0;i<P.C;i++)
					if (P.i(i,j)) P.A(i,j);
		
			for (j=0;j<P.R;j++)
				P.SC[j] = P.SC(j);
			
			for (i=0;i<P.C;i++)
				P.SR[i] = P.SR(i);
											
			boolean minimcelles = false;
			while(!minimcelles)
			{										
				x = rnd.nextInt(C);
				y = rnd.nextInt(R);
			
				I[I.length-1] = new CI(x,y,P.v(x,y));
				
				Puzzle R = new Puzzle(P.SR,P.SC,I,B).Resol();		
			
				minimcelles = R.equals(P);					
				if (!minimcelles)  I=Arrays.copyOf(I,I.length+1);
			}		
			
			for (i=0;i<I.length;i++)
			{
				if (I[i].v==K.A&&(P.SR[I[i].i.x]==0||P.SC[I[i].i.y]==0)) I[i]=new CI(-1,-1,K.A);			
						
				CI[] bak = Arrays.copyOf(I,I.length);
				
				I[i]=new CI(-1,-1,K.A);
				
				Puzzle R = new Puzzle(P.SR,P.SC,I,B).Resol();
				
				if (!R.equals(P)) I[i]=bak[i];
			}
			
			Totfet = true;
		}
		
		Puzzle R = new Puzzle(P.SR,P.SC,I,B);
		ms = System.currentTimeMillis() - ms;
		
		System.out.println(ms + "ms");
		
		return R;		
	}
}
