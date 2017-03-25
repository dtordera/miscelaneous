package dvtr.games.logic.BSv10;

import java.util.Arrays;
import java.util.Random;

public class FactoriaPuzzle {
	int C,R;
	int[] B;
	boolean Recursiu;
	
	public FactoriaPuzzle(int c,int r,int[] b, boolean rec){
		C=c;
		R=r;	
		Recursiu=rec;
		B=b.clone();		
	}
	
	public Puzzle Genera(){
		CI[] I = new CI[1];
		Random rnd = new Random();
		byte x,y;
		byte i,j;
		int z;
		
		boolean Totfet = false;

		Puzzle P = new Puzzle(C,R);
				
		long t = System.currentTimeMillis();
		
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
				x = (byte)rnd.nextInt(C);
				y = (byte)rnd.nextInt(R);
			
				I[I.length-1] = new CI(x,y,P.v(x,y));
				
				Puzzle R = new Puzzle(P.SR,P.SC,I,B).Resol();		
			
				minimcelles = R.equals(P);					
				if (!minimcelles) I = Arrays.copyOf(I,I.length+1);
			}		
			
			for (z=0;z<I.length;z++)
			{
				if (I[z].v == K.A&&(P.SR[I[z].i.x]==0||P.SC[I[z].i.y]==0)) I[z] = new CI(-1,-1,K.A);			
						
				CI[] bak = Arrays.copyOf(I,I.length);
				
				I[z]=new CI(-1,-1,K.A);
								
				if (!P.equals(new Puzzle(P.SR,P.SC,I,B).Resol())) I[z] = bak[z];
			}			
			Totfet = true;
		}
			
		t = System.currentTimeMillis() - t;
		
		return new Puzzle(P.SR,P.SC,I,B);		
	}
}
