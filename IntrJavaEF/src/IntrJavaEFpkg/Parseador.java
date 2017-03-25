//
// Clase Parseador. Parsea las líneas de entrada y ejecuta los comandos entrados.
//

package IntrJavaEFpkg;

import java.util.Scanner;
import Comandos.Comando;

// Clase Parseador
public class Parseador {
	
	// Constantes genéricas
	final static String Prompt 			= ">Comando :";
	final static String MensajeAyuda   	= "Teclear \"comandos\" para saber los comandos disponibles.\n"+
				   				  		  "Teclear \"ayuda [comando]\" para información de su uso.";    		
	
	// EscuchaEntrada : lee y trata los datos de entrada
	public void EscuchaEntrada()
	{
		Scanner Entrada = new Scanner(System.in);   // lector de entrada
			
		while (true) // bucle infinito. La orden "cerrar" sale de la aplicación
		{
			System.out.print(Prompt);		// se imprime prompt
			Parsea(Entrada.nextLine()); 	// se lee entrada 
		}
	}
	
	// parsea la entrada
	public void Parsea(String entrada) 
	{
		String Normalizada = NormalizaString(entrada); // se normaliza la entrada
			
		if ("".equals(Normalizada)) // linea vacia, se muestra mensaje de ayuda
			System.out.println(MensajeAyuda); 
		else 
			Ejecuta(Normalizada.split(" ")); // se intenta ejecutar la linea
	}
	
	
	// normaliza la entrada : eliminación dobles espacios, espacios extras y conversion a minusculas
	public String NormalizaString(String entrada) 
	{	
		// mientras exista doble espacio, se transforma en espacio simple		
		while (entrada.indexOf("  ") != -1) 
			entrada = entrada.replaceFirst("  "," "); 
		
		return entrada.toLowerCase().trim();
	}
	
	
	// intenta ejecutar el comando, encontrando la clase, creandola y 
	// llamando al método ejecutar de esa clase.
	@SuppressWarnings("unchecked")
	public void Ejecuta(String[] Parametros)
	{
		Class 	 ClaseComando; 	// metaclase (los comandos son clases)
		Comando  A_ejecutar;	// comando a ejecutar
		String   Orden;		  	// orden (parámetro 0)
		String[] Argumentos;  	// argumentos (el resto de parámetros)
		
		// Primera letra en mayúsculas
		Orden    = Parametros[0].substring(0,1).toUpperCase() + 
				   Parametros[0].substring(1,Parametros[0].length()).toLowerCase();
		
		// Argumentos, el resto de parámetros
		Argumentos = new String[Parametros.length-1];	
		System.arraycopy(Parametros,1,Argumentos,0,Parametros.length-1);

		try {
			// Se encuentra la clase Comandos.Orden,se crea una instancia y se usa su método Ejecuta
			ClaseComando = Class.forName("Comandos."+Orden);
			A_ejecutar = (Comando) ClaseComando.newInstance();									
			A_ejecutar.Ejecuta(Argumentos);
			
		} catch (ClassNotFoundException e) {
			// Clase inexistente, no existe el comando
			System.out.println("No se ha encontrado el comando \"" + Orden + "\""+
							   ". Use \"comandos\" para conocer los comandos disponibles");
		} catch (InstantiationException e) {
			// Otras excepciones (en principio no tendrian que salir excepto por falta o error en memoria)
			System.out.println("Error iniciando el comando \"" + Orden + "\".");
		} catch (IllegalAccessException e) {
			System.out.println("Error general usando el comando \"" + Orden  + "\".");
		}
	}
}
