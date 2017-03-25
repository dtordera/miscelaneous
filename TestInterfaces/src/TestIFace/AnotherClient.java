package TestIFace;

public class AnotherClient implements Callback {

  public void callback(int p) {
    System.out.println("Otra versión de callback");
    System.out.println("El cuadrado de p es " + (p*p));
  }
}

