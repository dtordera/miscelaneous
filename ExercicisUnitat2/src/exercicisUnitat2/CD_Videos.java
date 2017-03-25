package exercicisUnitat2;

public class CD_Videos extends Multimedia {
	
	private int numVideos;
	
	CD_Videos(String pTitulo, String pAutor, int pDuracion, int pnumVideos){
		super(pTitulo,pAutor,pDuracion);
		this.setnumFotos(pnumVideos);
	}
	
	public String toString(){
		return super.toString() + "Num. videos : " + this.getnumVideos() + '\n';
	}
	
	public int getnumVideos(){
		return numVideos;
	}
	
	public void setnumFotos(int pnumVideos){
		this.numVideos = pnumVideos;
	}
}
