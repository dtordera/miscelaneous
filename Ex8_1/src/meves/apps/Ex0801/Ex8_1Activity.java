// 

package meves.apps.Ex0801;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.json.JSONArray;
import org.json.JSONObject;

import android.os.Bundle;
import android.view.KeyEvent;
import android.view.View;
import android.view.View.OnKeyListener;
import android.widget.EditText;
import android.widget.Toast;

import com.google.android.maps.GeoPoint;
import com.google.android.maps.MapActivity;
import com.google.android.maps.MapController;
import com.google.android.maps.MapView;
import com.google.android.maps.Overlay;

public class Ex8_1Activity extends MapActivity {
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        MapView mapa = (MapView) findViewById(R.id.mapview1);
        final EditText e = (EditText) findViewById(R.id.editText1);        				
        final MiItemizedOverlay itemOverlay = new MiItemizedOverlay(Ex8_1Activity.this,this.getResources().getDrawable(R.drawable.circle));
    	final List<Overlay> existing = mapa.getOverlays();        
    	
        mapa.displayZoomControls(true);
        mapa.setBuiltInZoomControls(true);
        mapa.setSatellite(true);
        mapa.getController().setZoom(5);
        
        e.setOnKeyListener(new OnKeyListener() {

			public boolean onKey(View v, int keyCode, KeyEvent event) {
				if ((keyCode == KeyEvent.KEYCODE_ENTER) && (event.getAction() == KeyEvent.ACTION_DOWN)) 
				{				
			        MapView mapa = (MapView) findViewById(R.id.mapview1);
			        MapController mapController = mapa.getController();                
			        GeoPoint n;
			        									
			        String s =  e.getText().toString();
			        			        
			        try {
				        Toast.makeText(Ex8_1Activity.this,"intentant anar a " + s + " ...",Toast.LENGTH_SHORT).show();

				        n = getGeoPoint(getLocationInfo(s));
				        
				        if (n!=null)
				        {
				        	mapController.setCenter(n);				        				        
				        	mapController.setZoom(20);
				        	itemOverlay.addLocalizacion(n.getLatitudeE6()/1E6,n.getLongitudeE6()/1E6,s);
				        	
				        	existing.clear();
				        	existing.add(itemOverlay);
				        }
				        else
				        	Toast.makeText(Ex8_1Activity.this,"Direcció " + s + " no trobada", Toast.LENGTH_SHORT).show();
				        
					} catch (Exception ex) {
				        Toast.makeText(Ex8_1Activity.this,"Error", Toast.LENGTH_SHORT).show(); 
				        throw new RuntimeException(ex);
					} 
					return true;
				}
			else
				return false;
			}
		});
    }
    
    @Override
        protected boolean isRouteDisplayed() {
            return false;
        }
    // Codic per resoldre Issue 8816 android
    // http://code.google.com/p/android/issues/detail?id=8816
    // pablolar...@gmail.com
    
    public static JSONObject getLocationInfo(String address) throws Exception {
    	
    	InputStream stream = null;
    	HttpGet httpGet = new HttpGet("http://maps.google."
				+ "com/maps/api/geocode/json?address=" + address.replaceAll(" ","%20")
				+ "ka&sensor=false");
		HttpClient client = new DefaultHttpClient();
		HttpResponse response;
		StringBuilder stringBuilder = new StringBuilder();

		int b;		
		
		try {
			response = client.execute(httpGet);
			HttpEntity entity = response.getEntity();
			stream = entity.getContent();
			while ((b = stream.read()) != -1) {
				stringBuilder.append((char) b);
			}
		} catch (ClientProtocolException ex) {
		} catch (IOException ex) { throw new Exception(ex);
		} finally {
			if (stream != null) stream.close();
		}

		JSONObject jsonObject;
		try {
			jsonObject = new JSONObject(stringBuilder.toString());
		} catch (Exception ex) {
			// TODO Auto-generated catch block
			throw new Exception(ex);
		}

		return jsonObject;
	}

    public static GeoPoint getGeoPoint(JSONObject jsonObject) throws Exception {

		Double lon = new Double(0);
		Double lat = new Double(0);

		try {

			lon = ((JSONArray)jsonObject.get("results")).getJSONObject(0)
				.getJSONObject("geometry").getJSONObject("location")
				.getDouble("lng");

			lat = ((JSONArray)jsonObject.get("results")).getJSONObject(0)
				.getJSONObject("geometry").getJSONObject("location")
				.getDouble("lat");

		} catch (Exception ex) {
			// TODO Auto-generated catch block
			throw new Exception(ex);
		}
		return new GeoPoint((int) (lat * 1E6), (int) (lon * 1E6));
	}    
}