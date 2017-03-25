// Clase Posicio : index amb orientacio

package shipmodel;

import comu.Index;

public class Posicio extends Index {
	boolean o;
	
	public Posicio(byte i, byte j, boolean h){super (i,j);o=h;}	
	public Posicio(Posicio p){x=p.x;y=p.y;o=p.o;}	
	public String toString(){return "("+x+","+y+","+(o?"-":"|")+")";}	
	public boolean equals(Posicio r){return (x==r.x&&y==r.y&&o==r.o);}
		
	// J : projeccio a distancia L segons orientacio
	public Index J(byte L){return o? new Index(x+L-1,y):new Index(x,y+L-1);}
}