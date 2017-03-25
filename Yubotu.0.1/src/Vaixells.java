public class Vaixells {
	Vaixell[]v;	
	public Vaixells(char[]V){v=new Vaixell[V.length];for(int i=0;i<v.length;i++)v[i]=new Vaixell(V[i]);}
	public String toString(){String ret="";for(int i=0;i<v.length;i++)ret+="v["+i+"] : L="+(int)v[i].L+"; D= "+(v[i].D)+"; P = "+v[i].P.toString();return ret;}	
	public boolean AD(){boolean ret=true;for(int i=0;i<v.length;i++)ret=ret&&v[i].D;return ret;}	
	
	public void Def(int l,Index i,boolean o){
		for(int n=0;n<v.length;n++)
		if((!v[n].D)&&(v[n].L==l)) 
		{ 							
			v[n].D = true; 						
			v[n].P = new Posicions(new Posicio[] { new Posicio(i,o)});
			for (int s=0;s<l;s++)
				No(v[n].P.r().J(s));
				
			break;				
		}								
	}
		
	public void Def(int l,Posicio r){Def(l,r.i,r.o);}
	
	public void NoI(Index i){// eliminem de tots els vaixells 
		for (int n=0;n<v.length;n++)
			if (!v[n].D) // els determinats no els considerem		
				v[n].P.remove(i);
				
		cD();
	}
	
	public void NoI(Index i,int L){ // eliminem com a inici dels vaixells l
		for (int n=0;n<v.length;n++)
			if (!v[n].D) 
			if (v[n].L == L) v[n].P.remove(i);			
	}
		
	public void No(Index i){	// eliminem totes les combinacions que tenen i				
	
		for (int n=0;n<v.length;n++)
			if (!v[n].D) // els determinats no els considerem		
			v[n].P.removecross(i,v[n].L);
			
		cD();
	}
	
	public void No(Index i,int L){ // eliminem combinacions per tipus de barco
		for (int n=0;n<v.length;n++)
			if (!v[n].D) // els determinats no els considerem		
			if (v[n].L == L) v[n].P.removecross(i,v[n].L);
			
		cD();
	}
	
	public int C(int x,int y){
		
		for (int i=0;i<v.length;i++)
		if (v[i].D)
		{
			Index   r = v[i].P.r().i,
					j = v[i].P.r().J(v[i].L-1),
					n = new Index(x,y);
					
			boolean b = v[i].P.r().o;			
			
			return r.e(n)&&j.e(n)?k.B : n.e(r)? (b==k.h?k.O:k.N) : n.e(j)? (b==k.h?k.E:k.S) : n.a(r,j)? k.P : n.a(r.d(-1,-1),j.d(1,1))? k.A : k.x;
		}	
		return k.x;
	}
	
	public void cD(){
		int L = 0;	
		for (int i=0;i<v.length;i++)
			if (!v[i].D) L = L > v[i].L? L : v[i].L;
			
		int[] N = new int[L];
							
		for (int i=0;i<v.length;i++) 
		if (!v[i].D) N[v[i].L-1]++;
						
		for (int i=0;i<v.length;i++)
			if (!v[i].D)		
				if (v[i].P.p.length == N[v[i].L-1]) 
					for (int j=0;j<N[v[i].L-1];j++)
						Def(v[i].L,v[i].r());
	}
}
