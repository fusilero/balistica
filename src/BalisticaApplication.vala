/* Copyright 2012-2016 Steven Oliver <oliver.steven@gmail.com>
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

using GLib;
using Gtk;

// Defined by cmake build script.
extern const string _VERSION_MAJOR;
extern const string _VERSION_MINOR;
extern const string _VERSION_REVISION;
extern const string _VERSION_COMMIT;
extern const string _VERSION_DESC;

extern const string _GSETTINGS_DIR;

namespace Balistica {
    /**
     * These are publicly shared strings that will be
     * available throughout the base of the application
     */
    public const string NAME = "balística";
    public const string COPYRIGHT = "Copyright © 2012-2016 Steven Oliver";
    public const string WEBSITE = "http://steveno.github.io/balistica/";

    public const string DESKTOP_NAME = "balística";
    public const string DESKTOP_GENERIC_NAME = "Ballistics Calculator";
    public const string DESKTOP_KEYWORDS = "ballistics;calculator;";

    public const string VERSION_MAJOR = _VERSION_MAJOR;
    public const string VERSION_MINOR = _VERSION_MINOR;
    public const string VERSION_REVISION = _VERSION_REVISION;
    public const string VERSION_COMMIT = _VERSION_COMMIT;
    public const string VERSION_DESC = _VERSION_DESC;

    public const string GSETTINGS_DIR = _GSETTINGS_DIR;

    public const string[] AUTHORS = {
        "Steven Oliver <oliver.steven@gmail.com>",
        null
    };

   
    public class Application : Gtk.Application {
        private GLib.Settings settings;
        private Gtk.Window main_window;
        private Gtk.Builder drag_builder;
        private Gtk.Builder twist_builder;
        
        // Drag calculation entry fields
        private Gtk.Entry calc_name;
        private Gtk.Entry drag_coefficient;
        private Gtk.Entry projectile_weight;
        private Gtk.Entry initial_velocity;
        private Gtk.Entry zero_range;
        private Gtk.Entry sight_height;
        private Gtk.Entry shooting_angle;
        private Gtk.Entry wind_velocity;
        private Gtk.Entry wind_angle;
        private Gtk.Entry altitude;
        private Gtk.Entry temp;
        private Gtk.Entry bar_press;
        private Gtk.Entry rela_humid;
        
        // Checkbox for atmospheric corrections
        private Gtk.CheckButton enable_atmosphere;
        
        // Drag calculation results
        private Gtk.TextView drag_results;
        
        // Drag calculation Buttons
        private Gtk.Button reset_drag;
        private Gtk.Button solve_drag;
        private Gtk.Button disp_solution;
        private Gtk.Button disp_pbr;
        
        // Radio buttons for drag functions
        private Gtk.RadioButton rad_g1;
        private Gtk.RadioButton rad_g2;
        private Gtk.RadioButton rad_g5;
        private Gtk.RadioButton rad_g6;
        private Gtk.RadioButton rad_g7;
        private Gtk.RadioButton rad_g8;

        public static bool miller_twist = false;
        public static bool miller_stability = false;
        public static bool greenhill = false;
        public static bool help = false;
        public static bool version = false;

        /**
         *
         */
        public Application() {
            GLib.Object (application_id: "org.gnome.balistica");
        }

        /**
         * Override the default GTK startup procedure
         */
        protected override void startup() {
            settings = new GLib.Settings("org.gnome.balistica");

            string[] args = { null };
            unowned string[] arguments = args;

            Gtk.init (ref arguments);
            base.startup(); 
            
            //Gtk.Menu menu = new Gtk.Menu();
            //Gtk.MenuItem item_about = new Gtk.MenuItem.with_label("About");
            //menu.append(item_about);
            //this.app_menu = menu;
        }

        /**
         * Present the existing main window, or create a new one.
         */
        protected override void activate() {
            if (this.get_windows() != null) {
                main_window.present();
            } else {
                common_init();
            }
        }

        /**
         * Intialization sequence for the GUI
         */
        private void common_init() {
            if (this.get_windows() == null) {
                main_window = new Gtk.Window();
                Environment.set_application_name(NAME);

                // Setup the main window
                main_window.title = "balística";
                main_window.window_position = Gtk.WindowPosition.CENTER;
                main_window.set_default_size(830, 550);
                main_window.destroy.connect(Gtk.main_quit);

                // Add the main layout grid
                Gtk.Grid grid = new Gtk.Grid();
                
                // Add the menu bar across the top
                Gtk.MenuBar menubar = new Gtk.MenuBar();

                Gtk.MenuItem item_file = new Gtk.MenuItem.with_label("File");
                Gtk.Menu filemenu = new Gtk.Menu();
                Gtk.MenuItem sub_item_new = new Gtk.MenuItem.with_label("New");
                Gtk.MenuItem sub_item_open = new Gtk.MenuItem.with_label("Open");
                Gtk.MenuItem sub_item_save = new Gtk.MenuItem.with_label("Save");
                Gtk.MenuItem sub_item_save_as = new Gtk.MenuItem.with_label("Save As");
                Gtk.MenuItem sub_item_quit = new Gtk.MenuItem.with_label("Quit");

                filemenu.add(sub_item_new);
                filemenu.add(sub_item_open);
                filemenu.add(sub_item_save);
                filemenu.add(sub_item_save_as);
                filemenu.add(sub_item_quit);
                item_file.set_submenu(filemenu);

                sub_item_quit.activate.connect(() => {
                        quit_selected();
                });

                Gtk.MenuItem item_help = new Gtk.MenuItem.with_label("Help");
                Gtk.Menu helpmenu = new Gtk.Menu();
                Gtk.MenuItem sub_item_about = new Gtk.MenuItem.with_label("About");
                Gtk.MenuItem sub_item_help = new Gtk.MenuItem.with_label("Help");

                helpmenu.add(sub_item_about);
                helpmenu.add(sub_item_help);
                item_help.set_submenu(helpmenu);

                sub_item_help.activate.connect(() => {
                        help_selected();
                });

                sub_item_about.activate.connect(() => {
                        about_selected();
                });

                menubar.add(item_file);
                menubar.add(item_help);

                grid.attach(menubar, 0, 0, 1, 1);

                // Add the notebook that will eventually hold everything else
                Gtk.Notebook notebook = new Gtk.Notebook();

                // Create the drag page of the notebook
                Gtk.Label pg1_title = new Gtk.Label("Drag");
                drag_builder = Balistica.create_builder("drag.glade");
                drag_builder.connect_signals(null);
                var drag_content = drag_builder.get_object("drag_main") as Gtk.Box;
                notebook.append_page(drag_content, pg1_title);
                
                // Create the twist page of the notebook
                Gtk.Label pg2_title = new Gtk.Label("Twist");
                twist_builder = Balistica.create_builder("twist.glade");
                twist_builder.connect_signals(null);
                var twist_content = twist_builder.get_object("twist_main") as Gtk.Box;
                notebook.append_page(twist_content, pg2_title);
    
                // Attach the grid (with the notebook) the main window and roll
                grid.attach(notebook, 0, 1, 1, 1);
                main_window.add(grid); 
                main_window.show_all();
                this.add_window(main_window);
                connect_entries();
            }
        }
        
        /**
         * Connect the GUI elements to our code so we can play with them
         */
        public void connect_entries() {
            // Stored calculation's name
            calc_name = drag_builder.get_object("txtName") as Gtk.Entry;
            
            // Basic inputs
            drag_coefficient = drag_builder.get_object("txtDrag_coefficient") as Gtk.Entry;
            projectile_weight = drag_builder.get_object("txtProjectile_weight") as Gtk.Entry;
            initial_velocity = drag_builder.get_object("txtIntial_velocity") as Gtk.Entry;
            zero_range = drag_builder.get_object("txtZero_range") as Gtk.Entry;
            sight_height = drag_builder.get_object("txtSight_height") as Gtk.Entry;
            shooting_angle = drag_builder.get_object("txtShooting_angle") as Gtk.Entry;
            wind_velocity = drag_builder.get_object("txtWind_velocity") as Gtk.Entry;
            wind_angle = drag_builder.get_object("txtWind_angle") as Gtk.Entry;
            
            // Variables Suitable for debugging
            calc_name.set_text("308 Win Match, 168gr Sierra Match King");
            drag_coefficient.set_text("0.465");
            projectile_weight.set_text("168");
            initial_velocity.set_text("2650");
            zero_range.set_text("200");
            sight_height.set_text("1.6");
            shooting_angle.set_text("0");
            wind_velocity.set_text("0");
            wind_angle.set_text("0");
            
            // Checkbox to dis/en/able atmospheric corrections
            enable_atmosphere = drag_builder.get_object("ckbAtmosCorr") as Gtk.CheckButton;
            enable_atmosphere.toggled.connect (() => {
                    if (enable_atmosphere.active) {
                        // checked
                        altitude.set_sensitive(true);
                        temp.set_sensitive(true);
                        bar_press.set_sensitive(true);
                        rela_humid.set_sensitive(true);
                    } else {
                        // not checked
                        altitude.set_sensitive(false);
                        temp.set_sensitive(false);
                        bar_press.set_sensitive(false);
                        rela_humid.set_sensitive(false);
                    }
            });
            
            // Atmospheric corrections
            altitude = drag_builder.get_object("txtAltitude") as Gtk.Entry;
            temp = drag_builder.get_object("txtTemp") as Gtk.Entry;
            bar_press = drag_builder.get_object("txtBarPress") as Gtk.Entry;
            rela_humid = drag_builder.get_object("txtRelaHumid") as Gtk.Entry;
            
            // Set default values
            altitude.set_text("0");
            temp.set_text("59.0");
            bar_press.set_text("29.53");
            rela_humid.set_text("78.0");
            
            // Drag Calculations Results
            drag_results = drag_builder.get_object("txtViewDragResults") as Gtk.TextView;
            
            // Radio buttons for drag functions
            rad_g1 = drag_builder.get_object("radG1") as Gtk.RadioButton;
            rad_g2 = drag_builder.get_object("radG2") as Gtk.RadioButton;
            rad_g5 = drag_builder.get_object("radG5") as Gtk.RadioButton;
            rad_g6 = drag_builder.get_object("radG6") as Gtk.RadioButton;
            rad_g7 = drag_builder.get_object("radG7") as Gtk.RadioButton;
            rad_g8 = drag_builder.get_object("radG8") as Gtk.RadioButton;
            
            // Set G1 as selected by default
            rad_g1.active = true;
            
            // Buttons
            solve_drag = drag_builder.get_object("btnSolveDrag") as Gtk.Button;
            solve_drag.clicked.connect(()=> {
                    btnSolveDrag_clicked();
            });
            
            reset_drag = drag_builder.get_object("btnResetDrag") as Gtk.Button;
            reset_drag.clicked.connect(()=> {
                    btnResetDrag_clicked();
            });
            
            disp_solution = drag_builder.get_object("btnSolution") as Gtk.Button;
            disp_solution.clicked.connect(()=> {
                    btnSolution_clicked();
            });
            
            disp_pbr = drag_builder.get_object("btnPBR") as Gtk.Button;
            disp_pbr.clicked.connect(()=> {
                    btnPBR_clicked();
            });
        }
        
        /**
         * Reset the front end to prepare for a new calculation
         */
        public void btnResetDrag_clicked() {
            calc_name.set_text("");
            
            drag_coefficient.set_text("");
            projectile_weight.set_text("");
            initial_velocity.set_text("");
            zero_range.set_text("");
            sight_height.set_text("");
            shooting_angle.set_text("");
            wind_velocity.set_text("");
            wind_angle.set_text("");
            
            altitude.set_text("0");
            temp.set_text("59.0");
            bar_press.set_text("29.53");
            rela_humid.set_text("78.0");
            enable_atmosphere.set_active(false);
            
            drag_results.buffer.text = "";
            
            rad_g1.active = true;
        }
        
        /**
         * Solve the drag function
         */
        public void btnSolveDrag_clicked() {
            string name = "";	// Name used to store the calculation
            double bc = -1;         // Ballistic cefficient
            double v = -1;          // Initial velocity (ft/s)
            double sh = -1;         // Sight height over bore (inches)
            double w = -1;		// Projectile weight (grains)
            double angle = -1;      // Shooting Angle (degrees)
            double zero = -1;       // Zero range of the rifle (yards)
            double windspeed = -1;  // Wind speed (mph)
            double windangle = -1;  // Wind angle (0=headwind, 90=right to left, 180=tailwind, 270/-90=left to right)
            
            double alt = 0.0;       // Altitude
            double bar = 29.53;     // Barometeric pressure
            double tp = 59.0;       // Temperature
            double rh = 78.0;       // Relative Humidity
            
            int df;                 // Selected Drag Function
            
            name = calc_name.get_text();
            bc = double.parse(drag_coefficient.get_text());
            v = double.parse(initial_velocity.get_text());
            sh = double.parse(sight_height.get_text());
            w = double.parse(projectile_weight.get_text());
            angle = double.parse(wind_angle.get_text());
            zero = double.parse(zero_range.get_text());
            windspeed = double.parse(wind_velocity.get_text());
            windangle = double.parse(wind_angle.get_text());
            
            // It doesn't make sense for any of the following variables
            // to be zero
            if (bc == 0 || v == 0 || sh == 0 || w == 0 || zero == 0) {
                var drag_builder = new StringBuilder ();
                drag_builder.append("The following fields must be positive values greater than 0!\n");
                drag_builder.append("\n\tDrag Coefficient");
                drag_builder.append("\n\tProjectile Weight");
                drag_builder.append("\n\tInitial Velocity");
                drag_builder.append("\n\tZero Range");
                drag_builder.append("\n\tSight Height Over Bore\n");
                
                Gtk.Dialog dialog = new Gtk.Dialog.with_buttons("Error", null,
                        Gtk.DialogFlags.DESTROY_WITH_PARENT, "OK", Gtk.ResponseType.CLOSE, null);
                dialog.response.connect(() => { dialog.destroy(); });
                dialog.get_content_area().add(new Gtk.Label(drag_builder.str));
                dialog.set_transient_for(main_window);
                dialog.show_all();
                dialog.run();
                
                return;
            }
            
            if (enable_atmosphere.active) {
                alt = double.parse(altitude.get_text());
                bar = double.parse(bar_press.get_text());
                tp = double.parse(temp.get_text());
                rh = double.parse(rela_humid.get_text());
            }
            
            // Which version of the drag do they want to calculate?
            if (rad_g1.get_active()) {
                df = 1;
            } else if(rad_g2.get_active()) {
                df = 2;
            } else if(rad_g5.get_active()) {
                df = 5;
            } else if(rad_g6.get_active()) {
                df = 6;
            } else if(rad_g7.get_active()) {
                df = 7;
            } else {
                df = 8;
            }
            
            // Create a new solution object
            LibBalistica.Solution lsln = new LibBalistica.Solution();
            
            // Calculate the solution and populate the object
            lsln = Calculate.drag(bc, v, sh, w, angle, zero, windspeed, windangle, alt, bar, tp, rh, name, df);
            
            if (lsln.getRows() == -1) {
                drag_results.buffer.text = "ERROR creating solution results!";
            } else {
                drag_results.buffer.text = "Solution generated!";
            }
        }

        /**
         * Display the calculated solution
         */
        public void btnSolution_clicked() {
            //TODO
        }
        
        /**
         * Display the calculated PBR
         */
        public void btnPBR_clicked() {
            //TODO
        }
        
        /**
         * Quit application
         */
        public void quit_selected() {
            main_window.destroy();
        }
        
        /**
         * Show help browser
         */
        public void help_selected() {
            try {
                Gtk.show_uri(main_window.get_screen(), "ghelp:balistica", Gtk.get_current_event_time());
            } catch (Error err) {
                Gtk.Dialog dialog = new Gtk.Dialog.with_buttons("Error", null,
                        Gtk.DialogFlags.DESTROY_WITH_PARENT, "ERROR: ", Gtk.ResponseType.CLOSE, null);
                dialog.response.connect(() => { dialog.destroy(); });
                dialog.get_content_area().add(new Gtk.Label("Error showing help: %s".printf(err.message)));
                dialog.show_all();
                dialog.run();
            }
        }
                
        /**
         * Show about dialog
         */
        public void about_selected() {
            string version;
            if (Balistica.VERSION_DESC == "Release") {
                version = Balistica.VERSION_MAJOR + "." + Balistica.VERSION_MINOR + "." + Balistica.VERSION_REVISION;
            } else {
                version = Balistica.VERSION_MAJOR + "." + Balistica.VERSION_MINOR + "." + Balistica.VERSION_REVISION + "-" + Balistica.VERSION_COMMIT;
            }


            
            Gtk.show_about_dialog (main_window,
                    "authors", Balistica.AUTHORS,
                    "comments", "An open source external ballistics calculator.",
                    "copyright", Balistica.COPYRIGHT,
                    "license-type", Gtk.License.GPL_3_0,
                    "program-name", Balistica.NAME,
                    "website", Balistica.WEBSITE,
                    "website-label", "balística Website",
                    "version", version);
        }
    }
} // namespace
