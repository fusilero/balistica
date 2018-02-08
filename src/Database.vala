/* Copyright 2018 Steven Oliver <oliver.steven@gmail.com>
 *
 * This file is part of balística.
 *
 * balística is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * balística is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with balística.  If not, see <http://www.gnu.org/licenses/>.
 */

public class Balistica.Database {
   private Sqlite.Database db ;
   private GLib.File filename ;

   /**
    * Constructor
    */
   public Database (string file_path, string file_name) {
	  this.filename = GLib.File.new_for_path (file_path + file_name) ;
   }

   /**
    * Open database
    *
    * This will attempt to create a new database if it doesn't already exist.
    */
   public void open_db() {
	  int ec ;
	  if( this.create_db ()){
		 ec = Sqlite.Database.open_v2 (this.filename.get_uri (), out this.db, Sqlite.OPEN_READWRITE, null) ;

		 if( ec != Sqlite.OK )
			Logging.get_default ().publish (new LogMsg ("Failed to open DB: Unknown reason")) ;
	  }
   }

   /**
    * Create a new database file
    */
   private bool create_db() {
	  try {
		 this.filename.get_parent ().make_directory_with_parents () ;
	  } catch ( GLib.Error e ){
		 if( !(e is GLib.IOError.EXISTS)){
			string msg = "Cannot create new database: " + e.message ;
			Logging.get_default ().publish (new LogMsg (msg)) ;
			return false ;
		 }
	  }

	  return true ;
   }

   /**
    * Execute a statement against the database.
    *
    * These should typically not return data.
    */
   public bool exec(string sql) {
	  string errmsg ;
	  int ec = this.db.exec (sql, null, out errmsg) ;
	  if( ec != Sqlite.OK ){
		 Logging.get_default ().publish (new LogMsg (errmsg)) ;
		 return false ;
	  }

	  return true ;
   }

   /**
    * Get the ID of the last inserted row.
    */
   public int64 get_last_insert_id() {
	  int64 last_id = this.db.last_insert_rowid () ;
	  return last_id ;
   }

   public void query(string sql) {
	  // Place holder for query function
   }

}
