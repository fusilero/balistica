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
	  private GLib.Settings settings ;
	  public Gtk.Window main_window ;
	  private Balistica.DragBox drag_content ;
	  private Balistica.TwistBox twist_content ;
	  private Balistica.StabilityBox stability_content ;

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

		 settings = new GLib.Settings ("org.gnome.balistica") ;

		 main_window = new Gtk.Window () ;
		 Environment.set_application_name (Balistica.NAME) ;

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

		 sub_item_help.activate.connect (() => {
			help_selected () ;
		 }) ;

		 sub_item_about.activate.connect (() => {
			about_selected () ;
		 }) ;

		 box.pack_start (menubar, false, false, 0) ;

		 // Create labels here so that we can add pango formatting
		 Gtk.Label drag_lbl = new Gtk.Label ("<big>Drag</big>") ;
		 drag_lbl.set_use_markup (true) ;

		 Gtk.Label twist_lbl = new Gtk.Label ("<big>Twist</big>") ;
		 twist_lbl.set_use_markup (true) ;

		 Gtk.Label stability_lbl = new Gtk.Label ("<big>Stability</big>") ;
		 stability_lbl.set_use_markup (true) ;

		 // Add the notebook that will eventually hold everything else
		 Gtk.Notebook notebook = new Gtk.Notebook () ;
		 notebook.set_tab_pos (Gtk.PositionType.LEFT) ;

		 // Create & add our pages to the notebook
		 this.drag_content = new Balistica.DragBox () ;
		 notebook.append_page (drag_content, drag_lbl) ;

		 this.twist_content = new Balistica.TwistBox () ;
		 notebook.append_page (twist_content, twist_lbl) ;

		 this.stability_content = new Balistica.StabilityBox () ;
		 notebook.append_page (stability_content, stability_lbl) ;

		 box.pack_start (notebook, true, true, 0) ;

		 // Attach the box (with the notebook) the main window and roll
		 main_window.add (box) ;
		 main_window.show_all () ;
		 this.add_window (main_window) ;

		 ErrorHandler.get_default ().publish.connect ((err) => {
			// FIXME At some point this should log errors somewhere
		 }) ;
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
	   * Show help browser
	   */
	  private void help_selected() {
		 try {
			Gtk.show_uri (main_window.get_screen (), "ghelp:balistica", Gtk.get_current_event_time ()) ;
		 } catch ( Error err ){
			ErrorHandler.get_default ().publish (new IOError.FAILED ("Error showing help")) ;
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

   }
} // namespace
