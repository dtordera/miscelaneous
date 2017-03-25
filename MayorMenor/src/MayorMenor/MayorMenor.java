package MayorMenor;
import java.util.Scanner;
import java.util.Random;

public class MayorMenor 
{
	public static void main(String[] args) 
	{
		int numero,
		    intentos,
		    respuesta;
		
		Scanner reader = new Scanner(System.in);
					
		intentos = 0;
		numero = (int)(Math.random()*100);
		
		do
		{
			System.out.println("Qué número tengo? intentos restantes : " + (10 - intentos));
			intentos++;
			respuesta = reader.nextInt();
		
			if (respuesta > numero)
				System.out.println("El número " + respuesta + " es mayor al escogido.");
			else
				if (respuesta < numero)
					System.out.println("El número " + respuesta + " es menor al escogido.");
				else
					System.out.println("Bravo! acertaste en " + intentos + " intentos.");
		}
		while ((respuesta != numero) && (intentos < 10));	
	
		if (intentos > 10)
			System.out.println("Lástima! el número escogido era el " + numero);
	}
}
