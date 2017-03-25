//
//	Clase Dato: registro
//	id : identificador, independiente del indice de la lista
//  información : "bulk data", formateada mediante la constante _separador_. Se rellenan los campos de 
//				  las clases heredadas mediante la información en este campo.

package Datos;

public class Dato {
	
	final public static String _separador_ = "//"; // separador de formato
	
	int id;				// identificador
	String informacion; // información
	
	// Constructor
	Dato(int pid, String pinformacion){
		this.setId(pid);
		this.setInformacion(pinformacion);
	}
	
	// Metodos de acceso a variables
	public void setId(int pid){
		this.id = pid;
	}
	
	public void setInformacion(String pInformacion){
		this.informacion = pInformacion;
	}
	
	public int getId(){
		return this.id;
	}
	
	public String getInformacion(){
		return this.informacion;
	}
}
