
public class Logic159 {
	public final static int[][] Fs={{0,4},
									{0,2,1,1},
									{0,4,3,2,1},
									{0,4,3,2,1},
									{0,4,3,2,1}};
						
	public final static CI[][] I = {new CI[] {new CI(1,1,k.A)},
									new CI[] {new CI(1,2,k.S)},
									new CI[] {new CI(0,0,k.B),
											  new CI(4,1,k.A),
											  new CI(7,3,k.B),
											  new CI(1,4,k.N),
											  new CI(5,5,k.A),
											  new CI(2,8,k.X),
											  new CI(5,8,k.A)},
									new CI[] {new CI(4,0,k.A),
											  new CI(6,0,k.N),
											  new CI(0,3,k.B),
											  new CI(2,4,k.A),
											  new CI(5,4,k.X),
											  new CI(4,6,k.A),
											  new CI(6,8,k.B)},
									new CI[] {new CI(6,1,k.A),
											  new CI(2,2,k.A),
											  new CI(2,4,k.X),
											  new CI(6,4,k.A),
											  new CI(2,6,k.S),
											  new CI(6,7,k.S),
											  new CI(0,8,k.B)}};
	public static int[][] SRs={{2,0,2},
							   {1,3,0,2,1},
							   {1,4,2,3,2,3,1,2,2},
							   {3,1,3,3,2,2,5,1,0},
							   {3,0,6,2,3,0,4,2,0}};
	
	public static int[][] SCs={{2,0,2},
							   {2,1,2,1,1},
							   {2,4,1,1,1,5,2,0,4},
							   {4,1,2,1,4,0,4,3,1},
							   {1,5,1,3,1,3,2,1,3}};
							   
	public static Puzzle Pz(int i){return new Puzzle(SRs[i],SCs[i],I[i],Fs[i]);}
}
