
public class Cella {
	private int d = k.IND;
	private set_ P,B;
	
	public Cella(){P=new set_(k.defP);B=new set_(k.defB);d=k.IND;}
	public Cella(int p){P=new set_(k.defP);B=new set_(k.defB);d=k.IND;d(p);}	
	public void nP(int...d){for(int t:d)P.d(t);}
	public void nB(int...v){for(int t:v)B.d(t);}
	
	public int uP(){return P.u();}
	public int uB(){return B.u();}		
	
	public void d(int t){switch(t){case k.A:d=k.AIG;P.b();B.b();break;case k.N:case k.S:case k.E:case k.O:case k.X:d=k.SEG;P.u(t);break;case k.B:d=k.CMP;P.u(k.B);B.u(k.SUB);break;}}		
	public String s(){switch (d){case k.IND:return""+k.r[k.rI];case k.AIG:return""+k.r[k.rA];case k.SLD:return""+k.r[k.rS];case k.SEG:case k.CMP:
	return""+k.r[P.u()+k.rA];default:return"";}}
	public boolean IND(){return d==k.IND;}
	public boolean ALG(){return d>k.AIG;}
	public boolean AIG(){return d==k.AIG;}
	public boolean DET(){return d>k.SLD;}
	public boolean kS(){return P.u()==k.S;}
	public boolean kN(){return P.u()==k.N;}
	public boolean kO(){return P.u()==k.O;}
	public boolean kE(){return P.u()==k.E;}
	public boolean kB(){return P.u()==k.B;}
	
	public void A(){d(k.A);}
	public void S(){d=k.SEG;}
	public void G(){d=k.SLD;}
}
