package meves.apps.Ex0702;

import android.app.ListActivity;
import android.content.ContentValues;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.widget.ListAdapter;
import android.widget.SimpleCursorAdapter;

public class Ex7_2Activity extends ListActivity {

	Cursor cursor;
	
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
               
        ComunidadesDBHelper dbhelper = new ComunidadesDBHelper(Ex7_2Activity.this);
        SQLiteDatabase comunidadesdb = dbhelper.getWritableDatabase();
        ContentValues valors = new ContentValues();        
        String[] comunidades = getResources().getStringArray(R.array.comunidades);
                             
        for (int n=0;n<comunidades.length - 1;n++)
        {
        	valors.put("_id",n);
        	valors.put("nombre",comunidades[n]);
        
        	comunidadesdb.insert("comunidades","",valors);
        }
               
        cursor = comunidadesdb.rawQuery("select _id as _id,nombre from comunidades;",null);
        startManagingCursor(cursor);
               
        ListAdapter adapter = 
        	new SimpleCursorAdapter(
        		this, 
        		android.R.layout.two_line_list_item,
        		cursor,
        		new String[] {"_id","nombre"},
        		new int[] {android.R.id.text1, android.R.id.text2}
        	);
        
         setListAdapter(adapter);
    }
    
    public void onStop() {
    	stopManagingCursor(cursor);
    	super.onStop();
    }
}