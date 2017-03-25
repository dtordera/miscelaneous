package Comandos;

public class Ayuda extends Comando {

	@SuppressWarnings("unchecked")

	public void execucio(String[] p) {
		
		if (p[1] == null) {
		}
		
		Class miClase;
		
		try {
			miClase = Class.forName("Comandos."+p[1]);
			Comando miObjeto = (Comando) miClase.newInstance();					
			System.out.println(miObjeto.getMensajeAyuda());
			
		} catch (ClassNotFoundException e) {
			System.out.println("No existe ayuda disponible para \"" + p[1] + "\"");
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}
	}
	
	public String getMensajeAyuda(){
		return "escribir \"Ayuda <comando>\" para obtener información de uso de un comando.";
	}

}
