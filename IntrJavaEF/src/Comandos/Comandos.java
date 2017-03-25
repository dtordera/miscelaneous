//
// Clase Comandos. Comando para mostrar los comandos existentes
// 

package Comandos;

public class Comandos extends Comando implements AuxComandos {
	
	// Acción del comando
	public void Ejecuta(String[] p) {
		
		System.out.println("Comandos existentes...\n");
	
		// se recorre la lista de constantes y se muestra
		for (int i=0;i<NOMBRECOMANDOS.length;i++)
			System.out.println(NOMBRECOMANDOS[i]);
		
		System.out.println();
	};
	
	// Información de uso
	public String Informacion() {return "  Comandos: devuelve la lista de comandos disponibles.";};
}
