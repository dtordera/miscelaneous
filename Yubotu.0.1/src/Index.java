
public class Index {
	public int x,y;	
	public Index(int i,int j){x=i;y=j;}	
	public boolean e(Index i){return((x==i.x)&&(y==i.y));}
	public Index d(int i,int j){return new Index(x+i,y+j);}	
	public boolean a(Index i,Index j){return ((x >= i.x) && (x <= j.x) && (y >= i.y) && (y <= j.y));}
}
