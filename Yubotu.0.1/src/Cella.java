
public class Cella {

	public static char BUIT = 255;	
	Index i=new Index(0,0);
	char v;	
	public Cella(int x,int y,char j){i.x=x;i.y=y;v=j;}	
	public Cella(Index I,char j){i.x=I.x;i.y=I.y;v=j;}	
	public Cella(Index I){i.x=I.x;i.y=I.y;v=BUIT;}	
	public Cella(int x,int y){i.x=x;i.y=y;v=BUIT;}
}
