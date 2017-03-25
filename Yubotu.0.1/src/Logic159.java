
public class Logic159 {

	public final static Vaixells[] Flota = {
		new Vaixells(new char[]{k.SUB,k.SUB,k.SUB,k.SUB}),
		new Vaixells(new char[]{k.CRE,k.DES,k.SUB,k.SUB}),
		new Vaixells(new char[]{k.ACO,k.CRE,k.CRE,k.DES,k.DES,k.DES,k.DES,k.SUB,k.SUB,k.SUB,k.SUB})
	};	
	
	public final static Celles[] Inici = {
		new Celles( new Cella[]{ new Cella(1,1,k.A) }),
		new Celles( new Cella[]{ new Cella(1,2,k.S) }),
		new Celles( new Cella[]{ new Cella(0,0,k.B),
								 new Cella(4,1,k.A),
								 new Cella(7,3,k.B),
								 new Cella(1,4,k.N),
								 new Cella(5,5,k.A),
								 new Cella(2,8,k.P),
								 new Cella(5,8,k.A)
							   }),
		new Celles( new Cella[]{ new Cella(4,0,k.A),
								 new Cella(6,0,k.N),
								 new Cella(0,3,k.B),
								 new Cella(2,4,k.A),
								 new Cella(5,4,k.P),
								 new Cella(4,6,k.A),
								 new Cella(6,8,k.B)
							   }),
		new Celles( new Cella[]{ new Cella(6,0,k.A),
							     new Cella(2,2,k.A),
							     new Cella(2,4,k.P),
							     new Cella(2,6,k.S),
							     new Cella(6,7,k.S),
							     new Cella(0,8,k.B)
							   }),
		new Celles( new Cella[]{ new Cella(4,4,k.O) })
		};
		
	public final static int[][] SRs = {
										{1,0,1},
										{1,3,0,2,1},
										{1,4,2,3,2,3,1,2,2},
										{3,1,3,3,2,2,5,1,0},
										{3,0,6,2,3,0,4,2,0},
										{9,9,9,9,9,9,9,9,9}
	};
	
	public final static int[][] SCs = {
										{1,0,1},
										{2,1,2,1,1},
										{2,4,1,1,1,5,2,0,4},
										{4,1,2,1,4,0,4,3,1},
										{1,5,1,3,1,3,2,1,3},
										{9,9,9,9,9,9,9,9,9}
	};			
	
	public final static Puzzle[] Puzzle = {
		new Puzzle(Flota[0],Inici[0],SRs[0],SCs[0]),
		new Puzzle(Flota[1],Inici[1],SRs[1],SCs[1]),
		new Puzzle(Flota[2],Inici[2],SRs[2],SCs[2]),
		new Puzzle(Flota[2],Inici[3],SRs[3],SCs[3]),
		new Puzzle(Flota[2],Inici[4],SRs[4],SCs[4]),
		new Puzzle(Flota[2],Inici[5],SRs[5],SCs[5])
	};
}