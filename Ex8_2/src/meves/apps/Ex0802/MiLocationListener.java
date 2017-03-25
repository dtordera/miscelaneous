package meves.apps.Ex0802;

import android.app.Activity;
import android.content.Context;
import android.location.Location;
import android.location.LocationListener;
import android.os.Bundle;
import android.widget.TextView;
import android.widget.Toast;

public class MiLocationListener implements LocationListener {

	public double   latitud,
					longitud;
	public double 	latdest,
					londest;
	public double   distancia;
	Context context;
	public TextView  tlongdest,
					 tlatdest,
				 	 tlongact,
					 tlatact,
					 tdist;
	
	public MiLocationListener(Context context,double lato,double lono){
		this.context = context;
		latdest = lato;
		londest = lono;
		calcdist();
        tlongdest = (TextView)((Activity)context).findViewById(R.id.longdest);
        tlatdest  = (TextView)((Activity)context).findViewById(R.id.latdest);
        tlongact  = (TextView)((Activity)context).findViewById(R.id.longact);
        tlatact   = (TextView)((Activity)context).findViewById(R.id.latact);
        tdist 	  = (TextView)((Activity)context).findViewById(R.id.dist);
	}
	
	public void calcdist() {
		double dt,dn;
		
		dt = latdest - latitud;
		dn = londest - longitud;
		distancia = Math.sqrt((dt*dt) + (dn*dn));
	}
	
	@Override
	public void onLocationChanged(Location arg0) {
		latitud = arg0.getLatitude();
		longitud = arg0.getLongitude();
		calcdist();
		UpdateView();
	}
	
	public void putdest(double ltf,double lnf){
		latdest = ltf;
		londest = lnf;
		calcdist();
		UpdateView();
	}

	@Override
	public void onProviderDisabled(String arg0) {
		Toast.makeText(context,"GPS desactivado",Toast.LENGTH_LONG).show();
	}

	@Override
	public void onProviderEnabled(String arg0) {
		Toast.makeText(context,"GPS activado", Toast.LENGTH_SHORT).show();		
	}

	@Override
	public void onStatusChanged(String arg0, int arg1, Bundle arg2) {
	}
	
	public void UpdateView(){
		tlongdest.setText(String.format("%f3.5 º",londest));
		tlatdest.setText(String.format("%f3.5 º",latdest));
		tlongact.setText(String.format("%f3.5 º",longitud));
		tlatact.setText(String.format("%f3.5 º",latitud));
		tdist.setText(String.format("%f3.5 º",distancia));
		
		if (distancia < 0.0003)  tdist.setTextColor(0XAA00FF00); else tdist.setTextColor(0xAAFF0000);
	}
}
