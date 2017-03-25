import java.util.Arrays;


public class Resoledor {
	public int C,R;
	public Vaixells F;
	public Celles   I;
	public int[]	SRo,SCo;
	
	public Resoledor(Puzzle P){
		F = P.F;
		I = P.I;
		C = P.C;
		R = P.R;
		SRo = Arrays.copyOf(P.SR,P.SR.length);
		SCo = Arrays.copyOf(P.SC,P.SC.length);
	}
	
	public static boolean IniciaPosicions(int C,int R,Vaixells F){
		boolean ret = false;
				
		boolean b = k.h;
		
		for (int n=0;n<F.v.length;n++)
		{
			F.v[n].P.removeall();
		
			for (int i=0;i<2 - (F.v[n].L==1?1:0);i++)
			{
				for (int x=0;x<C-(F.v[n].L-1)*(b?1:0);x++)
					for (int y=0;y<R-(F.v[n].L-1)*(b?0:1);y++)
						F.v[n].P.add(new Posicio(x,y,b));						
				b = !b;
			}
		}				
		return ret;
	}
	
	public static int[] CalculaSumes(int []S,int L,boolean h, Celles I, Vaixells F){
		int []A = Arrays.copyOf(S,S.length);
		
		int mx,
			my;			
			
		mx = h == k.v? A.length : L; 
		my = h == k.v? L : A.length;
		
		for (int j=0;j<my;j++)
			for (int i=0;i<mx;i++)
			{
				if (F.C(i,j) > k.A) A[h==k.v?j:i]--;
				else
				if (I.C(i,j) > k.A) A[h==k.v?j:i]--;
			}
				
		return A;
	}

	public static boolean AplicaPatronsCellesInicials(Celles I, Vaixells F)
	{
		boolean ret = false;
		boolean [][]P;
				
		for (int n=0;n<I.c.length;n++)
		{		
			P = k.PA[I.v(n)];
			
			for (int i=0;i<P.length;i++)
			for (int j=0;j<P[i].length;j++)
				if (P[i][j]) F.No(I.i(n).d(j-2,i-2));			
				
			if (I.v(n) == k.B) F.Def(k.SUB,new Posicio(I.i(n),k.v));

		}	
		return ret;		
	}
	
	public static boolean DetSubs(int[] SCt, int[] SRt, Vaixells F){
		boolean ret = false;
	
			
		return ret;
	}
	
	public static boolean EliminarZeros(int[] SCt, int[] SRt, Vaixells F){
		boolean ret = false;
		
		for (int i=0;i<SRt.length;i++)
			if (SRt[i] == 0) 
				for (int y=0;y<SCt.length;y++)
					F.No(new Index(i,y));

		
		for (int j=0;j<SCt.length;j++)
			if (SCt[j] == 0)
				for (int x=0;x<SRt.length;x++)
					F.No(new Index(x,j));		
		
		return ret;
	}
		
	public static boolean EliminarPerNoCapacitat(int[] SCt, int[] SRt, Vaixells F){
	
		boolean ret = false;
		
			// eliminem per capacitat minima

			for (int n=0;n<F.v.length;n++)
			{
				for (int j=0;j<SCt.length;j++)
					if (!F.v[n].D)			
						if (F.v[n].L > SCt[j]) 				
							for (int p=0;p<SCt.length;p++) 
								F.v[n].P.remove(p,j,k.h);				
		
				for (int i=0;i<SRt.length;i++)
					if (!F.v[n].D)
						if (F.v[n].L > SRt[i]) 
							for (int p=0;p<SRt.length;p++) 
								F.v[n].P.remove(i,p,k.v);
			}		
										
		return ret;
	}
	

}
