public class Puzzle {
	Grid g;
	CI[] I;
	int[]B,SR,SC;
	boolean r;
	
	public Puzzle(int[] sr,int[] sc,CI[] i,int[] b){SR=sr.clone();SC=sc.clone();B=b.clone();g=new Grid(sr.length,sc.length);CIs(i);}		
	public String toString(){String r="";for(int i=1;i<B.length;i++){ for(int j=0;j<i;j++) r+="X"; r+=" x"+B[i]+"\n";}return g.toString(SC,SR)+"\n"+r+"\n__________________________\n";}
	public void CIs(CI[] i){for(int n=0;n<i.length;n++)g.dP(i[n].v,i[n].x,i[n].y);}

	public Cella C(int x,int y){return g.c(x,y);}
	public Cella C(Index i){return g.c(i.x,i.y);}
	public int P(int x,int y){return g.c(x,y).uP();}
	public int B(int x,int y){return g.c(x,y).uB();}
	
	public boolean IND(int x,int y){return g.c(x,y).IND();}
	public boolean AIG(int x,int y){return g.c(x,y).AIG();}
	public boolean AIG(Index i){return g.c(i.x,i.y).AIG();}	
	public boolean ALG(int x,int y){return g.c(x,y).ALG();}	
	public int SIC(int j){return g.SIC(j);}
	public int SIR(int i){return g.SIR(i);}
	public int SAC(int j){return g.SAC(j);}
	public int SAR(int i){return g.SAR(i);}	
		
	public void dAIGxCAP(int x,int y){g.dAIGxCAP(x,y,SC[y],SR[x]);}
	public void dALGxCAP(int x,int y){g.dALGxCAP(x,y,SC[y],SR[x]);}
}
