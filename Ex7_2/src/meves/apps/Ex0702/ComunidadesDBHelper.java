package meves.apps.Ex0702;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class ComunidadesDBHelper extends SQLiteOpenHelper {

	public ComunidadesDBHelper(Context context) {
		super(context,"ComunidadesDB",null,1);		
	}
		
	@Override
	public void onCreate(SQLiteDatabase db) {	
		if (db.isReadOnly()) { db=getWritableDatabase(); }
		db.execSQL("create table comunidades (_id integer primary key autoincrement, nombre varchar(25) );");
	}

	@Override
	public void onUpgrade(SQLiteDatabase arg0, int arg1, int arg2) {
		// TODO Auto-generated method stub

	}
}
