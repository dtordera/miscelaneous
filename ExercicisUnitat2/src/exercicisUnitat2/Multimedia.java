package exercicisUnitat2;

public class Multimedia {
	
	// Variables
	
	private String 	Titulo,
					Autor;
	private int		Duracion; // Duracion en minutos
	
	// Constructor
	Multimedia(String pTitulo, String pAutor, int pDuracion) {
		this.Titulo = 	pTitulo;
		this.Autor  = 	pAutor;
		this.Duracion = 	pDuracion;
	}
			
	// To string
	public String toString(){
		return "\nTitulo : " + getTitulo() + "\n" + 
			   "Autor : " + getAutor() + "\n" + 
			   "Duracion : " + (Duracion/60) + ':' + (Duracion%60) +'\n';
	}
	
	// comparacion
	public boolean equals(Multimedia multimedia){
		return ((Titulo == multimedia.getTitulo()) && (Autor == multimedia.getAutor()));
	}
	
	// Gets
	
	public String getTitulo(){
		return Titulo;
	}
	
	public String getAutor(){
		return Autor;
	}
	
	public int getDuracion(){
		return Duracion;
	}

	// Sets
	
	public void setTitulo(String pTitulo){
		Titulo = pTitulo;
	}
	
	public void setAutor(String pAutor){
		Autor = pAutor;
	}
	
	public void setDuracion(int pDuracion){
		Duracion = pDuracion;
	}
}
 