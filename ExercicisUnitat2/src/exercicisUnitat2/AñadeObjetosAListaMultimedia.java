package exercicisUnitat2;

public class AñadeObjetosAListaMultimedia {
	
	public static void main(String[] args) {

		EstanteriaMultimedia Estanteria = new EstanteriaMultimedia(20);
	
		Estanteria.add(new Pelicula("Las brujas de Eastwick","Jerry Thomson",127,"Varios"));
		Estanteria.add(new Pelicula("El color del dinero","Oliver McGuire",131,"Paul Newman"));
		Estanteria.add(new Pelicula("Alien","Oliver Stone",150,"Sigourney Weaver"));
		Estanteria.add(new Pelicula("Vivir a ciegas","Terence Auster",123,"Varios"));	
		Estanteria.add(new Pelicula("El resplandor","Stanley Kubrick",120,"Jack Nicholson"));		
		
		Estanteria.add(new Disco("Descanso dominical","Mecano",120,"Pop"));
		Estanteria.add(new Disco("Descanso dominical","Mecano",120,"Pop"));
		Estanteria.add(new Disco("Descanso dominical","Mecano",120,"Pop"));
		Estanteria.add(new Disco("Descanso dominical","Mecano",120,"Pop"));
		Estanteria.add(new Disco("Descanso dominical","Mecano",120,"Pop"));
		
		Estanteria.add(new CD_Fotos("Bulgaria","Antonio",50,20)); 
		Estanteria.add(new CD_Fotos("Bulgaria","Antonio",50,20)); 
		Estanteria.add(new CD_Fotos("Bulgaria","Antonio",50,20)); 
		Estanteria.add(new CD_Fotos("Bulgaria","Antonio",50,20)); 				
		Estanteria.add(new CD_Fotos("Bulgaria","Antonio",50,20)); 		
		
		Estanteria.add(new CD_Videos("Indonesia","Marta",64,34));
		Estanteria.add(new CD_Videos("Indonesia","Marta",64,34));		
		Estanteria.add(new CD_Videos("Indonesia","Marta",64,34));		
		Estanteria.add(new CD_Videos("Indonesia","Marta",64,34));		
		Estanteria.add(new CD_Videos("Indonesia","Marta",64,34));		
		
		System.out.print(Estanteria.toString());
		
		Pelicula peli = new Pelicula("El resplandor","Stanley Kubrick",120,"Jack Nicholson");
		
		int posicion = Estanteria.indexOf(peli);
		
		System.out.print("\nPosicion : " + (posicion + 1)  + (Estanteria.get(posicion)).toString());	
	}
}
