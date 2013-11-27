/* Copyright 2013 Steven Oliver <oliver.steven@gmail.com>
 *
 * This file is part of balistica.
 *
 * balistica is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * balistica is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with balistica.  If not, see <http://www.gnu.org/licenses/>.
 */

using GLib;
using Gtk;

// Defined by cmake build script.
extern const string _VERSION;
extern const string _GSETTINGS_DIR;

namespace Balistica {

        /**
         * These are publicly shared variables that will
         * be available throughout the base of the application
         */
        public const string NAME = "balística";
        public const string COPYRIGHT = "Copyright 2012-2013 Steven Oliver";
        public const string WEBSITE = "http://steveno.github.com/balistica/";

        public const string DESKTOP_NAME = "balística";
        public const string DESKTOP_GENERIC_NAME = "Ballistics Calculator";
        public const string DESKTOP_KEYWORDS = "ballistics;calculator;";

        public const string VERSION = _VERSION;
        public const string GSETTINGS_DIR = _GSETTINGS_DIR;

        // Global help strings
        public const string SHORT_COPYRIGHT = "Copyright (C) 2012-2013 Steven Oliver";

        public const string SHORT_LICENSE = "This is free software; see the source for copying conditions. There is NO"
                + "\nwarranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.";

        public const string LICENSE = """
                This program is free software: you can redistribute it and/or modify
                it under the terms of the GNU General Public License as published by
                the Free Software Foundation, either version 3 of the License, or
                (at your option) any later version.

                This program is distributed in the hope that it will be useful,
                but WITHOUT ANY WARRANTY; without even the implied warranty of
                MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                GNU General Public License for more details.
                
                You should have received a copy of the GNU General Public License
                along with this program.  If not, see <http://www.gnu.org/licenses/>.
                """;

        public const string[] AUTHORS = {
                "Steven Oliver <oliver.steven@gmail.com>",
                null
        };

        public class MainWindow : Gtk.ApplicationWindow {
                private Gtk.Builder builder;
                private Gtk.Window window;

                // Entry fields
                private Gtk.Entry calc_name;
                private Gtk.Entry drag_coefficient;
                private Gtk.Entry projectile_weight;
                private Gtk.Entry initial_velocity;
                private Gtk.Entry zero_range;
                private Gtk.Entry sight_height;
                private Gtk.Entry shooting_angle;
                private Gtk.Entry wind_velocity;
                private Gtk.Entry altitude;
                private Gtk.Entry temp;
                private Gtk.Entry bar_press;
                private Gtk.Entry rela_humid;

                // Buttons
                private Gtk.Button reset;
                private Gtk.Button solve;

                public MainWindow(Gtk.Application application) {
                        GLib.Object(application: application);

                        builder = Balistica.create_builder("main.glade");
                        builder.connect_signals(null);

                        window = builder.get_object("balistica") as Gtk.Window;
                        connect_entries();

                        window.show_all();
                        Gtk.main();
                }

                private void connect_entries() {
                        // Stored calculation's name
                        calc_name = builder.get_object("txtName") as Gtk.Entry;

                        // Basic inputs
                        drag_coefficient = builder.get_object("txtDrag_coefficient") as Gtk.Entry;
                        projectile_weight = builder.get_object("txtProjectile_weight") as Gtk.Entry;
                        initial_velocity = builder.get_object("txtIntial_velocity") as Gtk.Entry;
                        zero_range = builder.get_object("txtZero_velocity") as Gtk.Entry;
                        sight_height = builder.get_object("txtSight_height") as Gtk.Entry;
                        shooting_angle = builder.get_object("txtShooting_anlge") as Gtk.Entry;
                        wind_velocity = builder.get_object("txtWind_velocity") as Gtk.Entry;

                        // atmospheric corrections
                        altitude = builder.get_object("txtAltitude") as Gtk.Entry;
                        temp = builder.get_object("txtTemp") as Gtk.Entry;
                        bar_press = builder.get_object("txtBarPress") as Gtk.Entry;
                        rela_humid = builder.get_object("txtRelaHumid") as Gtk.Entry;

                        // Buttons
                        solve = builder.get_object("btnSolve") as Gtk.Button;
                        solve.clicked.connect(()=> {
                                btnSolve_clicked();
                        });

                        reset = builder.get_object("btnReset") as Gtk.Button;
                        reset.clicked.connect(()=> {
                                btnReset_clicked();
                        });
                }

                public void btnReset_clicked() {
                        calc_name.set_text("");
                        drag_coefficient.set_text("");
                        projectile_weight.set_text("");
                        initial_velocity.set_text("");
                        zero_range.set_text("");
                        sight_height.set_text("");
                        shooting_angle.set_text("");
                        wind_velocity.set_text("");
                        altitude.set_text("");
                        temp.set_text("");
                        bar_press.set_text("");
                        rela_humid.set_text("");
               }

                public void btnSolve_clicked() {
                }

                public void quit_selected() {
                        window.destroy();
                }

                public void about_selected() {
                }
        }
} //namespace

