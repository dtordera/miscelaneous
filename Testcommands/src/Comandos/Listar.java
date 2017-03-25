package Comandos;



public class Listar extends Comando /*implements Execucio*/ {
	
	public void execucio(String[] p) {
		System.out.println("Este es el metodo execucio de listar : " + p[0]);		
	}
	
	public String getMensajeAyuda(){
		return "escribir \"Listar [cliente|musica|venta]\" para mostrar todos los elementos";
	}
}
