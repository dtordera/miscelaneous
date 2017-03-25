import java.util.Arrays;;

public class mSet {

	int []v;
	
	public mSet(int[]V){v=Arrays.copyOf(V,V.length);}
	public void a(int d){v=Arrays.copyOf(v,v.length+1); v[v.length-1]=d;}
	public int i(int d){for(int i=0;i<v.length;i++)if(d==v[i]) return i;return -1;}
	public void d(int d){int[]A=Arrays.copyOf(v,v.length-1);for(int i=i(d);i<v.length-1;i++)A[i]=v[i+1];
	v=Arrays.copyOf(A,A.length);}
	public void b(){v=new int[0];}
	public int[] toArray(){return v;}
	public String toString(){String r="";for(int i=0;i<v.length;i++)r+=v[i]+" ";return r;}
}
