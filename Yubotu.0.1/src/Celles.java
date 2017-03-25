import java.util.Arrays;

public class Celles {
	public Cella[]c={};
	public Celles(Cella[]l){c=Arrays.copyOf(l,l.length);}
	public int v(int i){return c[i].v;}	
	public Index i(int i){return c[i].i;}
	public int C(int x,int y){int ret=k.x;for(int i=0;i<c.length;i++)if((c[i].i.x==x)&&(c[i].i.y==y))ret=v(i);return ret;}
}
