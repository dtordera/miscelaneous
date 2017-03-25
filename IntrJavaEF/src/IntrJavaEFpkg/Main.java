//
//	Introducción a Java. Ejercicio final. Gestión de tienda de música.
//

package IntrJavaEFpkg;

// Clase principal 

public class Main {
	
	public static void Bienvenida(){
		System.out.println("\nIntroducción a Java. Ejercicio final. Gestión tienda de música.\n");		
	}	

	// main
	public static void main(String[] args) {
		
		Bienvenida();
		new Parseador().EscuchaEntrada(); // clase Parseador: lee entrada y ejecuta los comandos
	}
}
