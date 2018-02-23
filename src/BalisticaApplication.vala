/* Copyright 2012-2018 Steven Oliver <oliver.steven@gmail.com>
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


const string NAME = "balística" ;
const string VERSION = "1.3" ;
const string VERSION_DESC = "Debug" ;

public class Application : Gtk.Application {
   public Gtk.ApplicationWindow main_window ;
   private Balistica.DragBox drag_content ;
   private Balistica.TwistBox twist_content ;
   private Balistica.StabilityBox stability_content ;
   private Balistica.CaseBox case_content ;
   private Balistica.PowderBox powder_content ;
   private Balistica.PrimerBox primer_content ;
   private Balistica.ProjectileBox projectile_content ;
   private string data_dir ;
   private string config_dir ;
   private Logging logger ;

   private const GLib.ActionEntry[] action_entries =
   {
	  { "view_log", view_log_cb },
	  { "help", help_cb },
	  { "about", about_cb },
	  { "quit", quit_cb },
   } ;

   /**
    * Constructor
    */
   public Application () {
	  GLib.Object (application_id: "org.gnome.balistica", flags : ApplicationFlags.HANDLES_OPEN) ;
   }

   /**
    * Override the default GTK startup procedure
    */
   protected override void startup() {
	  base.startup () ;

	  add_action_entries (action_entries, this) ;
	  main_window = new Gtk.ApplicationWindow (this) ;
	  Environment.set_application_name (NAME) ;

	  // Setup the main window
	  main_window.title = NAME ;
	  main_window.window_position = Gtk.WindowPosition.CENTER ;

	  // width x height
	  main_window.set_default_size (735, 750) ;

	  // Add the main layout box
	  Gtk.Box box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0) ;

	  // Add the outer notebook that will hold everything
	  Gtk.Notebook notebook = new Gtk.Notebook () ;
	  notebook.set_tab_pos (Gtk.PositionType.LEFT) ;

	  // Pango formatted labels to help visually distinguish
	  Gtk.Label calcs_lbl = new Gtk.Label ("<big>Calculations</big>") ;
	  calcs_lbl.set_use_markup (true) ;

	  Gtk.Label db_lbl = new Gtk.Label ("<big>Database</big>") ;
	  db_lbl.set_use_markup (true) ;

	  notebook.append_page (build_calc_notebook (), calcs_lbl) ;
	  notebook.append_page (build_db_notebook (), db_lbl) ;

	  box.pack_start (notebook, true, true, 0) ;

	  config_dir = this.setup_user_config_directory () ;
	  data_dir = this.setup_user_data_directory () ;

	  Logging.get_default ().publish.connect ((msg) => {
		 this.log (msg) ;
	  }) ;
	  this.logger = Logging.get_default () ;

	  var builder = new Gtk.Builder () ;
	  try {
		 builder.add_from_resource ("/org/gnome/balistica/gtk/menu.ui") ;
	  } catch ( Error e ){
		 logger.publish (new LogMsg (e.message)) ;
	  }

	  var menu = builder.get_object ("appmenu") as GLib.MenuModel ;
	  set_app_menu (menu) ;

	  // Attach the box (with the notebook) the main window and roll
	  main_window.add (box) ;
	  this.add_window (main_window) ;
	  main_window.show_all () ;
   }

   private Gtk.Frame build_calc_notebook() {
	  Gtk.Label drag_lbl = new Gtk.Label ("Drag") ;
	  Gtk.Label twist_lbl = new Gtk.Label ("Twist") ;
	  Gtk.Label stability_lbl = new Gtk.Label ("Stability") ;

	  Gtk.Frame frame = new Gtk.Frame ("") ;
	  Gtk.Viewport port = new Gtk.Viewport (null, null) ;
	  frame.add (port) ;

	  Gtk.Notebook notebook = new Gtk.Notebook () ;
	  notebook.set_tab_pos (Gtk.PositionType.TOP) ;

	  // Create & add our pages to the calculations notebook
	  this.drag_content = new Balistica.DragBox (this.main_window) ;
	  notebook.append_page (drag_content, drag_lbl) ;

	  this.twist_content = new Balistica.TwistBox () ;
	  notebook.append_page (twist_content, twist_lbl) ;

	  this.stability_content = new Balistica.StabilityBox () ;
	  notebook.append_page (stability_content, stability_lbl) ;

	  port.add (notebook) ;

	  return frame ;
   }

   private Gtk.Frame build_db_notebook() {
	  Gtk.Label case_lbl = new Gtk.Label ("Case") ;
	  Gtk.Label powder_lbl = new Gtk.Label ("Powder") ;
	  Gtk.Label primer_lbl = new Gtk.Label ("Primer") ;
	  Gtk.Label projectile_lbl = new Gtk.Label ("Projectile") ;

	  Gtk.Frame frame = new Gtk.Frame ("") ;
	  Gtk.Viewport port = new Gtk.Viewport (null, null) ;
	  frame.add (port) ;

	  Gtk.Notebook notebook = new Gtk.Notebook () ;
	  notebook.set_tab_pos (Gtk.PositionType.TOP) ;

	  // Create & add our pages to the database notebook
	  this.case_content = new Balistica.CaseBox () ;
	  notebook.append_page (case_content, case_lbl) ;

	  this.powder_content = new Balistica.PowderBox () ;
	  notebook.append_page (powder_content, powder_lbl) ;

	  this.primer_content = new Balistica.PrimerBox () ;
	  notebook.append_page (primer_content, primer_lbl) ;

	  this.projectile_content = new Balistica.ProjectileBox () ;
	  notebook.append_page (projectile_content, projectile_lbl) ;

	  port.add (notebook) ;

	  return frame ;
   }

   /**
    * Return the current user's configuration directory
    */
   private string setup_user_config_directory() {
	  string config_dir = Environment.get_user_config_dir () + "/balistica/" ;
	  try {
		 File file = File.new_for_path (config_dir) ;
		 file.make_directory_with_parents () ;
	  } catch ( Error err ){
		 // The user may have already created the directory, so don't throw EXISTS.
		 if( !(err is IOError.EXISTS)){
			Gtk.MessageDialog msg = new Gtk.MessageDialog (this.main_window, Gtk.DialogFlags.MODAL, Gtk.MessageType.ERROR, Gtk.ButtonsType.OK, "Failed to create XDG configuration directory") ;
			msg.response.connect ((response_id) => {
			   switch( response_id ){
			   case Gtk.ResponseType.OK:
				  stdout.puts ("Ok\n") ;
				  break ;
			   }

			   msg.destroy () ;
			}) ;
			msg.show () ;
		 }
	  }

	  return config_dir ;
   }

   /**
    * Return the current user's data directory
    */
   private string setup_user_data_directory() {
	  string data_dir = Environment.get_user_data_dir () + "/balistica/" ;
	  try {
		 File file = File.new_for_path (data_dir) ;
		 file.make_directory_with_parents () ;
	  } catch ( Error err ){
		 // The user may have already created the directory, so don't throw EXISTS.
		 if( !(err is IOError.EXISTS)){
			Gtk.MessageDialog msg = new Gtk.MessageDialog (this.main_window, Gtk.DialogFlags.MODAL, Gtk.MessageType.ERROR, Gtk.ButtonsType.OK, "Failed to create XDG data directory") ;
			msg.response.connect ((response_id) => {
			   switch( response_id ){
			   case Gtk.ResponseType.OK:
				  stdout.puts ("Ok\n") ;
				  break ;
			   }

			   msg.destroy () ;
			}) ;
			msg.show () ;
		 }
	  }

	  return data_dir ;
   }

   /**
    * Present the existing main window, or create a new one.
    */
   protected override void activate() {
	  base.activate () ;

	  this.main_window.present () ;
   }

   /**
    * Quit application
    */
   private void quit_cb() {
	  get_active_window ().destroy () ;
   }

   /**
    * Show log viewer
    */
   private void view_log_cb() {
	  var dialog = new Balistica.LogViewerDialog (this.data_dir + "balistica.log") ;
	  dialog.set_transient_for (get_active_window ()) ;
	  dialog.show_all () ;
   }

   /**
    * Show help browser
    */
   private void help_cb() {
	  try {
		 Gtk.show_uri_on_window (get_active_window (), "help:balistica", Gtk.get_current_event_time ()) ;
	  } catch ( Error err ){
		 Logging.get_default ().publish (new LogMsg ("Error showing help")) ;
	  }
   }

   /**
    * Show about dialog
    */
   private void about_cb() {
	  string[] authors = {"Steven Oliver"};
	  Gtk.show_about_dialog (get_active_window (),
							 "authors", authors,
							 "comments", "An open source external ballistics calculator.",
							 "copyright", "Copyright \xc2\xa9 2012-2018 Steven Oliver",
							 "license-type", Gtk.License.GPL_3_0,
							 "program-name", NAME,
							 "website", "http://steveno.github.io/balistica/",
							 "website-label", "balística Website",
							 "version", VERSION,
							 "logo-icon-name", "balistica") ;
   }

   /**
    * Append new log entry to the log
    */
   private void log(LogMsg msg) {
	  File file = File.new_for_path (this.data_dir + "balistica.log") ;
	  var dt = new DateTime.now_local ().format ("%F %T") ;
	  string entry = dt.to_string () + "\t" + msg.level.to_string () + "\t" + msg.message + "\n" ;

	  try {
		 FileOutputStream os = file.append_to (FileCreateFlags.NONE) ;
		 os.write (entry.data) ;
	  } catch ( Error e ){
		 error ("Error: %s\n", e.message) ;
	  }
   }

   public static int main(string[] args) {
	  var app = new Application () ;
	  return app.run (args) ;
   }
}
