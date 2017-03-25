public class Resoledor {
	static Puzzles R;
	
	public Resoledor(Puzzle P){R=new Puzzles(P);}
	
	public Puzzle Resol(){
	System.out.println(R.u().toString());		
	R.a(dAIGxCAP(R.u()));			
	System.out.println(R.u().toString());
	R.a(dALGxCAP(R.u()));	
	System.out.println(R.u().toString());			
	
	
	return R.u();}
	
	public Puzzle dAIGxCAP(Puzzle P){for(int j=0;j<P.g.R;j++)for(int i=0;i<P.g.C;i++)P.dAIGxCAP(i,j);return P;}	
	public Puzzle dALGxCAP(Puzzle P){for(int j=0;j<P.g.R;j++)for(int i=0;i<P.g.C;i++)P.dALGxCAP(i,j);return P;}
}
