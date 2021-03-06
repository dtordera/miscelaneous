package meves.apps.Ex1101;

import android.app.Activity;
import android.media.MediaPlayer;
import android.media.MediaRecorder;
import android.opengl.Visibility;
import android.os.Bundle;
import android.os.Environment;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.Toast;

public class Ex1101Activity extends Activity {

	final MediaRecorder grabadora = new MediaRecorder();
	final MediaPlayer mp = new MediaPlayer();	
		
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
                   
        final Button but = (Button)findViewById(R.id.button1);        
        
        but.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View arg0) {
						
				if ("Grabar".equals(but.getText().toString())) {
					try {
						grabadora.setOutputFile(Environment.getExternalStorageDirectory().getAbsolutePath() + "/test.3GP");        
						grabadora.setAudioSource(MediaRecorder.AudioSource.MIC);
						grabadora.setOutputFormat(MediaRecorder.OutputFormat.THREE_GPP);
						grabadora.setAudioEncoder(MediaRecorder.AudioEncoder.AMR_NB);
					
						grabadora.prepare();
						grabadora.start();
						but.setText("Parar");
						but.setBackgroundColor(0xFF00FF00);						
					} catch(Exception e) {
						Toast.makeText(Ex1101Activity.this,"Error intentant grabar : " + e.getMessage(),Toast.LENGTH_SHORT).show();
					}
				}
				else
				{	
					try {
						but.setBackgroundColor(0xFFFF0000);											
						grabadora.stop();
						but.setVisibility(View.GONE);
						
					} catch(Exception e) {
						Toast.makeText(Ex1101Activity.this,"Error tancant fitxer : " + e.getMessage(),Toast.LENGTH_SHORT).show();
					}
					
					try {
						mp.setDataSource(Environment.getExternalStorageDirectory().getAbsolutePath() + "/test.3GP");
						mp.prepare();
						mp.start();
					} catch (Exception e) {
						Toast.makeText(Ex1101Activity.this,"Error reproduint. " + e.getMessage(),Toast.LENGTH_SHORT).show();
						
					}
				
				}								
			}
		});
    }    
    
    public void onStop() {
    	grabadora.release(); 						
    	
    	mp.release();
    	super.onStop();
    }
}