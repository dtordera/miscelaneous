import java.util.Arrays;
import java.util.Scanner;


public class Puzzle {
	public int 	C,
				R;
	public Vaixells F;
	public Celles I;
	public boolean resolved;
	int[]  SR,SC;
		
	public Puzzle(Vaixells V,Celles j,int[] SRo, int[] SCo){
		C = SRo.length;
		R = SCo.length;
			
		F  = V;
		I  = j;
		
		SR = Arrays.copyOf(SRo,C);
		SC = Arrays.copyOf(SCo,R);
		resolved = false;
	}
		
	public boolean Resol() {
	
		Resoledor r = new Resoledor(this);
		
			F = r.F;
			resolved = true;
		
		return resolved;
	}
		
/*		boolean ret = false;
		Scanner h = new Scanner(System.in);																					
		Tecn    T = new Tecn(this);
						
		Tecn.IniciaPosicions(C,R,F);
		Tecn.EliminarZeros(SC,SR,F);		
		Tecn.AplicaPatronsCellesInicials(I,F);
				
		int intent = 0;
		while(!resolved) {
			
			System.out.println("Intent #" + ++intent);
			
			int []SRt = Tecn.CalculaSumes(SR,C,k.h,I,F);
			int []SCt = Tecn.CalculaSumes(SC,R,k.v,I,F);
			
//			Tecn.DetSubs(SCt,SRt,F);			
			Tecn.EliminaZeros(SCt,SRt,F);
			Tecn.EliminarPerNoCapacitat(SCt,SRt,F);					
		
			System.out.println("Estat actual:\n"+estatActual(SCt,SRt));
																														
			resolved = F.AD();
		
			String d=toString();
	
			for (int i=0;i<F.v.length;i++)
			{												
				d += "\nVaixell #" + i +":l="+(int)F.v[i].L+";D="+F.v[i].D+"\n";
				d += F.v[i].P.toStringGrid(C,R);
				d += "\n";			
			}
			
			F.cD();
														
			System.out.printf(d);					
			h.nextInt();
			
		}														
		return ret;*/
	}	
		
	public String toString(){
		char G[][] = new char[C][R];
		String ret = "";
						
		if (resolved) {
			for (int j=0;j<R;j++)
			for (int i=0;i<C;i++)
				G[i][j] = k.r[k.A];					
		
			for (int n=0;n<F.v.length;n++)				
				F.v[n].toGrid(G);	
		}
		else {
			for (int j=0;j<R;j++)
			for (int i=0;i<C;i++)
				G[i][j] = k.r[k.x];

			for (int n=0;n<I.c.length;n++)
				G[I.i(n).x][I.i(n).y] = k.r[I.v(n)];
		}

		for (int j=0;j<R;j++)
		{
			for (int i=0;i<C;i++)
				ret += G[i][j] + " ";
			
			ret += SC[j] + "\n";
			
		}
				
		ret += "\n";				
		for (int i=0;i<C;i++)
			ret += SR[i] + " ";
			
		ret += "\n";

		return ret;
	}
}