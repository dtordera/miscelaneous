package comu;

import java.util.Arrays;

public class BSPuzzleI extends BSPuzzle {

	public byte [][] G;
	public byte [][] S;

	public BSPuzzleI(BSPuzzle P){
		super(P);
		
		G = new byte[C][R];
		
		ResetE();
		TrobaS();
	}
	
	void TrobaS(){
		TrobaSShipModel();
	}
	
	void TrobaSShipModel(){
		shipmodel.Resoledor Rs = new shipmodel.Resoledor(this);
		
		S = new byte[C][R];
		
		Rs.prepara();
		Rs.Resol(1);
		
		byte i,j;
		
		for (shipmodel.Vaixell v:Rs.S[0])		
			for (i=v.r().x;i<=v.rf().x;i++)
			for (j=v.r().y;j<=v.rf().y;j++)
				S[i][j] = (byte)v.c(i,j);
	}
	
	void ResetE(){

		byte j;

		for (j=0;j<R;j++)
			Arrays.fill(G[j],K.I);
			
		for (Mostrades m:M)
			G[m.x][m.y] = m.v;
	}
}
