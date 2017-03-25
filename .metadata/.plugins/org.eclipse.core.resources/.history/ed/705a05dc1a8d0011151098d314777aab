//	Clase BSPuzzle : puzzle de battleship solitarie sense resoldre
//  Ultima revisio: 16/04/2012

package comu;

import java.util.Arrays;

public class BSPuzzle {

	protected byte 			C,R;			// Columnes, rows
	protected byte[] 		SR,SC;  		// Suma rows, suma columnes (solids)
	protected byte[]		Ls;	    		// longituds de vaixells	
	protected Mostrades[] 	M;				// Celles inicals mostrades	
	boolean 				ModelGenerat;	// Model amb que ha estat generat	
	public long 			gt;				// temps de generacio
		
	// Constructor 
	public BSPuzzle(byte[] sr, byte[] sc,Mostrades[] m, byte[] ls, boolean mgenerat,long tm){
	
		C = (byte)sr.length;
		R = (byte)sc.length;
	
		SR=sr.clone();
		SC=sc.clone();		
		Ls=ls.clone();
		
		M = Arrays.copyOf(m,m.length);
		
		ModelGenerat = mgenerat;					
		gt = tm;
	}	
	
	// Constructor copia (per clases resoledor derivades)
	public BSPuzzle(BSPuzzle P){
	
		C = P.C;
		R = P.R;
		
		SR=P.SR.clone();
		SC=P.SC.clone();		
		Ls=P.Ls.clone();
		
		M= Arrays.copyOf(P.M,P.M.length);
		
		ModelGenerat = P.ModelGenerat;
		gt = P.gt;
	}
	
	// toString
	public String toString(){
	
		// Pasem a un grid de byte les mostrades, amb les sumes, i imprimim el grid	
		final byte[][] G = new byte[C][R];
	
		for (byte n=0;n<C;n++)
			Arrays.fill(G[n],K.I);
		
		for (Mostrades m:M)
			G[m.x][m.y] = m.v;		
	
		String s="";
		
		for (int j=0;j<R;j++) {
			
			s +="\n";
			
			for (int i=0;i<C;i++)
				s += (char)G[i][j] + " ";
				
			s += SC[j];							
		}
		
		s+="\n\n";
		
		for (int i=0;i<C;i++)
			s+=SR[i]+" ";
		
		return s;	
	}	
}
