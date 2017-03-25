//
//	Clase Eliminar. Elimina una entrada de datos.
//

package Comandos;

import Datos.Datos;

public class Eliminar extends Comando {
	
	// Acción del comando
	public void Ejecuta(String[] p) {
		Datos D = null;	// Lista de trabajo, seleccionada segun el primer argumento
	
		if (p.length == 0) { // es necesario al menos dos parametros, se muestra la ayuda en caso de ninguno
			System.out.println(Informacion());
			return;
		}
		
		// Asignamos lista de trabajo
		if ("cliente".equals(p[0])) D = Clientes;
		else
		if ("musica".equals(p[0])) 	D = Musica;
		else
		if ("venta".equals(p[0])) 	D = Ventas;
		else
		{
			// Primer parametro erróneo
			System.out.println(Informacion());
			return;
		}

		// No hay códigos
		if (p.length == 1) System.out.println("Es necesario códigos a eliminar");
		else		
		for (int i=1;i<p.length;i++){ // Recorremos el resto de parametros, los códigos a borrar
			
			try {
					if (!D.EliminaId(Integer.parseInt(p[i]))) // intentamos eliminar registro
						System.out.println(p[0] + " " + p[i] + ": no existe registro con este identificador");
					else 
						System.out.println(p[0] + " " + p[i] + ": registro eliminado");			
					
			} catch (Exception E) { // Conversión invalida
				System.out.println(p[0] + " " + p[i] + ": código no válido");
			}				
		}	
		
		System.out.println();
	}
	
	// Información de uso
	public String Informacion() {return "  Eliminar <cliente|musica|venta> <código1 código2 ...>: Elimina los registros con los códigos entregados.";};
}
