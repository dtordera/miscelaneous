import java.util.ArrayList;
import java.util.Collections;


public class k {
	public final static int SUBMARI=1,
							DESTRUCTOR=2,
							CREUER=3,
							ACOIRASSAT=4,
							PORTAVIONS=5;							

	public final static int X  = 0,	// indeterminada
							A  = 1,	// aigua
							N  = 2,	// nord
							S  = 3,	// sud
							E  = 4,	// est
							O  = 5,	// oest
							P  = 6,	// part
							B  = 7,	// submari
							H  = 8,	// horitzontal
							V  = 9;	// vertical
					 
	public final static int[][][] Patrons = {
						{ 
						    {X, X, X, X, X}, // indeterminada
						    {X, X, X, X, X},
						    {X, X, X, X, X},
						    {X, X, X, X, X},
						    {X, X, X, X, X}
						},
						{ 
							{X, X, X, X, X}, // Aigua
							{X, X, X, X, X},
							{X, X, A, X, X},
							{X, X, X, X, X},
							{X, X, X, X, X}
						},
						{ 
							{X, X, X, X, X},
							{X, A, A, A, X}, // Nord
							{X, A, N, A, X},
							{X, A, X, A, X},
							{X, A, X, A, X}
						},
						{ 
							{X, A, X, A, X},// Sud
							{X, A, X, A, X},
							{X, A, S, A, X},
							{X, A, A, A, X},
							{X, X, X, X, X}
						}, 
						{ 
							{X, X, X, X, X}, // Est
							{A, A, A, A, X}, 
							{X, X, E, A, X},
							{A, A, A, A, X},
							{X, X, X, X, X}
						},						
						{ 	
							{X, X, X, X, X}, // Oest
							{X, A, A, A, A},
							{X, A, O, H, X},
							{X, A, A, A, A},
							{X, X, X, X, X}
						},
						{ 	
							{X, X, X, X, X},
							{X, A, X, A, X},// Ocupat
							{X, X, P, X, X},
							{X, A, X, A, X},
							{X, X, X, X, X}
						},					
						{ 	
							{X, X, X, X, X}, // Submari
							{X, A, A, A, X},
							{X, A, B, A, X},
							{X, A, A, A, X},
							{X, X, X, X, X}
						},
						{ 
							{X, X, X, X, X},
							{A, A, A, A, A}, // Horitzontal
							{X, X, H, X, X},
							{A, A, A, A, A},
							{X, X, X, X, X}
						},
						{ 
							{X, A, X, A, X}, // Vertical
							{X, A, X, A, X},
							{X, A, V, A, X},
							{X, A, X, A, X},
							{X, A, X, A, X}
						}
				};
			
		public final static int vPatro(int n, int i, int j){
			return Patrons[n][j][i];
		}
		
		public final static boolean PatroPosible(int n,int i,int j,int v){
		
			boolean ret = false;			
			int p = Patrons[n][j][i];
						
			if (p == k.X) ret = true;
			else
			if (p == k.A) ret = v == k.A;
			else
			if ((i==2) && (j==2)) ret = true;			
			
			return ret;
		}
						
		public final static int[] RandomIndexArray(int l){
			ArrayList<Integer> R = new ArrayList<Integer>(l);
			Integer ia[] = new Integer[R.size()]; 							
									
			for (int i=0;i<l;i++)
				R.add(i);
				
			Collections.shuffle(R);
								
			ia = R.toArray(ia); 					
			int[] RT = new int[ia.length];			
			
			for (int i=0;i<ia.length;i++)
				RT[i] = ia[i];
										
			return RT;
		}
}
