import java.util.Arrays;

public class Tecn {

	int [] 	SRt, 
			SCt;
			
	Vaixells F;
	Celles   I;
	
	public Tecn(int[] SC, int[] SR, Vaixells V, Celles Y){
		SCt = Arrays.copyOf(SC,SC.length);
		SRt = Arrays.copyOf(SR,SR.length);
		F	= V;
		I   = Y;
	}

}
