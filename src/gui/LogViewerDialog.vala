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


[GtkTemplate (ui = "/org/gnome/balistica/ui/logviewer.glade")]
public class Balistica.LogViewerDialog : Gtk.Dialog {
   [GtkChild]
   public Gtk.Button btnClear ;

   [GtkChild]
   public Gtk.Button btnRefresh ;

   [GtkChild]
   public Gtk.TreeView log_tree ;
   private Gtk.ListStore list_store ;

   private File log_file ;
   private Logging logger ;

   /**
    * Constructor
    */
   public LogViewerDialog (string log_file) {
	  this.log_file = File.new_for_path (log_file) ;
	  this.logger = Logging.get_default () ;

	  // Create a list store to populate the tree view
	  list_store = new Gtk.ListStore (4, typeof (string), typeof (string), typeof (string), typeof (string)) ;
	  log_tree.set_model (list_store) ;

	  var type_cell = new Gtk.CellRendererText () ;
	  type_cell.set ("foreground_set", true) ;
	  log_tree.insert_column_with_attributes (0, "Date/Time", new Gtk.CellRendererText (), "text", 0) ;
	  log_tree.insert_column_with_attributes (1, "Log Level", type_cell, "text", 1, "foreground", 2) ;
	  log_tree.insert_column_with_attributes (2, "Message", new Gtk.CellRendererText (), "text", 3) ;

	  LoadLogFile () ;
   }

   /**
    * Delete the current log file
    */
   [GtkCallback]
   public void btnClear_clicked() {
	  list_store.clear () ;
	  try {
		 this.log_file.delete () ;
	  } catch ( Error e ){
		 error ("Failed to delete log file!") ;
	  }
   }

   /**
    * Refresh the log window contents
    */
   [GtkCallback]
   public void btnRefresh_clicked() {
	  list_store.clear () ;
	  LoadLogFile () ;
   }

   /**
    * Load the log file into the application window
    */
   private void LoadLogFile() {
	  if( !this.log_file.query_exists ()){
		 try {
			this.log_file.create (FileCreateFlags.NONE) ;
		 } catch ( Error e ){
			error ("Failed to create new log file!") ;
		 }
	  }

	  try {
		 var dis = new DataInputStream (this.log_file.read ()) ;
		 string line ;
		 Gtk.TreeIter iter ;

		 while((line = dis.read_line (null)) != null ){
			string[] parts = line.split ("\t") ;
			// Skip any malformed lines
			if( parts.length <= 2 ){
			   continue ;
			}

			list_store.prepend (out iter) ;
			if( parts[1] == "ERROR" ){
			   list_store.set (iter, 0, parts[0], 1, parts[1], 2, "red", 3, parts[2]) ;
			} else {
			   list_store.set (iter, 0, parts[0], 1, parts[1], 2, "black", 3, parts[2]) ;
			}
		 }
	  } catch ( Error e ){
		 logger.publish (new LogMsg ("Reading log file " + e.message)) ;
	  }
   }

}
