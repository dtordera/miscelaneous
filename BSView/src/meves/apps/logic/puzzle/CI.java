package meves.apps.logic.puzzle;


public class CI {
	public Index i;
	byte  v;
	
	public CI(int x,int y,byte g){i=new Index(x,y);v=g;}
	public CI(Index j,byte g){i=j;v=g;}
}
