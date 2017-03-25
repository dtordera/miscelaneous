package meves.apps.Ex0701;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.Toast;

public class Ex7_1Activity extends Activity {
	
	public int any,mes,dia;
	
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
    	SharedPreferences Settings = getPreferences(0);        
        
        any = Settings.getInt("any",Calendar.YEAR);
        mes = Settings.getInt("mes",Calendar.MONTH);
        dia = Settings.getInt("dia",Calendar.DAY_OF_MONTH);
        
        Button posadata,ensenyadata;        
        
        posadata = (Button)findViewById(R.id.button1);
        ensenyadata = (Button)findViewById(R.id.button2);
        
        posadata.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				
				final DatePicker input = new DatePicker(Ex7_1Activity.this);
				
				input.init(any,mes,dia,null);
				
				new AlertDialog.Builder(Ex7_1Activity.this)
			    .setTitle("Fecha a guardar")
			    .setView(input)
			    .setPositiveButton("Ok", new DialogInterface.OnClickListener() {
			        public void onClick(DialogInterface dialog, int whichButton) {
			        	String s;
			        	Calendar d = Calendar.getInstance();
			        	SimpleDateFormat dateformat = new SimpleDateFormat("d' de 'MMMM' del 'yyyy");
			        	
			            any = input.getYear();
			            mes = input.getMonth();
			            dia = input.getDayOfMonth();
			            
			        	d.set(any,mes,dia);			            
			        	s = dateformat.format(d.getTime());

		        		Toast.makeText(Ex7_1Activity.this,"Data registrada : " + s ,Toast.LENGTH_LONG).show();			            
			        }
			    }).setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
			        public void onClick(DialogInterface dialog, int whichButton) {
			            // Do nothing.
			        }
			    }).show();				
			}
		});       	
        
        ensenyadata.setOnClickListener(new OnClickListener() {
        	
        	@Override
        	public void onClick(View v) {
	        	Calendar d = Calendar.getInstance();
	        	SimpleDateFormat dateformat = new SimpleDateFormat("d' de 'MMMM' del 'yyyy");
	        	
	        	d.set(any,mes,dia);
	        		                   		
        		Toast.makeText(Ex7_1Activity.this,"Data registrada: " + dateformat.format(d.getTime()),Toast.LENGTH_LONG).show();
        	}
        });
    }
    
    public void onStop() {
    	SharedPreferences Settings = getPreferences(0);
    	SharedPreferences.Editor editor = Settings.edit();
    	editor.putInt("any",any);
    	editor.putInt("mes",mes);
    	editor.putInt("dia",dia);
    	editor.commit();
    	
    	super.onStop();
   }
}
