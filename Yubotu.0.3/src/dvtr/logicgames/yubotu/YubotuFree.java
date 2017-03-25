package dvtr.logicgames.yubotu;

public class YubotuFree{
	public final static int[] Fs={K.ACO,K.CRE,K.CRE,K.DES,K.DES,K.DES,K.SUB,K.SUB,K.SUB,K.SUB};
													
	public final static CI[][] I = {new CI[] {new CI(5,7,K.X),
											  new CI(3,8,K.N),
											  new CI(1,9,K.E)},
									new CI[] {new CI(1,1,K.S),
											  new CI(9,3,K.X),
											  new CI(0,5,K.A),
											  new CI(7,8,K.A)},
									new CI[] {new CI(8,1,K.N),
											  new CI(7,4,K.A),
											  new CI(0,8,K.N)},
									new CI[] {new CI(8,4,K.O),
											  new CI(8,6,K.O),
											  new CI(6,5,K.A),
											  new CI(2,5,K.A)},
									new CI[] {new CI(0,9,K.A),
											  new CI(8,2,K.X),
											  new CI(2,5,K.A),
											  new CI(3,5,K.A),
											  new CI(9,5,K.N),
											  new CI(2,7,K.A)},
									new CI[] {new CI(7,2,K.O),
											  new CI(5,3,K.A),
											  new CI(1,4,K.B),
											  new CI(5,6,K.B),
											  new CI(4,9,K.A),
											  new CI(5,9,K.A),
											  new CI(8,9,K.O)},
									new CI[] {new CI(6,2,K.O),
											  new CI(2,3,K.A),
											  new CI(9,3,K.N),
											  new CI(1,5,K.O),
											  new CI(9,5,K.A),
											  new CI(9,6,K.A),
											  new CI(3,8,K.A),
											  new CI(5,8,K.O)},
									new CI[] {new CI(3,4,K.A),
											  new CI(4,0,K.A),
											  new CI(3,6,K.E),
											  new CI(9,7,K.E),
											  new CI(7,9,K.A)
	}};
	public static int[][] SRs={{1,1,1,2,2,4,1,2,0,6},
							   {4,4,1,2,0,2,0,4,0,3},
							   {2,5,0,3,2,2,0,4,2,0},
							   {0,1,5,1,3,1,5,0,2,2},
							   {3,0,3,3,3,0,1,1,1,5},
							   {0,2,2,0,2,2,2,2,6,2},
							   {1,2,3,2,2,1,2,3,0,4},
							   {2,3,2,2,0,1,4,1,2,3}};
	
	public static int[][] SCs={{0,2,1,6,0,1,3,1,2,4},
							   {1,1,2,1,5,1,5,0,3,1},
							   {3,1,1,1,2,2,1,3,3,3},
							   {3,0,0,4,3,1,2,2,2,3},
							   {2,0,4,4,0,3,2,3,0,2},
							   {4,0,3,1,2,1,2,3,0,4},
							   {2,0,2,3,1,4,1,0,4,3},
							   {0,1,0,3,4,0,3,4,0,5}};
							   
	public static Puzzle Pz(int i){return new Puzzle(SRs[i],SCs[i],I[i],Fs);}
}