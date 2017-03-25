import java.util.Arrays;
import java.util.Collections;


public class Posicions {
	Posicio[] P;
	
	public Posicions(Posicio[] l){
		P = Arrays.copyOf(l,l.length);
	}
	
	public Posicions(){
		P = new Posicio[0];
	}
	
	public Posicions(Posicio p){
		P = new Posicio[1];
		P[0] = new Posicio(p);
	}
	
	public Posicions(byte C,byte R){
	
		P = new Posicio[2*C*R];
		
		for (byte j=0;j<R;j++)
		for (byte i=0;i<C;i++)
		{
			P[2*(j*C+i)] = new Posicio(i,j,K.HOR);
			P[2*(j*C+i)+1] = new Posicio(i,j,K.VER);
		}
	}
	
	public String toString(){
		String s="";
		
		for (Posicio p:P)
		s += p.toString() + "\n";
		
		return s; 		
	}	
	
	
	public void add(int i,int j,boolean h){
		add(new Posicio((byte)i,(byte)j,h));
	}
	
	public void add(Posicio r){
		if (indexOf(r)==-1) {
			
			P = Arrays.copyOf(P,P.length+1);
			P[P.length-1] = r;
		}	
	}
	
	public void add(Posicio...r){
		for (Posicio p:r) add(p);
	}
	
	public boolean mateixoselements(Posicions p){
	
		if (p.quantitat() != quantitat()) return false;
		
		boolean r = true;
			
		for (Posicio q:P)   r &= p.indexOf(q) != -1;									
		for (Posicio q:p.P)	r &= indexOf(q) != -1;
		
		return r;
	}
	
	public void neteja(){
		P = new Posicio[0];
	}
	
	public int indexOf(Posicio r){
				
		for (int n=0;n<P.length;n++)
			if (r.equals(P[n])) return n;
			
		return -1;			
	}
	
	public int quantitat(){
		return P.length;
	}
	
	public void Compacta(){
		Posicions S = new Posicions(P);
		
		for (Posicio p:P) S.remove(p.x,p.y,K.VER);
		
		P = Arrays.copyOf(S.P,S.P.length);		
	}
	
	public Posicions Shuffle(){	

		Posicio[] S	=Arrays.copyOf(P,P.length);		
		Collections.shuffle(Arrays.asList(S));
	
		return new Posicions(S);
	}
	
	public Posicio r(){	
		return quantitat()==1?P[0]:null;	
	}
	
	public void remove(int i,int j,boolean h){
		remove(new Posicio((byte)i,(byte)j,h));
	}
			
	public void remove(int i,int j){
		remove(new Posicio((byte)i,(byte)j,K.HOR));
		remove(new Posicio((byte)i,(byte)j,K.VER));
	}
	
	public void remove(Posicio r){	
		int n = indexOf(r);
			
		if (n!=-1){
			for (int m=n;m<P.length-1;m++)
				P[m] = P[m+1];
			
			P = Arrays.copyOf(P,P.length-1);
		}
	}
		
	public void treu(int i,int j,byte L){
		L--;
		for (byte n=L;n!=0;n--)
		{
			remove(i-n,j,K.HOR);
			remove(i,j-n,K.VER);
		}
	}
	
}