package dvtr.logicgames.yubotu;

public class Vaixell {
	int L;
	Index ro,rf;
	
	public Vaixell(int l){
		L=l;
		ro = new Index(-1,-1);
		rf = new Index(-1,-1);		
	}
	
	public String toString(){
		String r="";
			
		for (int i=0;i<L;i++)
			r+= L==1?K.REPR[K.B+1]:i==0?K.REPR[K.O+1]:i==L-1?K.REPR[K.E+1]:K.REPR[K.X+1];			
		
		return r;
	}
	
	public boolean det(){return ro.x!=-1;}
}
