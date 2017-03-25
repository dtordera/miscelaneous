//
//	Clase Listar. Muestra los datos existentes.
//

package Comandos;

public class Listar extends Comando {
	
	// Acción del comando
	public void Ejecuta(String[] p){	
		
		int i,j; // Contadores
		
		if (p.length==0) p = todaslaslistas; // caso de no haber argumentos, se muestran todas las listas
		
		// se recorren todos los argumentos
		for (j=0;j<p.length;j++) {
			if ("clientes".equals(p[j]) || "cliente".equals(p[j])) {
				
				// Barra de titulo
				System.out.println("Clientes :"); 
				System.out.println(Linea_);				
				System.out.println("id\tNombre");
				System.out.println(Linea_);
				
				// Mostramos datos
				for (i=0;i<Clientes.Cantidad();i++)
					System.out.println(Clientes.Lista[i].toString());
			
				System.out.println();
			}
			else
			if ("musicas".equals(p[j]) || "musica".equals(p[j])) {
			
				// Barra de titulo
				System.out.println("Música:");
				System.out.println(Linea_);												
				System.out.println("id\tForm.\tÁlbum");
				System.out.println(Linea_);				
			
				// Mostramos datos
				for (i=0;i<Musica.Cantidad();i++)
					System.out.println(Musica.Lista[i].toString());

				System.out.println();
			}
			else
			if ("ventas".equals(p[j]) || "venta".equals(p[j])) {
				
				// Barra de titulo
				System.out.println("Ventas:");
				System.out.println(Linea_);				
				System.out.println("id\tid.cli.\tNombre\t\t\tid.mus.\tFormato\tÁlbum");
				System.out.println(Linea_);

				// Mostramos datos
				for (i=0;i<Ventas.Cantidad();i++)
					System.out.println(Ventas.Lista[i].toString());
				
				System.out.println();
			}
			else System.out.println(p[j] + ": No existe lista de datos");
		}
	}
	
	// Información de uso
	public String Informacion() {return "  Listar [clientes|musica|ventas]: Lista los datos correspondientes en pantalla.";};
}
