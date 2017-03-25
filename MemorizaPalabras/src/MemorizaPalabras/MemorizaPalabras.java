package MemorizaPalabras;

import java.util.Scanner;

public class MemorizaPalabras 
{
	public static void main(String[] args) 
	{
		String[] Palabras = {"Perro","Gato","Lapiz","Mobil",
							 "Marco","Cartera","Esfuerzo",
							 "Ejercicio","Estrategia","Ajedrez"};
		int n,i=0;
		boolean Error = false;
		String Resposta;
		Scanner reader = new Scanner(System.in);
		
		for (n=0;n < Palabras.length && !Error;n++)
		{
			System.out.println(Palabras[n]);
			
			for (i=0;i<=n && !Error;i++)
			{
				Resposta = reader.nextLine();
				
				Error = !Resposta.equals(Palabras[i]); 
			}								
		}
		
		if (Error) 
			System.out.println("Fallaste. Era " + Palabras[i-1] +". Acertaste " + (i-1) + " palabras");
		else
			System.out.println("Enhorabuena! Eres un crack!");
			
	}

}
