import java.util.ArrayList;


public class TestArrayList {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
			ArrayList<Index>I=new ArrayList<Index>();
			
			for (int i=0;i<5;i++)
			for (int j=0;j<5;j++)
				I.add(new Index(i,j));
				
			for (Index i:I){
			System.out.println(I.indexOf(i)+ ":" + i.x + " , " + i.y);
			}			
			
			I.remove();
			
			System.out.println("ELiminat 0,3");
			
			for (Index i:I){
			System.out.println(I.indexOf(i)+ ":" + i.x + " , " + i.y);
			}						
	}
	
	public static class Index {
		public int x,y;		
		
		public Index(int i,int j){
		x=i;y=j;
		}
	}
}

