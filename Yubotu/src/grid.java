import java.util.Arrays;
import java.util.Random;


public class grid {

	cella[][]  c;
	int 	   mr,mc;
	int[] 	   V;
	int[] 	   SR,
		  	   SC;
	int 	   tg;
	
	public grid(int columns, int rows,int[] v){
	
		int i;
		long t = System.currentTimeMillis();		
		
		mr = rows;
		mc = columns;
		
		SR = new int[columns]; 			// Suma de files (linea horitzontal)
		SC = new int[rows];	   			// Suma de columnes (linea vertical)
		c  = new cella[columns][rows];
		
		V = new int[v.length];
		
		for (i = 0;i<V.length;i++)
			V[i] = v[i];
		
		for (i = 0;i <columns;i++)
		{
			c[i] = new cella[rows];
			for (int j=0;j<rows;j++)
				c[i][j] = new cella();
		}
		
		Populate();		
		tg = (int)(System.currentTimeMillis() - t);
	}
	
	public grid(String[] s, int[] v, int[] SRs, int[] SCs) {
	
		long t = System.currentTimeMillis();
		
		mr = s.length;
		mc = s[0].length();
		
		SR = Arrays.copyOf(SRs,SRs.length);
		SC = Arrays.copyOf(SCs,SCs.length);
		
		V  = Arrays.copyOf(v,v.length);
		
		c = new cella[mc][mr];
		
		for (int i=0;i<mc;i++)
		{
			c[i] = new cella[mr];
			for (int j=0;j<mr;j++)
				c[i][j] = new cella();
		}
				
		for (int j=0;j<mr;j++)
		{	
			for (int i=0;i<mc;i++)
			{							
				switch(s[j].charAt(i))  {
				case ' ' : C(i,j,k.X); break;
				case '#' : C(i,j,k.P); break;
				case 'X' : C(i,j,k.H); break;
				case 'H' : C(i,j,k.V); break;
				case 'O' : C(i,j,k.B); break;
				case 'V' : C(i,j,k.S); break;
				case 'A' : C(i,j,k.N); break;
				case '<' : C(i,j,k.O); break;
				case '>' : C(i,j,k.E); break;
				default  : C(i,j,k.X); break;
				}
								
				System.out.print(C(i,j));
			}
			System.out.println();
		}
		tg = (int)(System.currentTimeMillis() - t);		
	}
	
	public grid(grid g){
	
		mc = g.mc;
		mr = g.mr;
		
		SR = Arrays.copyOf(g.SR,g.SR.length);
		SC = Arrays.copyOf(g.SC,g.SC.length);

		c = new cella[mc][mr];

		for (int i=0;i<mc;i++)		
		{
			c[i] = new cella[mr];
			for (int j=0;j<mc;j++)
			{
				c[i][j] = new cella();
				c[i][j].d = g.C(i,j);
			}
		}		

		V = Arrays.copyOf(g.V,g.V.length);
		
		tg = g.tg;
	}
	
	public String toString(){
	
		String ret = "";
		char d = ' ';

		for (int j=0;j<mr;j++)		
		{
			for (int i=0;i<mc;i++)			
			{			
				switch(C(i,j)) {
				case k.A : d = 0x7e; break;
				case k.X : d = ' ';  break;
				case k.H : d = 'X';  break;
				case k.V : d = 'M';  break;
				case k.B : d = 'Ø';  break;
				case k.S : d = 'Ɐ';  break;
				case k.N : d = 'A';  break;
				case k.O : d = '<';  break;
				case k.E : d = '>';  break;
				case k.P : d = '#';  break;
				}
				ret += "|" + d;
			}
			ret += "|" + SC[j] + '\n';
		}
		
		for (int i=0;i<mc;i++)
			ret += " " + SR[i];				
		ret += '\n';			
				
		return ret;					
	}
		
	public void Populate(){
							
		Random rnd = new Random();
		boolean Ori;
		boolean Err = true;
		boolean fet = false;
		
		int i,j,x,y,n; // contadors

		while (Err) {
			for (i=0;i<mc;i++)
			for (j=0;j<mr;j++) C(i,j,k.A); 
									
			for (i = 0;i < V.length; i++) {
		
				int[] pRows = k.RandomIndexArray(mr - V[i]); // Llista de posicions
				int[] pCols = k.RandomIndexArray(mc - V[i]);
			
				Err = false;			
				fet = false;
			
				for (x=0;(x<mc - V[i]) && !fet;x++)
					for (y=0;(y<mr - V[i]) && !fet;y++)
					{						
						Ori = rnd.nextBoolean(); // Orientacio inicial aleatoria
						
						Err = !ComprobaEspai(pCols[x],pRows[y],V[i],Ori);
				
						if (Err) {
							Ori = !Ori;
							Err = !ComprobaEspai(pCols[x],pRows[y],V[i],Ori);
						}
					
						if (!Err) 
							if (V[i] == k.SUBMARI) { C(pCols[x], pRows[y],k.B); }
							else
								if (Ori)
									for (n=pCols[x];n<pCols[x]+V[i];n++) C(n, pRows[y],k.H);
								else
									for (n=pRows[y];n<pRows[y]+V[i];n++) C(pCols[x],n,k.V);					
						fet = !Err;
					}
			}
		}
		
		for (i=0;i<mc;i++)
			for (j=0;j<mr;j++)
				switch(C(i,j))
				{
					case k.H :  if (C(i-1,j) == k.A) C(i,j,k.O); 
								if (C(i+1,j) == k.A) C(i,j,k.E); 
								break;
					case k.V :  if (C(i,j-1) == k.A) C(i,j,k.N);
								if (C(i,j+1) == k.A) C(i,j,k.S); 
								break;											
				}
		Sumes();
	}
	
	public void Sumes(){

		for (int i=0;i<mc;i++)
		{
			SR[i] = 0;
			for (int j=0;j<mr;j++)
				if (C(i,j) != k.A) SR[i]++;
		}
		
		for (int j=0;j<mr;j++)
		{
			SC[j] = 0;
			for (int i=0;i<mc;i++)
				if (C(i,j) != k.A) SC[j]++;
		}
	}
		
	public int C(int cl, int rw) {
		if (cl < 0 || cl >= mc || rw < 0 || rw >= mr) return k.A;
		else return c[cl][rw].d;
	}
	
	public int C(index i){
		return C(i.x,i.y);
	}
	
	public void C(index i,int v) {
		C(i.x,i.y,v);
	}
	
	public void C(int cl, int rw, int v) {
		try
		{
			c[cl][rw].d = v;
		}
		catch (Exception e) {
		}
	}
		
	public boolean ComprobaEspai(int co, int ro, int l, boolean horitzontal) {
	
		boolean ret = true;
				
		if (horitzontal) 
		{
			for (int i=co-1;i<co+l+1;i++)
			for (int j=ro-1;j<ro+1+1;j++)
				ret = ret && (C(i,j) == k.A);
		}			 
		else
		{
			for (int i=co-1;i<co+1+1;i++)
			for (int j=ro-1;j<ro+l+1;j++)
				ret = ret && (C(i,j) ==k.A);
		}
	
		return ret;
	}
}
