package Comandos;

//
//	Interface AuxComandos. Constantes varias.
//

public interface AuxComandos {
	
	// cuando no hay argumentos pasados a un comando, se aplica a las tres listas
	final String[] todaslaslistas = {"clientes","ventas","musica"};
	
	// lista de los comandos disponibles, usada en "ayuda" y "comandos"
	final String[] NOMBRECOMANDOS = 
		{	
			"Ayuda",
			"Cargar",
			"Cerrar",						
			"Comandos",
			"Crear",
			"Eliminar",
			"Guardar",
			"Listar",
			"Mostrar",
			"Vaciar"
		};
	
	// 80 x "-"
	final String Linea_ = "----------------------------------------"+
						  "----------------------------------------";
}
