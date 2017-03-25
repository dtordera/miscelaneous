package exercicisUnitat2;

import java.io.FileOutputStream;
import java.io.FileInputStream;
import java.io.ObjectOutputStream;
import java.io.ObjectInputStream;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.util.ArrayList;

public class EscrituraLecturaDeObjetosMultimedia {
	
	private FileOutputStream fileOutputStream;
	private FileInputStream fileInputStream;
	private ObjectOutputStream escritura;
	private ObjectInputStream lectura;
	private String archivo;
	
	EscrituraLecturaDeObjetosMultimedia(String parchivo)
	{
		this.archivo = parchivo;
	}

	public void escrituraObjetos(EstanteriaMultimedia listaparaEscribir) throws IOException
	{
		fileOutputStream = new FileOutputStream(archivo);
		
		escritura = new ObjectOutputStream(fileOutputStream);
		
		for (int i=0;i<listaparaEscribir.size();i++)
			escritura.writeObject(listaparaEscribir.get(i));
		
		escritura.close();		
	}
	
	public ArrayList<Multimedia> lecturaObjetos(int numObjetos) throws Exception,FileNotFoundException,IOException
	{
		ArrayList<Multimedia> lista = new ArrayList<Multimedia>();
		
		lectura = new ObjectInputStream(new FileInputStream(archivo));
		
		for (int i=0;i<numObjetos;i++)
			lista.add((Multimedia)lectura.readObject());
		
		lectura.close();
		return lista;
	}	
}
