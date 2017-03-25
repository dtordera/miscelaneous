// 
//	Clase Vaciar. Comando Vaciar, vacia las listas escogidas.
//
//

package Comandos;

public class Vaciar extends Comando {

	// Acción del comando
	public void Ejecuta(String[] p) {
					
		if (p.length == 0) p = todaslaslistas; // si no hay argumento, se vacian todas las listas
		
		for (int i=0;i<p.length;i++)
		if ("clientes".equals(p[i])) Clientes.Vacia();
		else
		if ("ventas".equals(p[i]))	 Ventas.Vacia();
		else
		if ("musica".equals(p[i]))	 Musica.Vacia();
		
		System.out.println("Datos borrados de memoria.");
	};
	
	// Información de uso
	public String Informacion() {return "  Vaciar [clientes|ventas|musica]: Borra los datos existentes en memoria.";};
}
