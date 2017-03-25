package Comandos;

public class Dato {
	private int id;
	private String Descripcion;
	
	Dato(int pid,String pDescripcion){
		setId(pid);
		setDescripcion(pDescripcion);
	}
	
	public void setId(int pid){
		this.id = pid;
	}
	
	public void setDescripcion(String pDescripcion){
		this.Descripcion = pDescripcion;
	}
	
	public int getId(){
		return this.id;
	}
	
	public String getDescripcion(){
		return this.Descripcion;
	}
}

