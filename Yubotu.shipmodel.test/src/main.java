

public class main {

	public static void main(String[] args) {
		
		/*byte[] SR = {0,3,3,1,1,3,0,1,5,3};
		byte[] SC = {1,4,3,0,2,3,1,4,1,1};
		byte[] Fs = {4,3,3,2,2,2,1,1,1,1};
		CondicionsInicials[] CI = { new CondicionsInicials(1,0,K.A),
								    new CondicionsInicials(1,2,K.A),
								    new CondicionsInicials(5,1,K.A),
								    new CondicionsInicials(5,4,K.B),
								    new CondicionsInicials(3,5,K.E),
								    new CondicionsInicials(8,8,K.X)};		
		
		new ResoledorPuzzle(SR,SC,CI,Fs).Resol();
		
		
/*byte[] SR = {1,1,1};
		byte[] SC = {2,0,1};
		byte[] Fs = {2,1};
		CondicionsInicials[] CI = { new CondicionsInicials(2,0,K.A)};
		
		new ResoledorPuzzle(SR,SC,CI,Fs).Resol();*/
		
/*		byte[] SR = {2,2,2,3,3,2,1,3,2};
		byte[] SC = {2,1,4,1,4,1,2,5,0};
		byte[] Fs = {4,3,3,2,2,2,1,1,1,1};
		CondicionsInicials[] CI = {new CondicionsInicials(1,2,K.B),
								   new CondicionsInicials(5,2,K.A),
								   new CondicionsInicials(3,4,K.X),
								   new CondicionsInicials(7,3,K.S),
								   new CondicionsInicials(6,5,K.B)};
								   
		new ResoledorPuzzle(SR,SC,CI,Fs).Resol();*/
		
/*		byte[] SR = {1,1,2,1,0,2,3,2,3,5};
		byte[] SC = {2,3,1,1,5,0,4,0,4,0};
		byte[] Fs = {4,3,3,2,2,2,1,1,1,1};
		CondicionsInicials[] CI = {new CondicionsInicials(2,1,K.E),
								   new CondicionsInicials(6,3,K.B),
								   new CondicionsInicials(8,6,K.E),
								   new CondicionsInicials(5,8,K.B)};
								   
		new ResoledorPuzzle(SR,SC,CI,Fs).Resol();*/
		
		/*byte[] SR = {2,2,1,2,3,1,3,1,4,1};
		byte[] SC = {0,4,1,3,2,1,2,0,5,2};
		byte[] Fs = {4,3,3,2,2,2,1,1,1,1};
		CondicionsInicials[] CI = {new CondicionsInicials(3,1,K.X),
								   new CondicionsInicials(0,4,K.B),
								   new CondicionsInicials(3,5,K.B),
								   new CondicionsInicials(6,6,K.O),
								   new CondicionsInicials(1,8,K.A)};
								   
		new ResoledorPuzzle(SR,SC,CI,Fs).Resol();*/
		
/*		byte[] SR = {0,1,1,2,3,3,3,2,2,3};
		byte[] SC = {5,0,3,0,2,3,1,1,0,5};
		byte[] Fs = {4,3,3,2,2,2,1,1,1,1};
		CondicionsInicials[] CI = {new CondicionsInicials(6,0,K.A),
								   new CondicionsInicials(4,4,K.A),
								   new CondicionsInicials(7,5,K.X),
								   new CondicionsInicials(1,9,K.B),
								   new CondicionsInicials(6,9,K.E),
								   };
								   
		new ResoledorPuzzle(SR,SC,CI,Fs).Resol(0);		
		new ResoledorPuzzle(SR,SC,CI,Fs).Resol(1);*/
		
//		new FactoriaPuzzle().Genera(6,6,new byte[] {3,2,1,1});//,new byte[] {4,3,3,2,2,2,1,1,1,1});
//		new FactoriaPuzzle().Genera(10,10,new byte[] {4,3,3,2,2,2,1,1,1,1});

		byte[] SR = {4,1,1,1,1,1,3,1,5,2};
		byte[] SC = {1,3,2,2,1,5,2,1,0,3};
		byte[] Fs = {4,3,3,2,2,2,1,1,1,1};
		CondicionsInicials[] CI = {new CondicionsInicials(1,1,K.B),
								   new CondicionsInicials(4,2,K.B),
								   new CondicionsInicials(9,3,K.B),
								   };
								   
		ResoledorPuzzle RP = new ResoledorPuzzle(SR,SC,CI,Fs);

		System.out.println(RP.Resol(0));
		RP.toScreenGrid(RP.S[0]);	

	}
}

