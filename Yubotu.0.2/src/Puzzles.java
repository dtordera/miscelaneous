import java.util.Arrays;

public class Puzzles {
	Puzzle[] P;
	public Puzzles(Puzzle Po){P=new Puzzle[1];P[0]=Po;}	
	public void a(Puzzle n){P=Arrays.copyOf(P,P.length+1);P[P.length-1]=n;}	
	public void d(){P=Arrays.copyOf(P,P.length-1);}
	public Puzzle u(){return P[P.length-1];}
}
