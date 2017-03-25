//
//	Clase Venta. Tipo de datos
//

package Datos;

public class Venta extends Dato {

	// Constantes de identificación de campo
	static final int ID_CLIENTE = 0;
	static final int N_CLIENTE = 1;
	static final int ID_MUSICA = 2;
	static final int F_MUSICA = 3;	
	static final int N_MUSICA = 4;

	// Constructor. Los valores iniciales són irrelevantes.
	public Venta(){
		super(0,"-1"+_separador_+"CLIENTE"+_separador_+"-1"+_separador_+"FMT"+_separador_+"ALBUM");
	}
	
	// Objeto a string
	public String toString() {
		return this.getId() + "\t" + this.getIdCliente() + "\t" + this.getnCliente() + 
							  "\t" + this.getIdMusica() + "\t" + this.getfMusica() + "\t" + this.getnMusica();
	}
		
	// Acceso a la información en el dato
	public void setIdMusica(int pidMusica) {
		this.informacion.split(_separador_)[ID_MUSICA] = String.valueOf(pidMusica);
	}
	
	public void setnMusica(String pnMusica) {
		this.informacion.split(_separador_)[N_MUSICA] = pnMusica;
	}
	
	public void setfMusica(String pfMusica) {
		this.informacion.split(_separador_)[F_MUSICA] = pfMusica;
	}
	
	public void setIdCliente(int pidCliente) {
		this.informacion.split(_separador_)[ID_CLIENTE] = String.valueOf(pidCliente);
	}
	
	public void setnCliente(String pnCliente) {
		this.informacion.split(_separador_)[N_CLIENTE] = pnCliente;
	}
	
	public int getIdCliente() {
		return Integer.parseInt(this.informacion.split(_separador_)[ID_CLIENTE]);
	}
	
	public int getIdMusica() {
		return Integer.parseInt(this.informacion.split(_separador_)[ID_MUSICA]);
	}
	
	public String getnMusica() {
		return this.informacion.split(_separador_)[N_MUSICA];
	}
	
	public String getfMusica() {
		return this.informacion.split(_separador_)[F_MUSICA];
	}
	
	public String getnCliente() {
		return this.informacion.split(_separador_)[N_CLIENTE];
	}
}
