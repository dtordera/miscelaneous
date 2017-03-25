//
//	Clase Crear. Crea una nueva entrada de la lista de datos escogida.
//

package Comandos;

import java.util.Scanner;
import Datos.*;

public class Crear extends Comando {
	
	// Acción del comando
	public void Ejecuta(String[] p) {

		char c = '\0'; 								// variable de lectura
		Scanner Entrada = new Scanner(System.in);   // lector de entrada					
		Datos D = null; 							// lista de datos que apuntara a la lista de trabajo requerida
		String Informacion = ""; 					// atributo de dato (bulk data)
		String TipoDato = ""; 						// String descriptiva del tipo de dato (para el mensaje final)
		
		if (p.length == 0) { // No hay argumentos, se pregunta a que lista se añadira el nuevo registro
			
			while (c != 'C' && c != 'M' && c!='V' && c!='S') {
		
				System.out.println("¿Crear nuevo (C)liente,(M)úsica o (V)enta? (S=Salir)");	
				c = Character.toUpperCase(Entrada.nextLine().charAt(0));
			}			
			
		} else 
			c = p[0].toUpperCase().charAt(0); // en otro caso seguimos con la primera letra del primer argumento
				
		switch(c){
			case 'C' : 	System.out.println("¿Nombre del cliente?");			// Cliente
					   	Informacion = Entrada.nextLine().toUpperCase();		// se recoge el nombre
					   	TipoDato = "cliente";					   	
					   	D = Clientes;										// la lista de trabajo sera Clientes
			           	break; 
			case 'M' : 	c = '\0'; // Musica			
			
						// Escojemos formato
						while (c != 'C' && c != 'A' && c != 'V' && c != 'S') {
							System.out.println("¿Formato :(C)D-Rom,c(a)sete,(V)inilo? ((S)alir)");	
							c = Entrada.nextLine().toUpperCase().charAt(0);
						}	
						
						switch(c){
							case 'C' : Informacion = "CD-ROM"; break;
							case 'A' : Informacion = "CASETE"; break;
							case 'V' : Informacion = "VINILO"; break;
							case 'S' : System.out.println("Creación anulada");
										return;
						}						
							
					   	Informacion += Dato._separador_;
					   	System.out.println("¿Álbum?");
					   	Informacion += Entrada.nextLine().toUpperCase();
					   	TipoDato = "música";
					   	D = Musica;											// la lista de trabajo sera Musica
					   	break;
			case 'V' : 	boolean ok = false;									// flag de finalización
						int idm = 0;										// identificador de música, cliente
						String s;											// string de trabajo
						Musica M = null;									// Datos temporales de recogida de información
						Cliente C = null;									// 
						
						// Recogemos información del cliente
						while (!ok){
							System.out.println("¿Identificador de cliente?");
							try {
								s = Entrada.nextLine();		
								
								if (s.toUpperCase().charAt(0) == 'S') {			// salida
									System.out.println("Creación anulada");
									return;
								}								
								
								idm = Integer.parseInt(s);						// recogemos id cliente
								C = (Cliente )Clientes.DatoSegunId(idm);		// buscamos dato con ese id
								ok = C != null;									// comprobamos que exista
								
								if (!ok)
									System.out.println("Código no encontrado.");
								else
								{
									System.out.println(idm + "\t" + C.getNombre());
									System.out.println("¿Asignar a venta? (S/N)");
									ok = Entrada.nextLine().toUpperCase().charAt(0) == 'S';
								}
							}catch (Exception E) {	// Excepción de fallo de conversión
									System.out.println("Código no válido ((S)alir)");
							}
						}
						
						ok = false;	// reactivamos el flag de salida y procedemos de manera similar para el id de música
						while (!ok){
							System.out.println("¿Identificador de música?"); 
							try {
								s = Entrada.nextLine();		
								
								if (s.toUpperCase().charAt(0) == 'S') {
									System.out.println("Creación anulada");
									return;
								}
								
								idm = Integer.parseInt(s);
								M = (Musica )Musica.DatoSegunId(idm);
								ok = M != null;
								
								if (!ok) 
									System.out.println("Código no encontrado.((S)alir)");
								else
								{
									System.out.println(idm + "\t" + M.getFormato() + "\t" + M.getTitulo());
									System.out.println("¿Asignar a venta? (S/N)");
									ok = Entrada.nextLine().toUpperCase().charAt(0) == 'S';
								}
								
							} catch (Exception E) {
								System.out.println("Código no válido.");
							}
						}
						
						// si se ha encontrado tanto el cliente como la música, se prepara la información para un nuevo dato de venta
						if ((C != null) && (M != null))
						{
							// Se prepara la información formateada para el dato de venta
							Informacion = C.getId() + Dato._separador_ + C.getNombre() + Dato._separador_ + M.getId() + Dato._separador_ + 
							M.getFormato() + Dato._separador_ + M.getTitulo();
							TipoDato = "venta";
							D = Ventas;	// lista de trabajo sera Ventas
						}
						break;
			default : return; 
		}
		
		// si la lista de trabajo esta asignada, el proceso de recogida de datos ha sido correcto
		if (D != null)
		try {
			int id = D.NuevoId();  			 			// buscamos un nuevo identificador libre en esa lista
			Dato d = (Dato) D.TipoDatos.newInstance();	// creamos un nuevo dato del tipo de dato de esa lista
		
			d.setId(id);								// asignamos id
			d.setInformacion(Informacion);				// asignamos data
					
			D.Nuevo(d);									// insertamos en la lista el nuevo dato
					
			System.out.println("Registro de " + TipoDato + " #" + id + " creado.");			
	
		} catch (Exception E) { // Fallo de instantiación o de clase no encontrada. En principio sólo puede dar error por falta de memoria
			System.out.println("Error intentando crear nuevo registro (" + E + ")");
		} 						
	}
	
	// Información de uso
	public String Informacion() {return "  Crear [cliente|musica|venta]: Crea un nuevo registro.";};
}
