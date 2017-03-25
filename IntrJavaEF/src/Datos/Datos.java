//
//	Datos : Lista de datos. No se usa ArrayList por simplicidad, al usar como referencia el id de dato,
// 	y para tener más control de la lista.
//

package Datos;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.util.Arrays;

@SuppressWarnings("unchecked")
public class Datos {
	
	public Dato[] Lista;	// Array de datos
	public Class TipoDatos; // Tipo de los datos, usado para crear un nuevo registro en el método Nuevo
	
	// Constructor: se crea la lista y se crea la clase de tipo de datos segun el nombre pasado
	public Datos(String pTipoDatos) throws ClassNotFoundException{
		Lista = new Dato[0];
		TipoDatos = Class.forName(pTipoDatos);
	}
	
	// Cantidad de registros
	public int Cantidad() {
		return Lista.length;
	}
	
	// Recapacita el array e inserta un nuevo dato en la lista
	public void Nuevo(Dato d) {
		Lista = Arrays.copyOf(Lista,Lista.length+1);
		Lista[Lista.length-1] = d;	
		OrdenaPorId();
	}
	
	// Encuentra el primer id libre en la lista
	public int NuevoId() {
		int id = 0;
		
		while (DatoSegunId(id) != null) id++;
		
		return id;
	}
	
	// Elimina un registro segun un identificador dado
	public boolean EliminaId(int id) {
		int i,j;
		boolean result = false;
		
		for (i=0;i<Cantidad() && !(result=Lista[i].id == id);i++);

		// Si se ha encontrado, se mueven todos los posteriores 
		if (result) {
			
			for (j=i;j<Cantidad()-1;j++)
				Lista[j] = Lista[j+1];
		
			// se recapacita la lista
			Lista = Arrays.copyOf(Lista,Lista.length-1);
		}
		
		// devuelve false si no se ha encontrado ese id
		return result;
	}
	
	// Devuelve un registro dado su identificador
	public Dato DatoSegunId(int id){
		int i;
		boolean result = false;
		
		for (i=0;i<Cantidad() && !(result=Lista[i].id == id);i++);
	
		// si esta ese identificador, se devuelve el registro
		if (result) return Lista[i];
		else		return null;                
	}
	
	// Vacia todos los datos en la lista
	public void Vacia() {
		while (Lista.length > 0) { EliminaId(Lista[0].id); }
	}
	
	// Ordena en el array por identificador
	public void OrdenaPorId() {
		Dato d;
		
		for (int i=2;i<Cantidad();i++)
			for (int j=0;j<Cantidad()-1;j++)
				if (Lista[j].id > Lista[j+1].id) {
					d = Lista[j]; // swap de datos
					Lista[j] = Lista[j+1];
					Lista[j+1] = d;
				}
	}
	
	// Guarda a un archivo
	public boolean Guarda(String n){
		
		Writer Escritura = null; 
		boolean result = true; 
		
		try {
			Escritura = new FileWriter(n);
				
			// se escribe en fichero los campos (tostring separa por tabuladores, se reemplazan por ;)
			for (int i = 0;i<Cantidad();i++)
				Escritura.write(Lista[i].toString().replace('\t',';')+'\n');
				
		} catch (IOException E) { // error de entrada/salida
			System.err.println("Error de escritura al fichero " + n + "(" + E + ")");
			result = false;
			
		} finally {
			try {
				if (Escritura != null) // Cerramos el fichero
					Escritura.close();
			} catch (IOException E) { // error de entrada/salida
				System.err.println("Error intentando cerrar fichero " + n + "(" + E + ")");
				result = false;
			} 
		}
		
		return result;
	}
				
	// Carga datos desde un fichero a la lista
	public boolean Carga(String n){
		BufferedReader Lectura; // Lector
		String Linea;			// Linea a leer
		boolean result = true;  // resultado de la carga
		Dato D;					// Dato a crear
		
		try {
			Lectura = new BufferedReader(new FileReader(n)); // se crea lector
			
			Vacia();
			
			while ((Linea = Lectura.readLine()) != null) // mientras haya lineas en el fichero...
			{
				if (!"".equals(Linea)) { // si la línea no esta vacia (fichero vacio)... 
					
					D = (Dato) TipoDatos.newInstance(); // creamos un dato del tipo de la lista
					
					// ponemos id y informacion, aplicando el separador de formato
					D.setId(Integer.parseInt(Linea.split(";")[0])); // leemos id
					D.setInformacion(Linea.substring(Linea.indexOf(";")+1).replace(";",Dato._separador_)); // el resto de información
					
					// insertamos el nuevo dato en la lista
					Nuevo(D);
				}
			}
			
		} catch (Exception E) { // Error de acceso de lectura
			System.err.println("Error accediendo al fichero " + n + "(" + E + ")");
			result = false;
		};
		
		return result;
	}
}
