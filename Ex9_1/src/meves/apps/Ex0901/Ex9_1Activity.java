package meves.apps.Ex0901;

import android.app.AlertDialog;
import android.app.ListActivity;
import android.content.DialogInterface;
import android.content.Intent;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;
import android.provider.ContactsContract;
import android.telephony.SmsManager;
import android.view.View;
import android.widget.EditText;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.SimpleCursorAdapter;
import android.widget.Toast;

public class Ex9_1Activity extends ListActivity {

	Cursor cursor;
	ListAdapter adapter;
	int LastPositionCursor;
	
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }
    
    protected void onListItemClick(ListView l, View v, int position, long id) {
        LastPositionCursor = position;
		
		Cursor tlfcur = 
				getContentResolver().query(
						ContactsContract.CommonDataKinds.Phone.CONTENT_URI,
						null,
						ContactsContract.CommonDataKinds.Phone.CONTACT_ID + "= ?",
						new String[] {""+id},
						null);
		int nTelefonos = tlfcur.getCount();
		
		final String[] telefonos = new String[nTelefonos];
		int x = 0,
			col;
		
		
		while(tlfcur.moveToNext()) {
			col = tlfcur.getColumnIndex(ContactsContract.CommonDataKinds.Phone.NUMBER);
			telefonos[x++] = tlfcur.getString(col);
		}
		tlfcur.close();
		
		AlertDialog.Builder builder = new AlertDialog.Builder(this);
		
		builder.setTitle("Selecciona telèfon :");
		builder.setItems(telefonos, new DialogInterface.OnClickListener() {
			public void onClick(DialogInterface dialog, int item) {
			
				final String NumTel = telefonos[item];
				
				AlertDialog.Builder builder = new AlertDialog.Builder(Ex9_1Activity.this);
				
				builder.setTitle("Acció :");
				builder.setItems(new String[] {"SMS","Trucar" },new DialogInterface.OnClickListener() {
					public void onClick(DialogInterface dialog, int item) {
						switch(item) {
						case 0 : Toast.makeText(Ex9_1Activity.this,"Envia SMS a " + NumTel ,Toast.LENGTH_SHORT).show(); EnviaSMS(NumTel);return;
						case 1 : Toast.makeText(Ex9_1Activity.this,"Trucar a " + NumTel,Toast.LENGTH_SHORT).show(); Truca(NumTel);return;
					}
				}  // onclick
				}  // Listener
				); // setItems
				
				builder.setNegativeButton("Cancelar",null);
				AlertDialog alert = builder.create();
				alert.show();
			}
		});
		builder.setNegativeButton("Cancelar",null);
		AlertDialog alert = builder.create();
		alert.show();
    }
    
    public void EnviaSMS(final String s){
    		AlertDialog.Builder alert = new AlertDialog.Builder(this);

    		alert.setTitle("SMS a " + s);
    		// Set an EditText view to get user input 
    		final EditText input = new EditText(this);
    		alert.setView(input);

    		alert.setPositiveButton("Ok", new DialogInterface.OnClickListener() {
    			public void onClick(DialogInterface dialog, int whichButton) {
    			String text = input.getText().toString();
    			// Do something with value!
    			
    			try {    			
    				SmsManager smsMgr = SmsManager.getDefault();
    				smsMgr.sendTextMessage(s,null, text, null, null);
    			} catch (Exception e) {
    				Toast.makeText(Ex9_1Activity.this,"Error intentant enviar SMS a " + s + ". Error : " + e.getMessage(),Toast.LENGTH_SHORT).show();    	
    				e.printStackTrace();
    			}    
    			}
    		});

    		alert.show();    		
    }
    
    public void Truca(String s){
    	try {
    		Intent llamada = new Intent(Intent.ACTION_CALL);
    		Uri uriTlf = Uri.parse("tel:"+s);
    		llamada.setData(uriTlf);
    		startActivity(llamada);
    	} catch (Exception e) {
    		Toast.makeText(Ex9_1Activity.this,"Error intentant trucar a " + s + ". Error : " + e.getMessage(),Toast.LENGTH_SHORT).show();
    		e.printStackTrace();
    	}
    }
					           
    public void onStop() {
    	stopManagingCursor(cursor);
    	cursor.close();
    	super.onStop();
    }
    
    public void onResume() {    	
        cursor = getContentResolver().query(
        		ContactsContract.Contacts.CONTENT_URI,
        		new String[] {
        				ContactsContract.Contacts._ID,
        				ContactsContract.Contacts.DISPLAY_NAME },
        		null,
        		null,
        		null
        		);               
        
        startManagingCursor(cursor);
                
        adapter = 
        		new SimpleCursorAdapter(
        				Ex9_1Activity.this,
        				android.R.layout.simple_list_item_1,
        				cursor,
        				new String[] {ContactsContract.Contacts.DISPLAY_NAME},
        				new int[] {android.R.id.text1}
        		);
        
        setListAdapter(adapter);
        setSelection(LastPositionCursor);
    	
    	super.onResume();    	
    }
}