package dvtr.logicgames.yubotu;

public class Main {
	public static void main(String[] args) {
	
//		int[] F = {5,4,4,3,3,3,2,2,2,2,1,1,1,1,1};
		int[] F = {4,3,3,2,2,2,1,1,1,1};
	
		Puzzle P =new FactoriaPuzzle(10,10,F,true).Genera();
		System.out.println(P.toString());
		System.out.println();
		System.out.println(P.Resol().toString());
		
//		System.out.println(Logic159.Pz(8).Resol().toString());
//		System.out.println(Logic259.Pz(6).Resol().toString());
//		System.out.println(YubotuFree.Pz(7).Resol().toString());
    }
}
