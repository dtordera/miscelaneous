package Comandos;

public class Cerrar extends Comando {
	
	public void execucio(String[] parametros) {
		System.out.println("Saliendo...");		
		System.exit(0);
	}
	
	public String getMensajeAyuda() {
		return "Sale de la aplicación grabando los datos:";
	}

}
