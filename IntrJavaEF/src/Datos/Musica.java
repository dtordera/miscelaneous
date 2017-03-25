//
//	Clase Musica. Tipo de dato.
//

package Datos;

public class Musica extends Dato {
		
	// Constantes de identificación de campo	
	final static int FORMATO = 0;	
	final static int TITULO = 1;	
		
	// Constructor. Los valores iniciales son irrelevantes
	public Musica(){
		super(0,"(nulo)"+_separador_+"(nulo)");
	}
	
	// Objeto a string
	public String toString() {
		return this.getId() + "\t" + this.getFormato() + "\t" + this.getTitulo();
	}
	
	// Acceso a Dato.Informacion
	public void setTitulo(String pTitulo){
		this.informacion.split(_separador_)[TITULO] = pTitulo;
	}
	
	public void setFormato(String pFormato){
		this.informacion.split(_separador_)[FORMATO] = pFormato;
	}
	
	public String getFormato() {
		return this.informacion.split(_separador_)[FORMATO];
	}
	
	public String getTitulo() {
		return this.informacion.split(_separador_)[TITULO];
	}
}
