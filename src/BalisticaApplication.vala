/* Copyright 2012-2017 Steven Oliver <oliver.steven@gmail.com>
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

// Defined by cmake build script.
extern const string _VERSION_MAJOR ;
extern const string _VERSION_MINOR ;
extern const string _VERSION_COMMIT ;
extern const string _VERSION_DESC ;

namespace Balistica{

   /**
    * These are publicly shared strings that will be
    * available throughout the base of the application
    */
   public const string NAME = "balística" ;

   public const string VERSION_MAJOR = _VERSION_MAJOR ;
   public const string VERSION_MINOR = _VERSION_MINOR ;
   public const string VERSION_COMMIT = _VERSION_COMMIT ;
   public const string VERSION_DESC = _VERSION_DESC ;

   public const string[] AUTHORS =
   {
	  "Steven Oliver <oliver.steven@gmail.com>",
	  null
   } ;

   public class Application : Gtk.Application {
	  public Gtk.Window main_window ;
	  private Balistica.DragBox drag_content ;
	  private Balistica.TwistBox twist_content ;
	  private Balistica.StabilityBox stability_content ;
	  private Balistica.CaseBox case_content ;
	  private Balistica.PowderBox powder_content ;
	  private Balistica.PrimerBox primer_content ;
	  private Balistica.ProjectileBox projectile_content ;
	  private string data_dir ;
	  private string config_dir ;

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

		 main_window = new Gtk.Window () ;
		 Environment.set_application_name (Balistica.NAME) ;
		 Environment.set_prgname (Balistica.NAME) ;

		 // Setup the main window
		 main_window.title = Balistica.NAME ;
		 main_window.window_position = Gtk.WindowPosition.CENTER ;

		 // width x height
		 main_window.set_default_size (735, 750) ;

		 // Add the main layout box
		 Gtk.Box box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0) ;

		 // Add the menu bar across the top
		 Gtk.MenuBar menubar = new Gtk.MenuBar () ;

		 Gtk.MenuItem item_file = new Gtk.MenuItem.with_label ("File") ;
		 Gtk.Menu filemenu = new Gtk.Menu () ;
		 Gtk.MenuItem sub_item_log = new Gtk.MenuItem.with_label ("View Log") ;
		 filemenu.add (sub_item_log) ;
		 Gtk.SeparatorMenuItem separator = new Gtk.SeparatorMenuItem () ;
		 filemenu.add (separator) ;
		 Gtk.MenuItem sub_item_quit = new Gtk.MenuItem.with_label ("Quit") ;
		 filemenu.add (sub_item_quit) ;
		 item_file.set_submenu (filemenu) ;

		 Gtk.MenuItem item_help = new Gtk.MenuItem.with_label ("Help") ;
		 Gtk.Menu helpmenu = new Gtk.Menu () ;
		 Gtk.MenuItem sub_item_about = new Gtk.MenuItem.with_label ("About") ;
		 Gtk.MenuItem sub_item_help = new Gtk.MenuItem.with_label ("Help") ;

		 helpmenu.add (sub_item_about) ;
		 helpmenu.add (sub_item_help) ;
		 item_help.set_submenu (helpmenu) ;

		 menubar.add (item_file) ;
		 menubar.add (item_help) ;

		 // Connect menu entries
		 sub_item_quit.activate.connect (() => {
			quit_selected () ;
		 }) ;

		 sub_item_log.activate.connect (() => {
			log_viewer_selected () ;
		 }) ;

		 sub_item_help.activate.connect (() => {
			help_selected () ;
		 }) ;

		 sub_item_about.activate.connect (() => {
			about_selected () ;
		 }) ;

		 box.pack_start (menubar, false, false, 0) ;

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

		 // Attach the box (with the notebook) the main window and roll
		 main_window.add (box) ;
		 main_window.show_all () ;
		 this.add_window (main_window) ;

		 config_dir = this.setup_user_config_directory () ;
		 data_dir = this.setup_user_data_directory () ;

		 Logging.get_default ().publish.connect ((msg) => {
			this.log (msg) ;
		 }) ;
	  }

	  private Gtk.Frame build_calc_notebook() {
		 Gtk.Label drag_lbl = new Gtk.Label ("Drag") ;
		 Gtk.Label twist_lbl = new Gtk.Label ("Twist") ;
		 Gtk.Label stability_lbl = new Gtk.Label ("Stability") ;

		 Gtk.Frame frame = new Gtk.Frame("");
		 Gtk.Alignment alignment = new Gtk.Alignment(0.50f, 0.50f, 1.0f, 1.0f);
		 alignment.left_padding = 12;
		 frame.add(alignment);

		 Gtk.Notebook notebook = new Gtk.Notebook () ;
		 notebook.set_tab_pos (Gtk.PositionType.TOP) ;

		 // Create & add our pages to the calculations notebook
		 this.drag_content = new Balistica.DragBox (main_window) ;
		 notebook.append_page (drag_content, drag_lbl) ;

		 this.twist_content = new Balistica.TwistBox () ;
		 notebook.append_page (twist_content, twist_lbl) ;

		 this.stability_content = new Balistica.StabilityBox () ;
		 notebook.append_page (stability_content, stability_lbl) ;

		 alignment.add(notebook);

		 return frame ;
	  }

	  private Gtk.Frame build_db_notebook() {
		 Gtk.Label case_lbl = new Gtk.Label ("Case") ;
		 Gtk.Label powder_lbl = new Gtk.Label ("Powder") ;
		 Gtk.Label primer_lbl = new Gtk.Label ("Primer") ;
		 Gtk.Label projectile_lbl = new Gtk.Label ("Projectile") ;

		 Gtk.Frame frame = new Gtk.Frame("");
		 Gtk.Alignment alignment = new Gtk.Alignment(0.50f, 0.50f, 1.0f, 1.0f);
		 alignment.left_padding = 12;
		 frame.add(alignment);

		 Gtk.Notebook notebook = new Gtk.Notebook () ;
		 notebook.set_tab_pos (Gtk.PositionType.TOP) ;

		 this.case_content = new Balistica.CaseBox () ;
		 notebook.append_page (case_content, case_lbl) ;

		 this.powder_content = new Balistica.PowderBox () ;
		 notebook.append_page (powder_content, powder_lbl) ;

		 this.primer_content = new Balistica.PrimerBox () ;
		 notebook.append_page (primer_content, primer_lbl) ;

		 this.projectile_content = new Balistica.ProjectileBox () ;
		 notebook.append_page (projectile_content, projectile_lbl) ;

		 alignment.add(notebook);

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

		 main_window.present () ;
	  }

	  /**
	   * Quit application
	   */
	  private void quit_selected() {
		 main_window.destroy () ;
	  }

	  /**
	   * Show log viewer
	   */
	  private void log_viewer_selected() {
		 var dialog = new Balistica.LogViewerDialog (this.data_dir + "balistica.log") ;
		 dialog.set_transient_for (main_window) ;
		 dialog.show_all () ;
	  }

	  /**
	   * Show help browser
	   */
	  private void help_selected() {
		 try {
			Gtk.show_uri (main_window.get_screen (), "ghelp:balistica", Gtk.get_current_event_time ()) ;
		 } catch ( Error err ){
			Logging.get_default ().publish (new LogMsg ("Error showing help")) ;
		 }
	  }

	  /**
	   * Show about dialog
	   */
	  private void about_selected() {
		 string version ;

		 if( Balistica.VERSION_DESC == "Release" ){
			version = Balistica.VERSION_MAJOR + "." + Balistica.VERSION_MINOR ;
		 } else {
			version = Balistica.VERSION_MAJOR + "." + Balistica.VERSION_MINOR + "-" + Balistica.VERSION_COMMIT ;
		 }

		 Gtk.show_about_dialog (main_window,
								"authors", Balistica.AUTHORS,
								"comments", "An open source external ballistics calculator.",
								"copyright", "Copyright \xc2\xa9 2012-2017 Steven Oliver",
								"license-type", Gtk.License.GPL_3_0,
								"program-name", Balistica.NAME,
								"website", "http://steveno.github.io/balistica/",
								"website-label", "balística Website",
								"version", version) ;
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
			stdout.printf ("Error: %s\n", e.message) ;
		 }
	  }

   }
} // namespace
