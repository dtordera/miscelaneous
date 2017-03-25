package Comandos;


public abstract class Comando {
	
	final static String[] Comandos = {	"Ayuda",
										"Listar",
										"Crear",
										"Cerrar"
									};
	
	void execucio(String[] p) {};
	
	String getMensajeAyuda() {return "";};
}
