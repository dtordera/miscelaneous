// Clase Cliente. Tipo de dato
//

package Datos;

public class Cliente extends Dato {
	
	// Constantes de identificación de campo	
	final static int NOMBRE = 0;
	
	// Constructor. Los datos iniciales son irrelevantes.
	public Cliente(){
		super(0,"");
	}
	
	// Objeto a string
	public String toString() {
		return getId() + "\t" + getNombre();
	}	
	
	// Acceso a la informacion del dato
	public void setNombre(String pNombre) {
		this.informacion.split(_separador_)[NOMBRE] = pNombre;
	}
	
	public String getNombre() {
		return this.informacion.split(_separador_)[NOMBRE];
	}
}
