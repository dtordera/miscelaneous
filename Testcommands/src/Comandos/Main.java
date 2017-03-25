package Comandos;
public class Main {

	@SuppressWarnings("unchecked")
	public static void main(String[] args) throws InstantiationException, IllegalAccessException {

		Class miClase;
		String P[] = {"Ayuda","Listar"};

		try {
			miClase = Class.forName("Comandos."+P[0]);
			Comando miObjeto = (Comando) miClase.newInstance();					
			miObjeto.execucio(P);
			
		} catch (ClassNotFoundException e) {
			System.out.println("Comando " + P[0] + " no encontrado");
		}
	}
}
