package meves.apps.Ex1002;

import java.util.ArrayList;

import android.app.Activity;
import android.gesture.Gesture;
import android.gesture.GestureLibraries;
import android.gesture.GestureLibrary;
import android.gesture.GestureOverlayView;
import android.gesture.GestureOverlayView.OnGesturePerformedListener;
import android.gesture.Prediction;
import android.os.Bundle;
import android.widget.TextView;
import android.widget.Toast;

public class Ex1002Activity extends Activity implements OnGesturePerformedListener{
    /** Called when the activity is first created. */
    
    GestureOverlayView gestureView;
    TextView nomtext;
    GestureLibrary gestlib;
    
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        gestureView = (GestureOverlayView) findViewById(R.id.gestures);
        nomtext = (TextView) findViewById(R.id.nomtexte);
        
        gestlib = GestureLibraries.fromRawResource(this,R.raw.gestures);
        
        if (!gestlib.load()) {
        	Toast.makeText(this,"Error carregant biblioteca",Toast.LENGTH_SHORT).show();
        	finish();
        }
    }

	@Override
	public void onGesturePerformed(GestureOverlayView arg0, Gesture arg1) {
		ArrayList<Prediction> predicciones = gestlib.recognize(arg1);
		
		if (predicciones.size() > 0) {
			Prediction prediccion = predicciones.get(0);
			
			if (prediccion.score > 1.0) {
				nomtext.setText(nomtext.getText().toString() + prediccion.name);
				return;
			}
		}		
	}
	
	@Override
	protected void onResume() {
		super.onResume();
		gestureView.addOnGesturePerformedListener(this);
	}
	
	@Override
	protected void onStop(){
		gestureView.removeOnGesturePerformedListener(this);
		super.onStop();
	}
}