import java.util.Arrays;

public class Posicions {
	Posicio[]p;	
	public Posicions(){p=new Posicio[]{new Posicio(0,0,false)};}	
	public Posicions(Posicio[]t){p=Arrays.copyOf(t,t.length);}		
	public void add(Posicio n){p=Arrays.copyOf(p,p.length + 1);p[p.length-1]=new Posicio(n.i,n.o);}	
	public Posicio r(){if(p.length>0)return p[0];else{System.out.printf("NULL r()");return null;}}	
	public void remove(int i){System.arraycopy(p,i+1,p,i,p.length-i-1);p = Arrays.copyOf(p,p.length-1);}
	public void remove(int[]A){for(int i=0;i<A.length;i++){A[i]-=i;remove(A[i]);}}		
	public void remove(Posicio r){remove(indexsOf(r));}	
	public void remove(Index I,boolean h){remove(new Posicio(I,h));}			
	public void remove(Index I){remove(new Posicio(I,true));remove(new Posicio(I,false));}			
	public void remove(int x,int y,boolean h){remove(new Posicio(x,y,h));}		
	public void removeall(){while(p.length>0)remove(0);}	
	public void removecross(Index I,int L){removesegment(I,k.v,L);removesegment(I,k.h,L);}	
	public void removesegment(Index I,boolean h,int L){for(int l=0;l<L;l++)remove(new Posicio(new Posicio(I,h).J(-l),h));}	
	public int indexOf(Posicio r){int ret=-1;for(int i=0;i<p.length;i++)if(r.e(p[i]))return i;return ret;}	
	public int[] indexsOf(Posicio r){int[]ret={};for(int i=0;i<p.length;i++)if(p[i].e(r)){ret=Arrays.copyOf(ret,ret.length+1);ret[ret.length-1]=i;}return ret;}		
	public String toString(){String ret="";for(int i=0;i<p.length;i++)ret+="("+p[i].i.x+","+p[i].i.y+","+(p[i].o==k.v?'|':'-')+")\n";return ret;}	
	public String toStringGrid(){int mx=0,my=0;for(int n=0;n<p.length;n++){if(p[n].i.x>mx)mx=p[n].i.x;if(p[n].i.y>my)my=p[n].i.y;}return toStringGrid(mx+1,my+1);}	
	public String toStringGrid(int mx,int my){String ret="";char[][]h=new char[mx+1][my+1];char[][]v=new char[mx+1][my+1];for(int n=0;n<p.length;n++)if(p[n].o==k.h)h[p[n].i.x][p[n].i.y]='-';
	else v[p[n].i.x][p[n].i.y]='|';ret+="· ";for(int i=0;i<mx;i++)ret+=i;ret+="  ";for(int i=0;i<mx;i++)ret+=i;ret+="\n";for(int j=0;j<my;j++){ret+=j+" ";for(int i=0;i<mx;i++)ret+=h[i][j]==
	'-'?'_':'.';ret+="  ";for(int i=0;i<mx;i++)ret+=v[i][j]=='|'?'|':'.';ret+="\n";}return ret;}
}
