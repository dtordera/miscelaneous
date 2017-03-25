package Comandos;

//
// Clase abstracta Comando. De aqui se derivaran los comandos.
// Ejecuta            : método que sobrecargado ejecuta el comando
// Informacion        : método que sobrecargado da información de uso.
//

import Datos.*;

public abstract class Comando implements AuxComandos {
	
	// Listas de datos, compartidas por todas las instancias de comando y heredadas
	public static Datos Clientes;
	public static Datos Ventas;
	public static Datos Musica;
		
	public Comando(){
		
		// Al ser las listas static, tansolo las creamos en la creación del primer comando
		try {
			if (Clientes == null) Clientes = new Datos("Datos.Cliente");				
			if (Ventas   == null) Ventas   = new Datos("Datos.Venta");
			if (Musica   == null) Musica   = new Datos("Datos.Musica");
			
		} catch (Exception E) {
			System.err.println("Error: clase no encontrada." + E);
		}	
	}
	
	// Métodos abstractos
	public void Ejecuta(String[] p) {}; // Acción del comando
	public String Informacion() {return "";}; // Información de uso
}
