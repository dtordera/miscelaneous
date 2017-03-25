package Comandos;



public class Crear extends Comando /*implements Execucio*/ {
	
	public void execucio(String[] parametros) {
		System.out.println("Este es el método execucio de crear ");		
	}
	
	public String getMensajeAyuda() {
		return "escribir \"crear [cliente|musica|venta]\" para añadir un nuevo elemento";
	}
}
