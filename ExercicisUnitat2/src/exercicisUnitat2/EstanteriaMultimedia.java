package exercicisUnitat2;

import java.io.FileNotFoundException;
import java.io.IOException;

public class EstanteriaMultimedia {
	
	private Multimedia[] listaMultimedia;
	private int contador;
	
	EstanteriaMultimedia(int tamañoMáximo){
		listaMultimedia = new Multimedia[tamañoMáximo];
		contador   = 0;
	}

	public int size(){
		return contador;
	}
	
	public boolean add(Multimedia m){
		boolean result = contador < listaMultimedia.length;
		
		if (result) {
			
			listaMultimedia[contador] = m;
			contador++;
		} 
		return result;
	}
	
	public Multimedia get(int posicion){	
		return listaMultimedia[posicion];
	}
	
	public int indexOf(Multimedia m){
		for (int i=0;i<listaMultimedia.length;i++)
			if (listaMultimedia[i].equals(m)) return i;
		
		return -1;
	}
	
	public void Escribir() throws Exception,IOException{
		EscrituraLecturaDeObjetosMultimedia Fichero = new EscrituraLecturaDeObjetosMultimedia("estanteria.dat");
		
		Fichero.escrituraObjetos(this);
	}
	
	public void Leer() throws Exception,IOException,FileNotFoundException
	{
		EscrituraLecturaDeObjetosMultimedia Fichero = new EscrituraLecturaDeObjetosMultimedia("estanteria.dat");
		
		Fichero.lecturaObjetos(this.size());
	}
	
	public String toString(){
		String result = "";
		
		for (int i=0;i<listaMultimedia.length;i++)
			result += listaMultimedia[i].toString();
		
		return result;
	}
}
