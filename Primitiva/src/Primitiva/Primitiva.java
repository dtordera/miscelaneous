package Primitiva;

import java.util.Scanner;

public class Primitiva 
{
	public static void main(String[] args) 
	{
		String[] Boleto = new String[10];
		int entrada, 
			acertos;
		boolean acertat;
		Scanner R = new Scanner(System.in);
			
		do
		{		
			acertos = 0;
			
			for (int i=0;i<Boleto.length;i++)
				Boleto[i] = Integer.toString((int)(Math.random()*90) + 10);
		
			do
			{
				acertat = false;				
				
				for (int i=0;i<Boleto.length;i++)
					System.out.print(Boleto[i] + ' ');
				
				System.out.println();				
				
				do
				{					
					System.out.print("Entrar un nombre entre el 10 y el 99 : ");
					entrada = R.nextInt();
				}
				while ((entrada != 0) && (entrada < 10 || entrada > 99));
			
				for (int i=0;i<Boleto.length;i++)
					if ((Boleto[i] != "XX") && (entrada == Integer.parseInt(Boleto[i]))) 
					{
						Boleto[i] = "XX";
						acertat = true;
						acertos++;
					}
				
				if (!acertat) System.out.println("El número " + entrada + " no està.");				
			}
			while ((acertos < Boleto.length) && (entrada != 0));
								
			if (acertos == Boleto.length)
			{
				System.out.println("Enhorabuena! Te tocó la primitiva!");
				System.out.println();
			}
			
		} while (entrada != 0);
		
		System.out.println("Saliendo...");
	}
}
