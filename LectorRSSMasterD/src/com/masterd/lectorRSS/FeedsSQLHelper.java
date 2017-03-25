// FeedsSQLHelper : clase de tractament de la base de dades

package com.masterd.lectorRSS;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class FeedsSQLHelper extends SQLiteOpenHelper {
	// Constructor
	public FeedsSQLHelper(Context context) {
		super(context, FeedsDB.DB_NAME, null, FeedsDB.DB_VERSION);
	}
	
	// Creació de la base de dades
	@Override
	public void onCreate(SQLiteDatabase db) {
		if(db.isReadOnly()) { db=getWritableDatabase(); }
		
		db.execSQL("CREATE TABLE " +
				FeedsDB.Posts.NOMBRE_TABLA + " (" +
				FeedsDB.Posts._ID + " INTEGER PRIMARY KEY AUTOINCREMENT," +
				FeedsDB.Posts.TITLE + " TEXT," +
				FeedsDB.Posts.LINK + " TEXT UNIQUE," +
				FeedsDB.Posts.COMMENTS + " TEXT," +
				FeedsDB.Posts.PUB_DATE + " INTEGER" +
				FeedsDB.Posts.CREATOR + " TEXT, " +
				FeedsDB.Posts.DESCRIPTION + " TEXT" + ")"
				);
	}

	// No es fa res
	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion,int newVersion) {}
}
