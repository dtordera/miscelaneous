//
//	Clase Guardar. Comando Guardar : llama al método guarda de Datos, que guarda los datos en un archivo
//

package Comandos;

public class Guardar extends Comando {
	
	// Acción del comando
	public void Ejecuta(String[] p) {
		
		boolean ok = true; // flag de error
				
		if (p.length == 0) p = todaslaslistas; // si no hay argumentos, se ejecutara a todas las listas
		
		// Se recorren los argumentos y se llama al método Guarda de la correspondiente lista
		for (int i=0;i<p.length;i++)
		if ("clientes".equals(p[i]) || "cliente".equals(p[i]))
			ok = ok & Clientes.Guarda("clientes.dat");
		else
		if ("ventas".equals(p[i]) || "venta".equals(p[i]))
			ok = ok & Ventas.Guarda("ventas.dat");
		else
		if ("musicas".equals(p[i]) || "musica".equals(p[i]))
			ok = ok & Musica.Guarda("musica.dat");
		else {
			System.out.println(p[i]+":no existe este tipo de datos");
		}
		
		// en caso de error (Excepciones tratadas en Datos.Guarda)
		if (!ok) 
			System.out.println("Error usando el comando guardar. Compruebe el acceso a la carpeta contenedora o sus permisos de escritura.");
		else 
			System.out.println("Datos guardados a disco.");
	};
	
	// Información de uso
	public String Informacion() {return "  Guardar [clientes|musica|ventas]: Salva a disco los datos.";};
}
