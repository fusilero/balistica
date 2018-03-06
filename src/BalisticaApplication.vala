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

public class Application : Gtk.Application {
   public Gtk.ApplicationWindow main_window ;
   private Settings settings ;
   private Balistica.DragBox drag_content ;
   private Balistica.TwistBox twist_content ;
   private Balistica.StabilityBox stability_content ;
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

	  settings = new Settings ("org.gnome.balistica") ;

	  add_action_entries (action_entries, this) ;
	  main_window = new Gtk.ApplicationWindow (this) ;

	  // Setup the main window
	  main_window.title = NAME ;
	  main_window.window_position = Gtk.WindowPosition.CENTER ;

	  // HeaderBar
	  Gtk.StackSwitcher switcher = this.build_switcher () ;
	  Gtk.HeaderBar headerbar = new Gtk.HeaderBar () ;
	  headerbar.set_custom_title (switcher) ;
	  headerbar.set_show_close_button (true) ;
	  main_window.set_titlebar (headerbar) ;

	  // Add the main layout box
	  Gtk.Box box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0) ;
	  box.pack_start (switcher.get_stack(), true, true, 0) ;

	  config_dir = this.setup_user_directory (Environment.get_user_config_dir ()) ;
	  data_dir = this.setup_user_directory (Environment.get_user_data_dir ()) ;

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

   protected override void shutdown() {
	  base.shutdown () ;
   }

   private Gtk.StackSwitcher build_switcher() {
	  Gtk.Stack stack = new Gtk.Stack () ;
	  Gtk.StackSwitcher switcher = new Gtk.StackSwitcher () ;

	  stack.set_transition_type (Gtk.StackTransitionType.CROSSFADE) ;
	  switcher.set_stack (stack) ;

	  this.drag_content = new Balistica.DragBox (this.main_window) ;
	  this.twist_content = new Balistica.TwistBox () ;
	  this.stability_content = new Balistica.StabilityBox () ;

	  stack.add_titled (drag_content, "Page1", "Drag") ;
	  stack.add_titled (twist_content, "Page2", "Twist") ;
	  stack.add_titled (stability_content, "Page3", "Stability") ;

	  return switcher ;
   }

   /**
    * Return the current user's data directory
    */
   private string setup_user_directory(string user_dir) {
	  string dir = user_dir + "/balistica/" ;
	  try {
		 File file = File.new_for_path (dir) ;
		 file.make_directory_with_parents () ;
	  } catch ( Error err ){
		 // The user may have already created the directory, so don't throw EXISTS.
		 if( !(err is IOError.EXISTS)){
			Gtk.MessageDialog msg = new Gtk.MessageDialog (this.main_window, Gtk.DialogFlags.MODAL, Gtk.MessageType.ERROR, Gtk.ButtonsType.OK, "Failed to create XDG directory " + user_dir) ;
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

	  return dir ;
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
	  string[] authors = { "Steven Oliver" } ;
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

   /**
    * Main function
    */
   public static int main(string[] args) {
	  // Setup internationalization
	  Intl.setlocale (LocaleCategory.ALL, "") ;
	  Intl.bindtextdomain (GETTEXT_PACKAGE, LOCALE_DIR) ;
	  Intl.bind_textdomain_codeset (GETTEXT_PACKAGE, "UTF-8") ;
	  Intl.textdomain (GETTEXT_PACKAGE) ;

	  Environment.set_application_name (NAME) ;

	  var app = new Application () ;
	  return app.run (args) ;
   }

}
