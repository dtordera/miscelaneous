// Clase Mostrades : celles inicials. Un index i un valor.

package comu;

public class Mostrades extends Index {
	public byte v;
	
	public Mostrades(int i,int j,byte c){super(i,j);v=c;}	
	public Mostrades(Index I,byte c){super(I);v=c;}
}
