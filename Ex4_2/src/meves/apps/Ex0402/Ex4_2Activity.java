package meves.apps.Ex0402;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;

public class Ex4_2Activity extends Activity {
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        Button buto1 = (Button) findViewById(R.id.button1);
        Button buto2 = (Button) findViewById(R.id.button2);
        Button buto3 = (Button) findViewById(R.id.button3);
        
        // Activitat 1
        
        buto1.setOnClickListener(
        	new OnClickListener() 
        	{
        		public void onClick(View v)
        		{
        			Intent intent = new Intent();
        			
        			intent.setClass(getApplicationContext(), _1Activity.class);
        			startActivity(intent);
        		}
        	});
        
        // Activitat 2
        
        buto2.setOnClickListener(
        	new OnClickListener()
        	{
        		public void onClick(View v)
        		{
        			Intent intent = new Intent();
        			
        			intent.setClass(getApplicationContext(), _2Activity.class);
        			startActivity(intent);
        		}
        	});
        
        // Activitat 3
        
        buto3.setOnClickListener(
        	new OnClickListener()
        	{
        		public void onClick(View v)
        		{
        			finish();
        		}
        	});
    }
}