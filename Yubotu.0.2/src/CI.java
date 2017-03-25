public class CI {
	public int x,y,v;
	public CI(int i,int j,int g){x=i;y=j;v=g;}
	public Index i(){return new Index(x,y);}
}
