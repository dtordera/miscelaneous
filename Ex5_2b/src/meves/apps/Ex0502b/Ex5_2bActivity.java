package meves.apps.Ex0502b;

import android.app.ListActivity;
import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.ListAdapter;

public class Ex5_2bActivity extends ListActivity {
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        String[] llista = new String[] {"Alumne 1", "Alumne segon", "Alumne tercer", "Alumne 4rt", "Alumne 5é" };
        
        ListAdapter adapter = new ArrayAdapter<String>(this,android.R.layout.simple_list_item_1,llista);
        setListAdapter(adapter);
    }
}