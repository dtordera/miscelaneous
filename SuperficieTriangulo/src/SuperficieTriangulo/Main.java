package SuperficieTriangulo;
import java.util.Scanner;

public class Main {
	public static void main(String[] args) 
	{
		float Base, Altura;
		Scanner reader = new Scanner(System.in);
		
		System.out.println("Introduzca la base del triangulo :");
		Base = reader.nextFloat();
		
		System.out.println("Introduzca la altura del triangulo :");
		Altura = reader.nextFloat();
		
		System.out.println("El área del triangulo és de " + (Base*Altura)/2);	
		System.out.println("El perimetro del triangulo és de " + (Base + Altura + Math.sqrt(Base*Base + Altura*Altura)));
	}

}
