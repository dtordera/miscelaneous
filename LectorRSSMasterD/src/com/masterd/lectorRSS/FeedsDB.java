package com.masterd.lectorRSS;
// Abstraccio de la base de dades

import android.provider.BaseColumns;

public class FeedsDB {

	// Nom i versió de la base de dades
	public static final String DB_NAME = "juego.db";
	public static final int DB_VERSION = 1;

	// Constructor (private per a no instanciar aquesta clase)
	private FeedsDB () {}

	// Taula Posts
	public static final class Posts implements BaseColumns
	{
		// Constructor (no instanciable)		
		private Posts() {}

		// Ordre per defecte
		public static final String DEFAULT_SORT_ORDER = "_ID DESC";

		// Abstracció noms i taula
		public static final String NOMBRE_TABLA = "feeds";
		public static final String _ID = "_id";	
		public static final String TITLE = "title";
		public static final String LINK = "link";
		public static final String COMMENTS = "comments";
		public static final String PUB_DATE = "pub_date";
		public static final String CREATOR = "creator";
		public static final String DESCRIPTION = "description";
		public static final String _COUNT = "7";
	}
}
