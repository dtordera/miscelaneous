import java.util.Arrays;

public class set_ {

	private int []v;
	
	public set_(){v=new int[0];}
	public set_(int[]V){v=Arrays.copyOf(V,V.length);}
	public void a(int d){fg(); v[v.length-1]=d;}
	public int  i(int d){for(int i=0;i<v.length;i++)if(d==v[i]) return i;return -1;}
	public void d(int d){if (i(d)==-1) return;int[]A=Arrays.copyOf(v,v.length-1);for(int i=i(d);i<v.length-1;i++)A[i]=v[i+1];v=Arrays.copyOf(A,A.length);}
	public void b(){v=new int[0];}
	public int  u(){if(l()!=1)return-1;else return v[0];}
	public void u(int...d){b();for(int t:d)a(t);};
	public int  l(){return v.length;}
	public void s(int d){b();a(d);}
	public int[] toArray(){return v;}
	public String toString(){String r="";for(int i=0;i<v.length;i++)r+=v[i]+" ";return r;}
	private void fg(){if(v==null)v=new int[1];else v=Arrays.copyOf(v,v.length+1);}
}
