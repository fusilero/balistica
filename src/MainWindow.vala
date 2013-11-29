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

namespace Balistica {

        public class MainWindow : Gtk.ApplicationWindow {
                private Gtk.Builder builder;
                private Gtk.Window window;

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

                // Drag calculation Buttons
                private Gtk.Button reset_drag;
                private Gtk.Button solve_drag;

                public MainWindow(Gtk.Application application) {
                        GLib.Object(application: application);

                        builder = Balistica.create_builder("main.glade");
                        builder.connect_signals(null);

                        window = builder.get_object("balistica") as Gtk.Window;
                        window.destroy.connect(Gtk.main_quit);
                        connect_entries();

                        this.window.show_all();
                        Gtk.main();
                }

                /**
                 * Connect the GUI elements to our code so we can play with them
                 */
                private void connect_entries() {
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

                        // Atmospheric corrections
                        altitude = builder.get_object("txtAltitude") as Gtk.Entry;
                        temp = builder.get_object("txtTemp") as Gtk.Entry;
                        bar_press = builder.get_object("txtBarPress") as Gtk.Entry;
                        rela_humid = builder.get_object("txtRelaHumid") as Gtk.Entry;

                        // Buttons
                        solve_drag = builder.get_object("btnSolveDrag") as Gtk.Button;
                        solve_drag.clicked.connect(()=> {
                                btnSolveDrag_clicked();
                        });

                        reset_drag = builder.get_object("btnResetDrag") as Gtk.Button;
                        reset_drag.clicked.connect(()=> {
                                btnResetDrag_clicked();
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
                        altitude.set_text("");
                        temp.set_text("");
                        bar_press.set_text("");
                        rela_humid.set_text("");
               }

                public void btnSolveDrag_clicked() {
                        //TODO
                }

                public void quit_selected() {
                        window.destroy();
                }

                /**
                 * Show about dialog
                 */
                public void about_selected() {
                        Gtk.show_about_dialog (window,
                                "authors", Balistica.AUTHORS,
                                "comments", "A simple open source external balistics calculator.",
                                "copyright", Balistica.COPYRIGHT,
                                "license-type", Gtk.License.GPL_3_0,
                                "program-name", Balistica.NAME,
                                "website", Balistica.WEBSITE,
                                "website-label", "balística Website",
                                "version", Balistica.VERSION);
                }
        }
} //namespace

