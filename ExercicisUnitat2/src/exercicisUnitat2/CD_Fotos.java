package exercicisUnitat2;

public class CD_Fotos extends Multimedia {
	
	private int numFotos;
	
	CD_Fotos(String pTitulo, String pAutor, int pDuracion, int pnumFotos){
		super(pTitulo,pAutor,pDuracion);
		this.setnumFotos(pnumFotos);
	}
	
	public String toString(){
		return super.toString() + "Num. fotos : " + this.getnumFotos() + '\n';
	}
	
	public int getnumFotos(){
		return numFotos;
	}
	
	public void setnumFotos(int pnumFotos){
		this.numFotos = pnumFotos;
	}

}
