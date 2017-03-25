//
// Clase Ayuda. Comando de ayuda, muestra la informacion del parametro
//

package Comandos;

public class Ayuda extends Comando implements AuxComandos {

	// Acción del método
	@SuppressWarnings("unchecked")
	public void Ejecuta(String[] p) {
		
		Class 	ClaseComando; // Metaclase del comando, crearemos una instancia del comando escogido y llamaremos a su información
		Comando SaberAyuda;   // Comando general
				
		// Si no hay argumentos, se muestra la ayuda de todos los comandos existentes
		if (p.length == 0) { 
			p = NOMBRECOMANDOS;
			System.out.println();
		}
		
		// se recorre la lista...
		for (int i=0;i<p.length;i++) {
			
			// primera letra en mayusculas, para asi igualar al nombre de la clase.
			p[i] = p[i].toUpperCase().charAt(0) + p[i].substring(1,p[i].length()).toLowerCase();		
				
			try {
				// se encuentra la clase Comandos.p, se crea una instancia y se encuentra su ayuda
				ClaseComando = Class.forName("Comandos."+p[i]);
				SaberAyuda = (Comando) ClaseComando.newInstance();					
				System.out.println(SaberAyuda.Informacion());
			
			} catch (Exception e) { // ClassNotFound, InstantiationError
				System.out.println("No existe ayuda disponible para \"" + p[i] + "\"");
			}
		}
		
		System.out.println();		
	}

	// Información de uso del comando
	public String Informacion() {return "  Ayuda [comando1 comando2 ...]: devuelve información de uso de los comandos disponibles.";};
}
