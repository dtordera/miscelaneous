//
// Clase Mostrar. Comando Mostrar, muestra, de una lista, el registro de un identificador determinado.
//
//

package Comandos;

import Datos.*;

public class Mostrar extends Comando {

	// Acción del comando
	public void Ejecuta(String[] p){
		
		Datos D = null; // Lista de trabajo
		String Barra;   // Barra de titulo
		
		// se necesita mostrar de una lista en concreto
		if (p.length == 0) {
			System.out.println(Informacion());
			return;
		}
		// seleccionamos lista de trabajo y barra de titulo segun el argumento
		if ("cliente".equals(p[0])) {
			D = Clientes;
			Barra = "id\tNombre";
		}
		else
		if ("musica".equals(p[0])) {
			D = Musica;
			Barra = "id\tForm.\tÁlbum";
		}
		else
		if ("venta".equals(p[0])) {
			D = Ventas;
			Barra = "id\tid.cli.\tNombre\t\t\tid.mus.\tFormato\tÁlbum";
		}
		else
		{
			System.out.println(Informacion());
			return;
		}
		
		// Mostramos barra de titulo
		System.out.println(Linea_);
		System.out.println(Barra);
		System.out.println(Linea_);
		
		// si hay lista, recorremos los codigos
		if (D != null) 
		for (int i=1;i<p.length;i++){
			Dato d;
			try {
				// Encontramos el dato con ese identificador
			d = D.DatoSegunId(Integer.parseInt(p[i]));
			} catch (Exception E) { // Fallo de conversión
				System.out.println(p[i] + "\t(código no válido)");
				continue;
			}
			// si se ha encontrado el dato, se muestra
			if (d != null) 
			System.out.println(d.toString());
			else
			System.out.println(p[i]+"\t(no existe registro)");
		}
		
		System.out.println();
	}
	
	// Información de uso
	public String Informacion() {return "  Mostrar <cliente|musica|venta> <código1 código2 ...>: Muestra información del dato con los códigos escogidos.";};

}
