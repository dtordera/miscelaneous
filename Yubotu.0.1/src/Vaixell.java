

public class Vaixell {
	public char  	 L = 0;					// longitud
	public boolean 	 D = false;				// si ja està determinat
	public Posicions P = new Posicions(); 	// Posicions dinici posibles
	
	public Vaixell(int x,int y,char l,boolean o){ P.r().p(x,y,o);L = l;}	
	public Vaixell(char l) {L = l;}		
	public Posicio r(){return P.r();}												
	public void PosiblestoGrid(char[][]g,boolean h){for (int n=0;n<P.p.length;n++)if (P.p[n].o == h)g[P.p[n].i.x][P.p[n].i.y] = '?';}
	public void toGrid(char[][] g){if (D)for (int n=0;n<L;n++){char c=n==0?(L==1?'O':(r().o==k.v?'A':'C')):(n==L-1?(r().o==k.v?'U':'>'):'X');g[r().J(n).x][r().J(n).y]=c;}}		
}
