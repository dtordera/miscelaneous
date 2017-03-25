
public class Index {
	public int x,y;
	
	public Index(int i,int j){x = i;y = j;}
	public boolean e(int i,int j){return e(new Index(i,j));}
	public boolean e(Index I){return ((I.x==x)&&(I.y==y));}
	public boolean a(Index i,Index f) {return((x>=i.x)&&(x<=f.x)&&(y>=i.y)&&(y<=f.y));}
	public Index N(){return new Index(x,y-1);}
	public Index S(){return new Index(x,y+1);}
	public Index E(){return new Index(x+1,y);}
	public Index O(){return new Index(x-1,y);}
	public Index NE(){return new Index(x+1,y-1);}
	public Index NO(){return new Index(x-1,y-1);}
	public Index SE(){return new Index(x+1,y+1);}
	public Index SO(){return new Index(x-1,y+1);}
}
