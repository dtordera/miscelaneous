package meves.apps.Ex0401;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;

public class Ex4_1Activity extends Activity {
	
	final String TAG = "Ex4_1Activity";    	
	
	public void Toasting(){
		
		String s = Thread.currentThread().getStackTrace()[3].getMethodName();
		Toast toast = Toast.makeText(getApplicationContext(), TAG + " en " + s + "...", Toast.LENGTH_SHORT);
		toast.show();
		Log.d(TAG,TAG+" en " + s + "...");
	}
	
    @Override
    public void onCreate(Bundle savedInstanceState) {
    	   	
        super.onCreate(savedInstanceState);
        Toasting();
     }
    
    @Override
    public void onStart(){
    	super.onStart();
    	Toasting();
    }

    @Override
    public void onPause(){
    	super.onPause();
    	Toasting();
    }
    
    @Override
    public void onResume(){
    	super.onResume();
    	Toasting();
    }
    
    @Override
    public void onRestart(){
    	super.onRestart();
    	Toasting();
    }
    
    @Override
    public void onStop(){
    	super.onStop();
    	Toasting();
    }

    @Override
    public void onDestroy(){
    	Toasting();    	
    	super.onDestroy();    	
    }
}