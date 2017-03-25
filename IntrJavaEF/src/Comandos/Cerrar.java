//
// Clase Cerrar. Comando Cerrar para finalizar la aplicación.
//

package Comandos;

import java.util.Scanner;

public class Cerrar extends Comando {
	
	// Acción del comando
	public void Ejecuta(String[] p){
		
		Scanner Entrada = new Scanner(System.in); // Lector
		
		System.out.println("Guardar datos antes de salir? (S/N)"); // Opción de guardar los datos
		if (Entrada.nextLine().toUpperCase().charAt(0) == 'S') { // en caso afirmativo...
		
			if (!(Clientes.Guarda("clientes.dat") &&  // guardamos las listas
				  Musica.Guarda("musica.dat")     && 
				  Ventas.Guarda("ventas.dat")
				 )) {
				// Mensaje de error general, excepciones tratadas en Datos.Guarda
				System.out.println("Ha habido algun tipo de error intentando guardar los datos");
				return;
			} else 
				System.out.println("Datos guardados.");
		}
		
		System.out.println("Cerrando aplicación...");
		System.exit(0); // Salida de la aplicación
	}
	
	// Información de uso
	public String Informacion() {return "  Cerrar: graba los datos y cierra el programa.";};
}
