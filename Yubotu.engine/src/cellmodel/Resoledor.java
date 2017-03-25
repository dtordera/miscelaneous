// Clase cellmodel.Resoledor : resol BSPuzzles. Es basa en l'aplicació de tecniques sencilles, aixo es, sense tenir en 
// compte reduccions al absurd de capacitat, unicament treballant amb les celles. No pot resoldre, per lo general,
// puzzles generats amb shipmodel.

package cellmodel;

import java.util.Arrays;

import comu.BSPuzzle;
import comu.Mostrades;
import comu.K;
import comu.Index;

public class Resoledor extends BSPuzzle {

	private final byte[][] G; // Grid a on estaran representades les celles

	// Constructor
	public Resoledor(BSPuzzle P) {
		super(P); 
		
		G = new byte[C][R]; // Creem grid i resetejem		
		ResetGrid();
	}
	
	// M: canvia la llista de celles mostrades i reseteja el grid
	public Resoledor M(Mostrades[] m){
		M = new Mostrades[m.length];
		System.arraycopy(m,0,M,0,m.length);
		
		ResetGrid();		
		
		return this;
	}
		
	//ResetGrid: tornem tota la grid a indeterminada i coloquem les celles inicials
	public void ResetGrid(){	
	
		for (byte n=0;n<C;n++)
		Arrays.fill(G[n],K.I);
		
		for (Mostrades m:M)
			G[m.x][m.y] = m.v;		
	}
		
	//SCs : dona la suma de solids horitzontal (a la fila j) 
	byte SCs(int j){
		byte r=0;
	
		for (byte i=0;i<C;i++)
		r+=G[i][j]!=K.A&&G[i][j]!=K.I?1:0;
		
		return r;		
	}
	
	//SRs : dona la suma de solids vertical (a la columna i)
	byte SRs(int i){
		byte r=0;
		
		for (byte j=0;j<R;j++)
		r+=G[i][j]!=K.A&&G[i][j]!=K.I?1:0;
		
		return r;
	}
	
	//SCb : dona la suma de buits/indeterminats horitzontal(a la fila j)
	byte SCb(int j){
		byte r=0;
		
		for (byte i=0;i<C;i++)
		r+=G[i][j]==K.I?1:0;
		
		return r;
	}
	
	//SRb : dona la suma de buits/indeterminats vertical(a la columna i)
	byte SRb(int i){
		byte r=0;
		
		for (byte j=0;j<R;j++)
		r+=G[i][j]==K.I?1:0;
		
		return r;
	}
	
	// pv : posa un valor v al grid a les coordenades i,j, si son valides. Torna false si aquest valor ja estaba inclos o 
	//      coordenades invalides
	boolean pv(byte i,byte j,byte v){
		boolean r = false; 
		if (i>=0&&i<C&&j>=0&&j<R){
			r=v!=G[i][j]; 
			G[i][j]=v;
		} 
		return r;
	}
	boolean pv(Index I,byte v){return pv(I.x,I.y,v);}
	
	// v : torna el valor del grid a les coordenades, torna aigua si coordenades invalides
	byte v(byte i,byte j){
		if (i>=0&&i<C&&j>=0&&j<R) return G[i][j];
		else return K.A;
	}
	byte v(Index i){return v(i.x,i.y);}	

	// A : posa una llista de indexs com aigua
	boolean A(Index...I){boolean r = false; for(Index i:I) r|=pv(i,K.A); return r;}
	
	// mA : mira si tots els indexs indicats son aigua	
	boolean mA(Index...I){boolean r=true;for(Index i:I) r&=v(i)==K.A;return r;}
	
	// mS : mira si tots els indexs indicats son solids 	
	boolean mS(Index...I){boolean r=true;for(Index i:I) r&=v(i)!=K.A&&v(i)!=K.I;return r;}		
	
	// AiguaxSumes : tecnica de resolucio que posa aigua a les files i columnes a on tots els solids estan trobats
	boolean AiguaxSumes(){
		boolean r = false;
		
		for (byte i=0;i<C;i++)
			if (SR[i]==SRs(i)) 
				for (byte n=0;n<R;n++) if (G[i][n]==K.I) {r=true;G[i][n]=K.A;}

		for (byte j=0;j<R;j++)
			if (SC[j]==SCs(j))
				for (byte n=0;n<C;n++) if (G[n][j]==K.I) {r=true;G[n][j]=K.A;}
		
		return r;						
	}
	
	// SolidxIndeterminats: tecnica de resolucio que posa solids alla a on els buits son iguals a els solids restants
	boolean SolidxIndeterminats(){
		boolean r = false;
		
		for (byte i=0;i<C;i++)
			if (SR[i]-SRs(i)==SRb(i)) 
				for (byte n=0;n<R;n++) if (G[i][n]==K.I) {r=true;G[i][n]=K.X;}
				
		for (byte j=0;j<R;j++)
			if (SC[j]-SCs(j)==SCb(j))
				for (byte n=0;n<C;n++) if (G[n][j]==K.I) {r=true;G[n][j]=K.X;}
		
		return r;
	}
	
	// PatronsAigua : aplica patrons d'aigua segons el tipus de valor solid de la cella.
	boolean PatronsAigua(){
		boolean r = false;
		Index I = new Index();

		for (I.y=0;I.y<R;I.y++)
		for (I.x=0;I.x<C;I.x++)
			switch(v(I)){
			case K.X :
			case K.M : r|=A(I.NO(),I.NE(),I.SO(),I.SE()); break;
			case K.B : r|=A(I.NO(),I.N(),I.NE(),I.O(),I.E(),I.SO(),I.S(),I.SE());break;
			case K.N : r|=A(I.NO(),I.N(),I.NE(),I.O(),I.E(),I.SO(),I.SE(),I.SSO(),I.SSE()); break;
			case K.S : r|=A(I.SO(),I.S(),I.SE(),I.O(),I.E(),I.NO(),I.NE(),I.NNO(),I.NNE()); break;
			case K.O : r|=A(I.NO(),I.N(),I.NE(),I.ENE(),I.O(),I.SO(),I.S(),I.SE(),I.ESE()); break;
			case K.E : r|=A(I.ONO(),I.NO(),I.N(),I.NE(),I.E(),I.OSO(),I.SO(),I.S(),I.SE()); break;
			}

		return r;
	}	
	
	// MarcaExtrems : Determina la part que es segons les celles colindants
	boolean MarcaExtrems(){
		boolean r = false;
		Index I = new Index();
		byte x,y;
		
		for (y=0;y<R;y++)
		for (x=0;x<C;x++)
		{
			I.x = x;
			I.y = y;
			
			if (v(I)!=K.X) continue;
			
			if (mA(I.NO(),I.N(),I.NE(),I.O(),I.E(),I.SO(),I.S(),I.SE())) { r=true;G[x][y]=K.B;}
			else
			if (mA(I.NO(),I.N(),I.NE(),I.O(),I.E())&&mS(I.S())) {r=true;G[x][y]=K.N;}
			else
			if (mA(I.SO(),I.S(),I.SE(),I.O(),I.E())&&mS(I.N())) {r=true;G[x][y]=K.S;}
			else
			if (mA(I.NO(),I.O(),I.SO(),I.N(),I.S())&&mS(I.E())) {r=true;G[x][y]=K.O;}
			else
			if (mA(I.NE(),I.E(),I.SE(),I.N(),I.S())&&mS(I.O())) {r=true;G[x][y]=K.E;}
			else
			if (mS(I.N())&&mS(I.S())){r=true;G[x][y]=K.M;}
			else
			if (mS(I.O())&&mS(I.E())){r=true;G[x][y]=K.M;}
		}		
				
		return r;
	}
	
	// MarcaSolids : determina les celles colindants a M i als extrems
	boolean MarcaSolids(){
		boolean r = false;
		Index I = new Index();		
		
		for (I.y=0;I.y<R;I.y++)
		for (I.x=0;I.x<C;I.x++)
		{
			if (v(I)==K.M){
				if (mA(I.N())||mA(I.S())) {
					if (v(I.O())==K.I) pv(I.O(),K.X);
					if (v(I.E())==K.I) pv(I.E(),K.X);}
				else
				if (mA(I.O())||mA(I.E())) {
					if (v(I.N())==K.I) pv(I.N(),K.X);
					if (v(I.S())==K.I) pv(I.S(),K.X);}
			}
			
			if (v(I)==K.I&&(v(I.N())==K.N||v(I.S())==K.S||v(I.E())==K.E||v(I.O())==K.O)) pv(I,K.X);
		}		
		return r;
	}
	
	// HadeserAigua : determina si una cella pot ser o no solida (si es solida, 4 colindants son aigua,cosa que pot no 
	// ser coherent amb les sumes)
	boolean HadeserAigua(){
		boolean r=false,
				nps;
		Index I = new Index();
		int NO,SO,NE,SE;

		for (I.y=0;I.y<R;I.y++)
		for (I.x=0;I.x<C;I.x++)
		{
			nps = false;

			NO=v(I.NO())==K.I?1:0;
			SO=v(I.SO())==K.I?1:0;
			NE=v(I.NE())==K.I?1:0;
			SE=v(I.SE())==K.I?1:0;

			nps|=(NO==1||SO==1)&&(SRb(I.x-1)-NO-SO<SR[I.x-1]-SRs(I.x-1));
			nps|=(NE==1||SE==1)&&(SRb(I.x+1)-NE-SE<SR[I.x+1]-SRs(I.x+1));
			nps|=(NO==1||NE==1)&&(SCb(I.y-1)-NO-NE<SC[I.y-1]-SCs(I.y-1));
			nps|=(SO==1||SE==1)&&(SCb(I.y+1)-SO-SE<SC[I.y+1]-SCs(I.y+1));

			if (nps) r|=A(I);
		}
		return r;
	}	
	
	// toString
	public String toString(){
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

	// ComprobaSumes : comproba sumes inicials = sumes calculades i buits==0
	boolean ComprobaSumes(){
		boolean r = true;
	
		for (byte j=0;j<R;j++)
			r&=SR[j]==SRs(j)&&SRb(j)==0;
			
		for (byte i=0;i<C;i++)
			r&=SC[i]==SCs(i)&&SCb(i)==0;
			
		return r;
	}
	
	// ComprobaVaixells : Comproba que hi hagin tots i nomes els vaixells demanats
	boolean ComprobaVaixells(){
		boolean r=true;		
		byte x,y,n;
		byte[] Fs;
		
		int mL=0,L;
		
		for (byte l:Ls)	mL=l>mL?l:mL;
						
		Fs = new byte[mL];
				
		for (n=0;n<mL;n++) Fs[n]=0;		
		for (byte l:Ls)    Fs[l-1]++;
					
		for (y=0;y<R;y++)
		for (x=0;x<C;x++)
			switch(v(x,y)){
			case K.B : 	Fs[0]--; break;
			case K.N : 	L = 0;
					   	do L++; while (mS(new Index(x,y+L)));			 
					   	Fs[L-1]--;
					   	break;
					   	
			case K.O : 	L=0;
						do L++; while (mS(new Index(x+L,y)));
						
						Fs[L-1]--;						
						break; 
			}									
		
		for (n=0;n<mL;n++) r&=Fs[n]==0;		
		
		return r;		
	}	
	
	// ComprobaChocs : comproba no chocs entre vaixells
	boolean ComprobaChocs(){
		boolean r = true;
		
		Index I = new Index();
		
		for (I.y=0;I.y<R;I.y++)
		for (I.x=0;I.x<C;I.x++)		
			if (mS(I)) 			
			switch(v(I)){
			case K.B : r &= mA(I.NO(),I.N(),I.NE(),I.O(),I.E(),I.SO(),I.S(),I.SE());break;
			case K.N : r &= mA(I.NO(),I.N(),I.NE(),I.O(),I.E(),I.SO(),I.SE(),I.SSO(),I.SSE()); break;
			case K.S : r &= mA(I.SO(),I.S(),I.SE(),I.O(),I.E(),I.NO(),I.NE(),I.NNO(),I.NNE()); break;
			case K.O : r &= mA(I.NO(),I.O(),I.SO(),I.N(),I.S(),I.NE(),I.SE(),I.ENE(),I.ESE()); break;
			case K.E : r &= mA(I.NE(),I.E(),I.SE(),I.N(),I.S(),I.NO(),I.SO(),I.ONO(),I.OSO()); break;
			case K.M : r &= mA(I.NO(),I.SO(),I.NE(),I.SE());break;
			}	
		
		return r;
	}
	
	// Resol : resol el puzzle 
	public boolean Resol(){
	
		boolean r = true;
	
		while(r){ // Si alguna tecnica te algun efecte, r = true
	
			r = false;
			r |= AiguaxSumes(); 		
			r |= PatronsAigua();
			r |= SolidxIndeterminats();
			r |= MarcaSolids();
			r |= MarcaExtrems();
			r |= HadeserAigua();			
		}				
															
		return Resolt();						
	}		
	
	// Resolt : torna les comprobacions de coherencia
	public boolean Resolt(){
		return ComprobaChocs()&&ComprobaSumes()&&ComprobaVaixells(); 
	}
}
