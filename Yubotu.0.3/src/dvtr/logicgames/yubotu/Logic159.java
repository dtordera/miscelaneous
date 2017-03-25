package dvtr.logicgames.yubotu;

public class Logic159 {
	public final static int[][] Fs={{K.SUB,K.SUB,K.SUB,K.SUB},
									{K.CRE,K.DES,K.SUB,K.SUB},
									{K.ACO,K.CRE,K.CRE,K.DES,K.DES,K.DES,K.SUB,K.SUB,K.SUB,K.SUB},
									{K.ACO,K.CRE,K.CRE,K.DES,K.DES,K.DES,K.SUB,K.SUB,K.SUB,K.SUB},									
									{K.ACO,K.CRE,K.CRE,K.DES,K.DES,K.DES,K.SUB,K.SUB,K.SUB,K.SUB},
									{K.ACO,K.CRE,K.CRE,K.DES,K.DES,K.DES,K.SUB,K.SUB,K.SUB,K.SUB},
									{K.ACO,K.CRE,K.CRE,K.DES,K.DES,K.DES,K.SUB,K.SUB,K.SUB,K.SUB},
									{K.ACO,K.CRE,K.CRE,K.DES,K.DES,K.DES,K.SUB,K.SUB,K.SUB,K.SUB},																		
									{K.ACO,K.CRE,K.CRE,K.DES,K.DES,K.DES,K.SUB,K.SUB,K.SUB,K.SUB}																		
									};
	public final static CI[][] I = {new CI[] {new CI(1,1,K.A)},
									new CI[] {new CI(1,2,K.S)},
									new CI[] {new CI(0,0,K.B),
											  new CI(4,1,K.A),
											  new CI(7,3,K.B),
											  new CI(1,4,K.N),
											  new CI(5,5,K.A),
											  new CI(2,8,K.X),
											  new CI(5,8,K.A)},
									new CI[] {new CI(4,0,K.A),
											  new CI(6,0,K.N),
											  new CI(0,3,K.B),
											  new CI(2,4,K.A),
											  new CI(5,4,K.X),
											  new CI(4,6,K.A),
											  new CI(6,8,K.B)},
									new CI[] {new CI(6,1,K.A),
											  new CI(2,2,K.A),
											  new CI(2,4,K.X),
											  new CI(6,4,K.A),
											  new CI(2,6,K.S),
											  new CI(6,7,K.S),
											  new CI(0,8,K.B)},
									new CI[] {new CI(1,2,K.B),
											  new CI(5,2,K.A),
											  new CI(7,3,K.S),
											  new CI(3,4,K.X),
											  new CI(6,5,K.B)},
									new CI[] {new CI(2,0,K.B),
											  new CI(0,2,K.S),
											  new CI(4,2,K.A),
											  new CI(0,4,K.A),
											  new CI(5,4,K.A),
											  new CI(0,6,K.X),
											  new CI(4,5,K.A),
											  new CI(7,5,K.E),
											  new CI(7,8,K.A)},
									new CI[] {new CI(5,0,K.B),
											  new CI(1,1,K.S),
											  new CI(5,2,K.B),
											  new CI(7,3,K.X),
											  new CI(3,4,K.A),
											  new CI(1,7,K.A)},
									new CI[] {new CI(1,0,K.E),
											  new CI(5,1,K.X),
											  new CI(1,3,K.B),
											  new CI(7,4,K.A),
											  new CI(4,5,K.A),
											  new CI(3,6,K.A),
											  new CI(7,8,K.B)}
									};
	public static int[][] SRs={{2,0,2},
							   {1,3,0,2,1},
							   {1,4,2,3,2,3,1,2,2},
							   {3,1,3,3,2,2,5,1,0},
							   {3,0,6,2,3,0,4,2,0},
							   {2,2,2,3,3,2,1,3,2},
							   {5,0,3,3,1,4,1,3,0},
							   {0,6,0,6,1,3,1,3,0},
							   {1,5,0,4,2,3,1,4,0}};
	
	public static int[][] SCs={{2,0,2},
							   {2,1,2,1,1},
							   {2,4,1,1,1,5,2,0,4},
							   {4,1,2,1,4,0,4,3,1},
							   {1,5,1,3,1,3,2,1,3},
							   {2,1,4,1,4,1,2,5,0},
							   {1,2,5,0,1,4,1,2,4},
							   {3,2,3,3,2,2,3,0,2},
							   {2,4,0,2,1,4,2,4,1}};
							   
	public static Puzzle Pz(int i){return new Puzzle(SRs[i],SCs[i],I[i],Fs[i]);}
}