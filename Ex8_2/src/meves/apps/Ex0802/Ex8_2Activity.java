package meves.apps.Ex0802;

import java.io.IOException;
import java.io.InputStream;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.json.JSONArray;
import org.json.JSONObject;

import com.google.android.maps.GeoPoint;

import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;
import android.location.LocationManager;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.View;
import android.view.View.OnKeyListener;
import android.widget.EditText;
import android.widget.Toast;

public class Ex8_2Activity extends Activity {
	
	String 	Desti;
	EditText e;
	MiLocationListener l;
	LocationManager lm;
	
    @Override
    public void onCreate(Bundle savedInstanceState) {
       
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);        
        
        SharedPreferences settings;        
        settings = getPreferences(0);               
        
        l = new MiLocationListener(Ex8_2Activity.this,settings.getFloat("latitud",(float)0),settings.getFloat("longitud",(float)0));                        
        lm = (LocationManager)getSystemService(Context.LOCATION_SERVICE);
        lm.requestLocationUpdates(LocationManager.GPS_PROVIDER,1000,0,l);
        Desti = settings.getString("desti","destí");                

        e = (EditText)findViewById(R.id.editText1);                
        
        e.setOnKeyListener(
        	new OnKeyListener() {
        		public boolean onKey(View v, int keyCode, KeyEvent event) {
        			if ((keyCode == KeyEvent.KEYCODE_ENTER) && (event.getAction() == KeyEvent.ACTION_DOWN)) {						        			        
        				try {
        					
            				String s =  e.getText().toString();        						            					        						
        					Toast.makeText(Ex8_2Activity.this,"Buscant " + s + "...", Toast.LENGTH_SHORT).show();             				        					
 							GeoPoint n = getAddresPoint(s);
 											        
        					if (n!=null) l.putdest(n.getLatitudeE6()/1E6,n.getLongitudeE6()/1E6);
				                						
        				} catch (Exception ex) {
        					Toast.makeText(Ex8_2Activity.this,ex.getMessage(), Toast.LENGTH_SHORT).show(); 
        				}
        				return true;
        			}
        			else return false;
        		}
        	}
        );
        e.setHint(Desti);                        
    }
	public JSONObject getLocationInfo(String address) throws Exception {
    	
		if (address == "") return null;
		
    	InputStream stream = null;		
		HttpGet httpGet = new HttpGet("https://maps.google.com/maps/api/geocode/json?address=" + address.replaceAll(" ","%20")
				+ "ka&sensor=false");
		
		HttpClient client = new DefaultHttpClient();				
		HttpResponse response;
		StringBuilder stringBuilder = new StringBuilder();

		try {
			response = client.execute(httpGet);
			HttpEntity entity = response.getEntity();
			stream = entity.getContent();
			int b;
			while ((b = stream.read()) != -1) {
				stringBuilder.append((char) b);
			}
		} catch (ClientProtocolException ex) { ex.printStackTrace(); throw new Exception(ex);
		} catch (IOException ex) { ex.printStackTrace(); throw new Exception(ex);
		} finally { if (stream!=null) stream.close(); }

		JSONObject jsonObject;
		
		try {
			jsonObject = new JSONObject(stringBuilder.toString());
		} catch (Exception ex) {
			ex.printStackTrace();
			throw new Exception(ex);
		}

		return jsonObject;
	}

    public static GeoPoint getGeoPoint(JSONObject jsonObject) throws Exception {

    	if (jsonObject == null) return null;
    	
		Double lon = new Double(0);
		Double lat = new Double(0);
		GeoPoint ret = null;

		try {

			lon = ((JSONArray)jsonObject.get("results")).getJSONObject(0)
				.getJSONObject("geometry").getJSONObject("location")
				.getDouble("lng");

			lat = ((JSONArray)jsonObject.get("results")).getJSONObject(0)
				.getJSONObject("geometry").getJSONObject("location")
				.getDouble("lat");
			
			ret = new GeoPoint((int) (lat * 1E6), (int) (lon * 1E6));			

		} catch (Exception ex) {
			ex.printStackTrace();
			throw new Exception(ex);
		}
		
		return ret;
	}    
    
    public GeoPoint getAddresPoint(String Address) throws Exception {
    	return getGeoPoint(getLocationInfo(Address));
    }
    
    public void onStop() {
    	SharedPreferences Settings = getPreferences(0);
    	SharedPreferences.Editor editor = Settings.edit();
    	editor.putString("desti",e.getText().toString());
    	editor.putFloat("latitud",(float) l.latitud);
    	editor.putFloat("longitud",(float) l.longitud);
    	editor.commit();
    	lm.removeUpdates(l);
    	
    	super.onStop();
   }

}