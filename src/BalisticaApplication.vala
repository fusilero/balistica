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
	  private Balistica.PbrWindow pbr_window ;
	  private Balistica.DragMain drag_content ;

	  private Gtk.Builder twist_builder ;
	  private Gtk.Builder stability_builder ;

	  // Drag calculation results
	  private Gtk.TextView drag_results ;

	  // Drag calculation Buttons
	  private Gtk.Button export_results ;
	  private Gtk.Button calc_pbr ;

	  // Radio buttons for drag functions
	  private Gtk.RadioButton rad_g1 ;

	  // Radio buttons for calculation step size
	  private Gtk.RadioButton rad_s10 ;

	  // Twist fields
	  private Gtk.Entry miller_diameter ;
	  private Gtk.Entry miller_length ;
	  private Gtk.Entry miller_mass ;
	  private Gtk.Entry miller_safe_value ;
	  private Gtk.Entry greenhill_diameter ;
	  private Gtk.Entry greenhill_length ;
	  private Gtk.Entry greenhill_spec_gravity ;
	  private Gtk.Entry greenhill_c ;
	  private Gtk.Entry twist_results ;

	  // Twist buttons
	  private Gtk.Button reset_twist ;
	  private Gtk.Button solve_twist ;

	  // Radio buttons for calculation step size
	  private Gtk.RadioButton rad_greenhill ;
	  private Gtk.RadioButton rad_miller ;

	  // Stability fields
	  private Gtk.Entry miller_sta_diameter ;
	  private Gtk.Entry miller_sta_length ;
	  private Gtk.Entry miller_sta_mass ;
	  private Gtk.Entry miller_sta_safe_value ;
	  private Gtk.Entry stability_results ;

	  // Stability buttons
	  private Gtk.Button reset_stability ;
	  private Gtk.Button solve_stability ;

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

		 // Add the main layout grid
		 Gtk.Grid grid = new Gtk.Grid () ;

		 // Add the menu bar across the top
		 Gtk.MenuBar menubar = new Gtk.MenuBar () ;

		 Gtk.MenuItem item_file = new Gtk.MenuItem.with_label ("File") ;
		 Gtk.Menu filemenu = new Gtk.Menu () ;
		 Gtk.MenuItem sub_item_demo = new Gtk.MenuItem.with_label ("Populate Demo") ;
		 filemenu.add (sub_item_demo) ;
		 Gtk.MenuItem sub_item_quit = new Gtk.MenuItem.with_label ("Quit") ;
		 filemenu.add (sub_item_quit) ;
		 item_file.set_submenu (filemenu) ;

		 sub_item_demo.activate.connect (() => {
			// FIXME
		 }) ;

		 sub_item_quit.activate.connect (() => {
			quit_selected () ;
		 }) ;

		 Gtk.MenuItem item_help = new Gtk.MenuItem.with_label ("Help") ;
		 Gtk.Menu helpmenu = new Gtk.Menu () ;
		 Gtk.MenuItem sub_item_about = new Gtk.MenuItem.with_label ("About") ;
		 Gtk.MenuItem sub_item_help = new Gtk.MenuItem.with_label ("Help") ;

		 helpmenu.add (sub_item_about) ;
		 helpmenu.add (sub_item_help) ;
		 item_help.set_submenu (helpmenu) ;

		 sub_item_help.activate.connect (() => {
			help_selected () ;
		 }) ;

		 sub_item_about.activate.connect (() => {
			about_selected () ;
		 }) ;

		 menubar.add (item_file) ;
		 menubar.add (item_help) ;

		 grid.attach (menubar, 0, 0, 1, 1) ;

		 // Add the notebook that will eventually hold everything else
		 Gtk.Notebook notebook = new Gtk.Notebook () ;

		 // Create the drag page of the notebook
		 this.drag_content = new Balistica.DragMain () ;
		 notebook.append_page (drag_content, new Gtk.Label ("Drag")) ;

		 // Create the twist page of the notebook
		 twist_builder = Balistica.create_builder ("twist.glade") ;
		 twist_builder.connect_signals (null) ;
		 var twist_content = twist_builder.get_object ("twist_main") as Gtk.Box ;
		 notebook.append_page (twist_content, new Gtk.Label ("Twist")) ;

		 // Create the stability page of the notebook
		 stability_builder = Balistica.create_builder ("stability.glade") ;
		 stability_builder.connect_signals (null) ;
		 var stability_content = stability_builder.get_object ("stability_main") as Gtk.Box ;
		 notebook.append_page (stability_content, new Gtk.Label ("Stability")) ;

		 // Attach the grid (with the notebook) the main window and roll
		 grid.attach (notebook, 0, 1, 1, 1) ;
		 main_window.add (grid) ;
		 main_window.show_all () ;
		 this.add_window (main_window) ;
		 connect_entries () ;
	  }

	  /**
	   * Present the existing main window, or create a new one.
	   */
	  protected override void activate() {
		 base.activate () ;

		 main_window.present () ;
	  }

	  /**
	   * Connect the GUI elements to our code so we can play with them
	   */
	  public void connect_entries() {
		 // Drag Calculations Results
		 drag_results = drag_content.txtViewDragResults ;

		 // Set G1 as selected by default
		 rad_g1 = drag_content.rad_g1 ;
		 rad_g1.active = true ;

		 // Set G1 as selected by default
		 rad_s10 = drag_content.rad_s10 ;
		 rad_s10.active = true ;

		 // Buttons
		 export_results = drag_content.btnExportResults ;
		 export_results.set_sensitive (false) ;

		 calc_pbr = drag_content.btnCalcPBR ;
		 calc_pbr.set_sensitive (false) ;

		 // Setup twist entries & results
		 miller_diameter = twist_builder.get_object ("txtMDiameter") as Gtk.Entry ;
		 miller_length = twist_builder.get_object ("txtMLength") as Gtk.Entry ;
		 miller_mass = twist_builder.get_object ("txtMass") as Gtk.Entry ;
		 miller_safe_value = twist_builder.get_object ("txtSafeValue") as Gtk.Entry ;

		 greenhill_diameter = twist_builder.get_object ("txtGDiameter") as Gtk.Entry ;
		 greenhill_length = twist_builder.get_object ("txtGLength") as Gtk.Entry ;
		 greenhill_spec_gravity = twist_builder.get_object ("txtSpecificGravity") as Gtk.Entry ;
		 greenhill_c = twist_builder.get_object ("txtC") as Gtk.Entry ;

		 twist_results = twist_builder.get_object ("txtResult") as Gtk.Entry ;

		 // Twist buttons
		 reset_twist = twist_builder.get_object ("btnReset") as Gtk.Button ;
		 reset_twist.clicked.connect (() => {
			btnResetTwist_clicked () ;
		 }) ;

		 solve_twist = twist_builder.get_object ("btnCalculate") as Gtk.Button ;
		 solve_twist.clicked.connect (() => {
			btnSolveTwist_clicked () ;
		 }) ;

		 // Radio buttons for twist calculation type
		 rad_miller = twist_builder.get_object ("radMiller") as Gtk.RadioButton ;
		 rad_greenhill = twist_builder.get_object ("radGreenhill") as Gtk.RadioButton ;

		 rad_miller.toggled.connect (() => {
			miller_diameter.set_sensitive (true) ;
			miller_length.set_sensitive (true) ;
			miller_mass.set_sensitive (true) ;
			miller_safe_value.set_sensitive (true) ;

			greenhill_diameter.set_sensitive (false) ;
			greenhill_length.set_sensitive (false) ;
			greenhill_spec_gravity.set_sensitive (false) ;
			greenhill_c.set_sensitive (false) ;
		 }) ;

		 rad_greenhill.toggled.connect (() => {
			miller_diameter.set_sensitive (false) ;
			miller_length.set_sensitive (false) ;
			miller_mass.set_sensitive (false) ;
			miller_safe_value.set_sensitive (false) ;

			greenhill_diameter.set_sensitive (true) ;
			greenhill_length.set_sensitive (true) ;
			greenhill_spec_gravity.set_sensitive (true) ;
			greenhill_c.set_sensitive (true) ;
		 }) ;

		 // Default Twist calculation type
		 rad_miller.active = true ;


		 // Stability fields
		 miller_sta_diameter = stability_builder.get_object ("txtMDiameter") as Gtk.Entry ;
		 miller_sta_length = stability_builder.get_object ("txtMLength") as Gtk.Entry ;
		 miller_sta_mass = stability_builder.get_object ("txtMass") as Gtk.Entry ;
		 miller_sta_safe_value = stability_builder.get_object ("txtSafeValue") as Gtk.Entry ;

		 stability_results = stability_builder.get_object ("txtResult") as Gtk.Entry ;

		 // Stability buttons
		 reset_stability = stability_builder.get_object ("btnReset") as Gtk.Button ;
		 reset_stability.clicked.connect (() => {
			btnResetStability_clicked () ;
		 }) ;

		 solve_stability = stability_builder.get_object ("btnCalculate") as Gtk.Button ;
		 solve_stability.clicked.connect (() => {
			btnSolveStability_clicked () ;
		 }) ;
	  }

	  /**
	   * Display popup to calculate Point Blank Range (PBR)
	   */
	  public void btnCalcPBR_clicked() {
		 if( pbr_window == null ){
			pbr_window = new PbrWindow (this.main_window) ;
			pbr_window.destroy.connect (() => { pbr_window = null ; }) ;
			pbr_window.show_all () ;
		 } else {
			pbr_window.present () ;
		 }
	  }

	  /**
	   * Reset the front end to prepare for a new twist calculation
	   */
	  public void btnResetTwist_clicked() {
		 miller_diameter.set_text ("") ;
		 miller_length.set_text ("") ;
		 miller_mass.set_text ("") ;
		 miller_safe_value.set_text ("") ;

		 greenhill_diameter.set_text ("") ;
		 greenhill_length.set_text ("") ;
		 greenhill_spec_gravity.set_text ("") ;
		 greenhill_c.set_text ("") ;

		 twist_results.set_text ("") ;
	  }

	  /**
	   * Solve the twist calculation for the selected formula
	   */
	  public void btnSolveTwist_clicked() {
		 if( rad_miller.get_active ()){
			LibBalistica.Miller m = new LibBalistica.Miller () ;

			m.diameter = double.parse (miller_diameter.get_text ()) ;
			m.length = double.parse (miller_length.get_text ()) ;
			m.mass = double.parse (miller_mass.get_text ()) ;
			m.safe_value = int.parse (miller_safe_value.get_text ()) ;

			twist_results.set_text (m.calc_twist ().to_string ()) ;
		 } else {
			LibBalistica.Greenhill g = new LibBalistica.Greenhill () ;

			g.diameter = double.parse (greenhill_diameter.get_text ()) ;
			g.length = double.parse (greenhill_length.get_text ()) ;
			g.specific_gravity = double.parse (greenhill_spec_gravity.get_text ()) ;
			g.C = int.parse (greenhill_c.get_text ()) ;

			twist_results.set_text (g.calc_twist ().to_string ()) ;
		 }
	  }

	  /**
	   * Reset the front end to prepare for a new stability calculation
	   */
	  public void btnResetStability_clicked() {
		 miller_sta_diameter.set_text ("") ;
		 miller_sta_length.set_text ("") ;
		 miller_sta_mass.set_text ("") ;
		 miller_sta_safe_value.set_text ("") ;

		 stability_results.set_text ("") ;
	  }

	  /**
	   * Solve the stability calculation
	   */
	  public void btnSolveStability_clicked() {
		 LibBalistica.Miller m = new LibBalistica.Miller () ;

		 m.diameter = double.parse (miller_sta_diameter.get_text ()) ;
		 m.length = double.parse (miller_sta_length.get_text ()) ;
		 m.mass = double.parse (miller_sta_mass.get_text ()) ;
		 m.safe_value = int.parse (miller_sta_safe_value.get_text ()) ;

		 stability_results.set_text (m.calc_stability ().to_string ()) ;
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
			display_error ("Error showing help", err, this.main_window) ;
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
	   * Display an error dialog to the user
	   */
	  public static void display_error(string error_msg, GLib.Error ? err, Gtk.Window window) {
		 Gtk.Dialog dialog = new Gtk.Dialog.with_buttons ("Error", window, Gtk.DialogFlags.DESTROY_WITH_PARENT, "OK", Gtk.ResponseType.CLOSE, null) ;
		 dialog.response.connect (() => { dialog.destroy () ; }) ;

		 if( err != null ){
			dialog.get_content_area ().add (new Gtk.Label (error_msg + ": %s".printf (err.message))) ;
		 } else {
			dialog.get_content_area ().add (new Gtk.Label (error_msg)) ;
		 }

		 dialog.show_all () ;
		 dialog.run () ;
	  }

   }
} // namespace
