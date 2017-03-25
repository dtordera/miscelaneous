package meves.apps.Exemple5_1;

import android.app.ListActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.Toast;

public class Exemple5_1Activity extends ListActivity {
    /** Called when the activity is first created. */
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        String[] listado = new String[] {"un", "dos", "tres", "quatre" };
        ListAdapter adapter = new ArrayAdapter<String>(this,android.R.layout.simple_list_item_1, listado);
        setListAdapter(adapter);
    }
    
    @Override
    protected void onListItemClick(ListView l, View v, int position, long id){
    	super.onListItemClick(l,v,position,id);
    	String texto = (String)getListAdapter().getItem(position);
    	Toast.makeText(Exemple5_1Activity.this,texto,Toast.LENGTH_SHORT).show();
   }
     
}