//
// Clase Cargar. Comando Cargar : llama al método de Datos que carga los datos desde un fichero.
//

package Comandos;

public class Cargar extends Comando {
	
	// Acción del comando
	public void Ejecuta(String[] p) {
		
		boolean ok = true; // flag de error
					
		if (p.length == 0) p = todaslaslistas; // en caso de no haber argumentos, se cargan todas las listas
		
		for (int i=0;i<p.length;i++)
		if ("clientes".equals(p[i]) || "cliente".equals(p[i])) 
			ok = ok & Clientes.Carga("clientes.dat");
		else
		if ("ventas".equals(p[i]) || "venta".equals(p[i]))
			ok = ok & Ventas.Carga("ventas.dat");
		else
		if ("musicas".equals(p[i]) || "musica".equals(p[i]))
			ok = ok & Musica.Carga("musica.dat");
		
		// algun tipo de error (mensaje general, las excepciones estan tratadas en el propio Datos.Carga())
		if (!ok) System.out.println("Error usando el comando cargar. Compruebe el acceso a la carpeta contenedora o sus permisos de lectura.");
		else     System.out.println("Datos cargados en memoria.");
	};
	
	// Información de uso
	public String Informacion() {return "  Cargar [clientes|musica|ventas]: Carga los datos desde fichero a memoria.";};
}
