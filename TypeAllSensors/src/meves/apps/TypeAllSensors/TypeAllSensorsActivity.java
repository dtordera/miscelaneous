package meves.apps.TypeAllSensors;

import java.util.Iterator;
import java.util.List;

import android.app.Activity;
import android.graphics.Color;
import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.view.ViewGroup;
import android.view.ViewGroup.LayoutParams;
import android.widget.LinearLayout;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;

public class TypeAllSensorsActivity extends Activity {
 
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
       SensorManager sm = (SensorManager) getApplicationContext().
                                           getSystemService(SENSOR_SERVICE);
        LinearLayout linearLayout = new LinearLayout(getApplicationContext());
        List list = sm.getSensorList(Sensor.TYPE_ALL);
        Iterator itr = list.iterator();
        TextView txtView = null;
        TableLayout tableLayout = new TableLayout(this);
        ViewGroup.LayoutParams params = 
        	 new ViewGroup.LayoutParams(LayoutParams.FILL_PARENT, 
        			                    LayoutParams.FILL_PARENT);
        
        tableLayout.setLayoutParams(params);
        TableRow tableRow = null;
        while(itr.hasNext()) {
        	txtView = new TextView(getApplicationContext());
        	txtView.setTextColor(Color.BLACK);
        	tableRow = new TableRow(this);
        	
        	tableRow.setBackgroundColor(Color.YELLOW);
        	Sensor sensor = (Sensor)itr.next();
        	txtView.setText(sensor.getName());
        	tableRow.addView(txtView);
        	tableLayout.addView(tableRow);
        }
        linearLayout.addView(tableLayout);
        setContentView(linearLayout);
    }        
}

       
