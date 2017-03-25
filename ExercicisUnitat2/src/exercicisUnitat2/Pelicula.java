package exercicisUnitat2;

public class Pelicula extends Multimedia {
	
	private String actorPrincipal;
	
	Pelicula(String pTitulo, String pAutor, int pDuracion, String pactorPrincipal){
		super(pTitulo,pAutor,pDuracion);
		this.setactorPrincipal(pactorPrincipal); 
	}
	
	public String toString(){
		return super.toString() + "Actor principal : " + actorPrincipal +'\n';
	}
	
	public String getactorPrincipal(){
		return actorPrincipal;
	}
	
	public void setactorPrincipal(String pactorPrincipal){
		this.actorPrincipal = pactorPrincipal;
	}
}
	


