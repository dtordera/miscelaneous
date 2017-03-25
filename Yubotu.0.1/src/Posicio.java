
public class Posicio {
	Index i;
	boolean o;	
	public Posicio(int x,int y,boolean h){i=new Index(x,y);o=h;}	
	public Posicio(Index I, boolean h){i=new Index(I.x,I.y);o=h;}		
	public boolean e(Posicio p){return ei(p)&&eo(p);}	
	public boolean ei(Posicio p){return(p.i.x==i.x)&&(p.i.y==i.y);}	
	public boolean eo(Posicio p){return(p.o==o);}	
	public void p(int x,int y,boolean k){i.x=x;i.y=y;o=k;}	
	public void p(Index I,boolean k){p(I.x,I.y,k);}	
	public Index J(int l){return J(l,o);}	
	public Index J(int l,boolean h){return new Index(i.x+l*(h==k.h?1:0),i.y+l*(h==k.v?1:0));}
}
