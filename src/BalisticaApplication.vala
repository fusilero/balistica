/* Copyright 2012-2014 Steven Oliver <oliver.steven@gmail.com>
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
        public const string COPYRIGHT = "Copyright © 2012-2014 Steven Oliver";
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
                // App level help strings
                private const string USAGE = "Usage:\n  balistica [version] [-g|--greenhill] [-m|--miller]"
                        + " [help] <command> [<args>]";

                private const string APPLICATION_OPTIONS = "Application Options:"
                        + "\n  miller-twist\t\tCalculate twist using the Miller twist rule"
                        + "\n  miller-stability\tCalculate stability using the Miller twist rule"
                        + "\n  greenhill\t\tCalculate twist using the Greenhill formula";

                // Specific help strings
                private const string SPECIFIC_CMD = "See balistica help <command> for more information on a specific formula";

                private const string MILLER_TWIST_HELP = "\nThe Miller Twist Rule can be used to calculate the twist rate"
                        + "\nof a specific round."
                        + "\n\n The variables used to calculate twist rate: "
                        + "\n   --diameter   - the diameter of the bullet"
                        + "\n   --length     - the length of the bullet"
                        + "\n   --mass       - the mass of the bullet in grams"
                        + "\n   --safe-value - Miller generally assumes a 'safe value'"
                        + "\n                  of 2. This parameter is optional.";

                private const string MILLER_STABILITY_HELP = "\nThe Miller Twist Rule can also be used to calculate the"
                        + "\nstability factor of a specific round."
                        + "\n\n The variables used to calculate the stability factor: "
                        + "\n   --diameter - the diameter of the bullet"
                        + "\n   --length   - the length of the bullet"
                        + "\n   --mass     - the mass of the bullet in grams"
                        + "\n   --twist    - the known twist rate\n";

                private const string GREENHILL_HELP = "\nThe Greenhill formula can only be used to calculate the twist"
                        + "\nrate of a round."
                        + "\n\n The variables used to calculate the twist rate:"
                        + "\n   --C                - a constant that should be set 150 for slow rounds "
                        + "\n                        or 180 for faster rounds (above 840 m/s)"
                        + "\n   --diameter         - the diameter of the bullet"
                        + "\n   --length           - the length of the bullet"
                        + "\n   --specific-gravity - the specific gravity of the bullet\n";

                private GLib.Settings settings;
                private Gtk.Builder builder;

                public static Gtk.Window main_window;

                public static bool miller_twist = false;
                public static bool miller_stability = false;
                public static bool greenhill = false;
                public static bool help = false;
                public static bool version = false;

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

                // Radio buttons for drag functions
                private Gtk.RadioButton rad_g1;
                private Gtk.RadioButton rad_g2;
                private Gtk.RadioButton rad_g5;
                private Gtk.RadioButton rad_g6;
                private Gtk.RadioButton rad_g7;
                private Gtk.RadioButton rad_g8;

                // Global menu bar
                private Gtk.MenuItem on_about;
                private Gtk.MenuItem on_quit;
                private Gtk.MenuItem on_help;

                public const OptionEntry[] options = {
                        { "miller-twist", 0, 0, OptionArg.NONE, ref miller_twist, "Calculate twist using the Miller twist rule" },
                        { "miller-stability", 0, 0, OptionArg.NONE, ref miller_stability, "Calculate stability using the Miller twist rule" },
                        { "greenhill", 0, 0, OptionArg.NONE, ref greenhill, "Calculate twist using the Greenhill formula" },
                        { "help", 'h', 0, OptionArg.NONE, ref help, "Show this Help message" },
                        { "version", 'v', 0, OptionArg.NONE, ref version, "Show balística verion" },
                        { null }
                };

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

                                builder = Balistica.create_builder("main.glade");
                                builder.connect_signals(null);
                                main_window = builder.get_object("balistica") as Gtk.Window;

                                main_window.show();
                                this.add_window(main_window);

                                connect_entries();
                        }
                }

                /**
                 * Overridden method of GApplication, to handle the arguments locally.
                 *
                 * Copied from cheese: https://git.gnome.org/browse/cheese/
                 *
                 * @param arguments the command-line arguments
                 * @param exit_status the exit status to return to the OS
                 *
                 * @return true if the arguments were successfully processed, false
                 * otherwise
                 */
                protected override bool local_command_line ([CCode (array_null_terminated = true, array_length = false)]
                                ref unowned string[] argv,
                                out int exit_status)
                {
                        // Try to register.
                        try {
                                register ();
                        }
                        catch (Error e) {
                                warning ("Unable to register application: %s", e.message);
                                exit_status = 1;
                                return true;
                        }

                        // Workaround until bug 642885 is solved.
                        unowned string[] arguments = argv;
                        var n_args = arguments.length;

                        if (n_args <= 1) {
                                activate();
                                exit_status = 0;
                        } else {
                                try {
                                        var context = new OptionContext ("- A simple open source balistics calculator");
                                        context.set_help_enabled (false);
                                        context.add_main_entries (options, null);
                                        context.parse (ref arguments);
                                } catch (OptionError e) {
                                        warning ("%s", e.message);
                                        stdout.printf ("Run '%s --help' to see a full list of available command line options.", arguments[0]);
                                        stdout.printf ("\n");
                                        exit_status = 1;
                                        return true;
                                }

                                // They've passed the version option, Tell them the version and exit.
                                if (version) {
                                        if (Balistica.VERSION_DESC == "Release") {
                                                stdout.printf("%s %s\n", Balistica.NAME, Balistica.VERSION_MAJOR + "." + Balistica.VERSION_MINOR + "." + Balistica.VERSION_REVISION);
                                        } else {
                                                stdout.printf("%s %s\n", Balistica.NAME, Balistica.VERSION_MAJOR + "." + Balistica.VERSION_MINOR + "." + Balistica.VERSION_REVISION + "." + Balistica.VERSION_COMMIT);
                                        }

                                        exit_status = 1;
                                        return true;
                                }

                                // They asked for help, first we have to deciede if they want the
                                // generic help or help for a specific command
                                if (help) {
                                        // They've picked a specific command
                                        if (arguments[1] == "miller-twist") {
                                                stdout.printf("%s\n", MILLER_TWIST_HELP);
                                                exit_status = 1;
                                                return true;
                                        } else if (arguments[2] == "miller-stability") {
                                                stdout.printf("%s\n", MILLER_STABILITY_HELP);
                                                exit_status = 1;
                                                return true;
                                        } else if (arguments[2] == "greenhill") {
                                                stdout.printf("%s\n", GREENHILL_HELP);
                                                exit_status = 1;
                                                return true;
                                                // Nope they just want generic help
                                        } else {
                                                stdout.printf("%s\n\n", USAGE);
                                                stdout.printf("%s\n\n", APPLICATION_OPTIONS);
                                                stdout.printf("%s\n", SPECIFIC_CMD);
                                                exit_status = 1;
                                                return true;
                                        }
                                }

                                // Calculate the miller twist
                                if (miller_twist) {
                                        Calculate.miller_twist(arguments);
                                        exit_status = 1;
                                        return true;
                                }

                                // Calculate the miller stability
                                if (miller_stability) {
                                        Calculate.miller_stability(arguments);
                                        exit_status = 1;
                                        return true;

                                }

                                // Calculate the twist using Greenhill
                                if (greenhill) {
                                        Calculate.greenhill(arguments);
                                        exit_status = 1;
                                        return true;
                                }

                                activate();
                                exit_status = 0;
                        }

                        return base.local_command_line (ref arguments, out exit_status);
                }

                /**
                 * Connect the GUI elements to our code so we can play with them
                 */
                public void connect_entries() {
                        // Stored calculation's name
                        calc_name = builder.get_object("txtName") as Gtk.Entry;

                        // Basic inputs
                        drag_coefficient = builder.get_object("txtDrag_coefficient") as Gtk.Entry;
                        projectile_weight = builder.get_object("txtProjectile_weight") as Gtk.Entry;
                        initial_velocity = builder.get_object("txtIntial_velocity") as Gtk.Entry;
                        zero_range = builder.get_object("txtZero_range") as Gtk.Entry;
                        sight_height = builder.get_object("txtSight_height") as Gtk.Entry;
                        shooting_angle = builder.get_object("txtShooting_angle") as Gtk.Entry;
                        wind_velocity = builder.get_object("txtWind_velocity") as Gtk.Entry;
                        wind_angle = builder.get_object("txtWind_angle") as Gtk.Entry;

                        // Checkbox to dis/en/able atmospheric corrections
                        enable_atmosphere = builder.get_object("ckbAtmosCorr") as Gtk.CheckButton;
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
                        altitude = builder.get_object("txtAltitude") as Gtk.Entry;
                        temp = builder.get_object("txtTemp") as Gtk.Entry;
                        bar_press = builder.get_object("txtBarPress") as Gtk.Entry;
                        rela_humid = builder.get_object("txtRelaHumid") as Gtk.Entry;

                        // Set default values
                        altitude.set_text("0");
                        temp.set_text("59");
                        bar_press.set_text("29.53");
                        rela_humid.set_text("78");

                        // Drag Calculations Results
                        drag_results = builder.get_object("txtviewDragResults") as Gtk.TextView;

                        // Radio buttons for drag functions
                        rad_g1 = builder.get_object("radG1") as Gtk.RadioButton;
                        rad_g2 = builder.get_object("radG2") as Gtk.RadioButton;
                        rad_g5 = builder.get_object("radG5") as Gtk.RadioButton;
                        rad_g6 = builder.get_object("radG6") as Gtk.RadioButton;
                        rad_g7 = builder.get_object("radG7") as Gtk.RadioButton;
                        rad_g8 = builder.get_object("radG8") as Gtk.RadioButton;

                        // Buttons
                        solve_drag = builder.get_object("btnSolveDrag") as Gtk.Button;
                        solve_drag.clicked.connect(()=> {
                                        btnSolveDrag_clicked();
                                        });

                        reset_drag = builder.get_object("btnResetDrag") as Gtk.Button;
                        reset_drag.clicked.connect(()=> {
                                        btnResetDrag_clicked();
                                        });

                        // Menubar
                        on_about = builder.get_object("on_about") as Gtk.MenuItem;
                        on_about.activate.connect(() => {
                                        about_selected();
                                        });

                        on_quit = builder.get_object("on_quit") as Gtk.MenuItem;
                        on_quit.activate.connect(() => {
                                        quit_selected();
                                        });

                        on_help = builder.get_object("on_help") as Gtk.MenuItem;
                        on_help.activate.connect(() => {
                                        help_selected();
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
                        // Atmospheric corrections
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

                        Calculate.drag(bc, v, sh, w, angle, zero, windspeed, windangle, alt, bar, tp, rh, name, df);
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
                                version = Balistica.VERSION_MAJOR + "." + Balistica.VERSION_MINOR + "." + Balistica.VERSION_REVISION + "." + Balistica.VERSION_COMMIT;
                        }

                        Gtk.show_about_dialog (main_window,
                                        "authors", Balistica.AUTHORS,
                                        "comments", "An open source external balistics calculator.",
                                        "copyright", Balistica.COPYRIGHT,
                                        "license-type", Gtk.License.GPL_3_0,
                                        "program-name", Balistica.NAME,
                                        "website", Balistica.WEBSITE,
                                        "website-label", "balística Website",
                                        "version", version);
                }
        }
} // namespace
