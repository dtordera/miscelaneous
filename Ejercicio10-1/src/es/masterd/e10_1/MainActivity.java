package es.masterd.e10_1;

import android.app.Activity;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.view.View;
import android.widget.Toast;

/**
 * La misma Activity va a hacer de listener, as� que implementamos el interface
 *
 */
public class MainActivity extends Activity implements SensorEventListener {
    private SensorManager mSensorManager;
	private View hello;

	/** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        /*
         * Obtenemos el manejador de sensores
         */
        mSensorManager = (SensorManager) getSystemService(SENSOR_SERVICE);
        
        /*
         * Objeto view que activaremos / desactivaremos sengun el sensor
         */
        hello = findViewById(R.id.hello);
        
    }
    
    /**
     * Arrancamos el listener al arrancar la actividad
     */
    @Override
	protected void onResume() {
		super.onResume();
		
		mSensorManager.registerListener(this, 
				mSensorManager.getDefaultSensor(Sensor.TYPE_PROXIMITY),
				SensorManager.SENSOR_DELAY_NORMAL);
	}
    
    

    /**
     * Liberamos el listener para ahorrar recursos antes de salir
     */
	@Override
	protected void onStop() {
		mSensorManager.unregisterListener(this);
		super.onStop();
	}

	/**
	 * No vamos a atender a cambios de intensidad de los sensores
	 */
	@Override
	public void onAccuracyChanged(Sensor sensor, int accuracy) {
	}
	
	/**
	 * Si que atendemos a cambios en los sensores
	 */
	@Override
	synchronized public void onSensorChanged(SensorEvent event) {
		if(event.sensor.getType() == Sensor.TYPE_PROXIMITY) {
			// Se activar� si el valor de distancia es mayor que 0
			Boolean enabled = (event.values[0] > 0);
			
			// El color cambiar� porque usamos un drawable de estado como fondo (res/drawable/panel.xml)
			hello.setEnabled(enabled);
		}
	}

}