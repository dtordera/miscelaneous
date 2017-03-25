package exercicisUnitat2;

public class Disco extends Multimedia {
	
	private String Genero;
	
	Disco(String pTitulo,String pAutor,int pDuracion,String pGenero){
		super(pTitulo,pAutor,pDuracion);
		this.setGenero(pGenero);
	}
	
	public String toString(){
		return super.toString() + "Género : " + this.getGenero() + '\n';	
	}
	
	public String getGenero(){
		return this.Genero;
	}
	
	public void setGenero(String pGenero){
		this.Genero = pGenero;
	}
}
