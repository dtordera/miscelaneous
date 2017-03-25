package TestIFace;

public class Client implements Callback {
	
  public void callback(int p) {
    	System.out.println("callback llamado con " + p);
  	}
  
  void nonIfaceMeth() {
    	System.out.println("Las clases que implementan interfaces " +
        	               "además pueden definir otros miembros.");
 	}
}
