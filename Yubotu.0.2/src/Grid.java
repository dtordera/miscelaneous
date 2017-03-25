
public class Grid {
	int C,R;
	Cella [][]G;
	
	public Grid(int c,int r){C=c;R=r;G=new Cella[C][R];for (int i=0;i<C;i++){G[i]=new Cella[R];for(int j=0;j<R;j++)G[i][j]=new Cella();}}
	
	public Cella c(int x,int y){if((x<0)||(x>=C)||(y<0)||(y>=R))return new Cella(k.AIG);else return G[x][y];}
	public Cella c(Index i){return c(i.x,i.y);}
	
	public String s(){String ret="";for(int j=0;j<R;j++){for(int i=0;i<C;i++)ret+=c(i,j).s()+" ";ret+="\n";} return ret;}
	public String toString(){String r="";for (int j=0;j<R;j++){for(int i=0;i<C;i++)r+=c(i,j).s()+" ";r+=" "+SIC(j)+" "+SAC(j)+"\n";}r+="\n";
	for(int i=0;i<C;i++)r+=SIR(i)+" ";r+="\n";for(int i=0;i<C;i++)r+=SAR(i)+" ";r+="\n";return r;}
	
	public String toString(int[]SC,int[]SR){String r="";for (int j=0;j<R;j++){for(int i=0;i<C;i++)r+=c(i,j).s()+" ";r+=" "+SC[j]+" "+SAC(j)+" "+SIC(j)+"\n";}r+="\n";
	for(int i=0;i<C;i++)r+=SR[i]+" ";r+="\n";for(int i=0;i<C;i++)r+=SAR(i)+" ";r+="\n";for(int i=0;i<C;i++)r+=SIR(i)+" ";r+="\n";return r;}
	
	public boolean IND(int x,int y){return c(x,y).IND();}
	public boolean IND(Index i){return c(i.x,i.y).IND();}
	public boolean ALG(int x,int y){return c(x,y).ALG();}	
	public boolean ALG(Index i){return c(i.x,i.y).ALG();}
	public boolean AIG(int x,int y){return c(x,y).AIG();}
	public boolean AIG(Index i){return c(i.x,i.y).AIG();}
	public boolean DET(int x,int y){return c(x,y).DET();}
	public boolean DET(Index i){return c(i.x,i.y).DET();}		
	
	public void nP(Index i,int...d)
	{
		c(i).nP(d);		
//		if (c(i).uP()!=-1) dP(c(i).uP(),i);
	}
	
	public void A(Index...i){dP(k.A,i);}
	
	public void G(Index...i){for(Index I:i)G(I);}
	public void G(Index i){c(i).G();A(i.NO(),i.SO(),i.NE(),i.SE());}
	
	public void dP(int v,Index...i){for(Index I:i)dP(I.x,I.y,v);}	
	public void dP(int v,Index i){dP(v,i.x,i.y);}	
	public void dP(int v,int x,int y)
	{
		if (c(x,y).DET()||c(x,y).AIG()) return;
		c(x,y).d(v);				
	
		Index I = new Index(x,y),
		N = I.N(),
		S = I.S(),
		E = I.E(),
		O = I.O(),
		NO = I.NO(),
		SO = I.SO(),
		NE = I.NE(),
		SE = I.SE();				
	
		switch(v){
		case k.A: nP(N,k.N);nP(S,k.S);nP(E,k.E);nP(O,k.O);break;
		case k.B: A(NO,N,NE,O,E,SO,S,SE);break;
		case k.N: A(NO,N,NE,O,E,SO,SE,SO.S(),SE.S());
				  nP(S,k.N,k.E,k.O);nP(S.S(),k.N,k.E,k.O);break;
		case k.S: A(SO,S,SE,O,E,NO,NE,NO.N(),NE.N());
				  nP(N,k.S,k.E,k.O);nP(S.S(),k.S,k.E,k.O);break;
		case k.E: A(NO.O(),NO,N,NE,E,SO.O(),SO,S,SE);
				  nP(O,k.S,k.N,k.E);nP(O.O(),k.S,k.N,k.E);break;
		case k.O: A(NO,N,NE,NE.E(),O,SO,S,SE,SE.E());
				  nP(E,k.S,k.N,k.O);nP(E.E(),k.S,k.N,k.O);break;
		case k.X: A(NO,NE,SO,SE);
				  if(AIG(N)) {A(S);G(E,O);}
				  if(AIG(S)) {A(N);G(E,O);}
				  if(AIG(O)) {A(E);G(N,S);}
				  if(AIG(E)) {A(O);G(N,S);}				  
				  break;
		}
	}
	
	public int SIC(int j){int r=0;for(int i=0;i<C;i++)r+=IND(i,j)?1:0;return r;}
	public int SIR(int i){int r=0;for(int j=0;j<R;j++)r+=IND(i,j)?1:0;return r;}
	public int SAC(int j){int r=0;for(int i=0;i<C;i++)r+=ALG(i,j)?1:0;return r;}
	public int SAR(int i){int r=0;for(int j=0;j<R;j++)r+=ALG(i,j)?1:0;return r;}	
		
	public void dAIGxCAP(int x,int y,int SC,int SR){if (IND(x,y)&&((SR==SAR(x))||(SC==SAC(y)))) c(x,y).A();}
	public void dALGxCAP(int x,int y,int SC,int SR){if (IND(x,y)&&((SR-SAR(x)==SIR(x))||(SC-SAC(y)==SIC(y)))) c(x,y).G();}
}
