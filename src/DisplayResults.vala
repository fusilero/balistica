/* Copyright 2014 Steven Oliver <oliver.steven@gmail.com>
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
using Webkit;

public class Balistica.DisplayResults : Window {
        private const string TITLE = "Vala Browser";
        private const string HOME_URL = "http://acid3.acidtests.org/";
        private const string DEFAULT_PROTOCOL = "http";

        private Regex protocol_regex;

        private WebKit.WebView web_view;
        private Label status_bar;

        public DisplayResults() {
                this.title = TITLE;
                set_default_size (800, 600);

                try {
                        this.protocol_regex = new Regex (".*://.*");
                } catch (RegexError e) {
                        critical ("%s", e.message);
                }

                create_widgets ();
                connect_signals ();
                this.url_bar.grab_focus ();
        }

        private void create_widgets () {
                this.web_view = new WebView ();
                var scrolled_window = new ScrolledWindow (null, null);
                scrolled_window.set_policy (PolicyType.AUTOMATIC, PolicyType.AUTOMATIC);
                scrolled_window.add (this.web_view);
                this.status_bar = new Label ("Welcome");
                this.status_bar.xalign = 0;
                var vbox = new VBox (false, 0);
                vbox.add (scrolled_window);
                vbox.pack_start (this.status_bar, false, true, 0);
                add (vbox);
        }

        private void connect_signals () {
                this.url_bar.activate.connect (on_activate);
                this.web_view.title_changed.connect ((source, frame, title) => {
                                this.title = "%s - %s".printf (title, TITLE);
                                });
                this.web_view.load_committed.connect ((source, frame) => {
                                this.url_bar.text = frame.get_uri ();
                                update_buttons ();
                                });
        }

        private void on_activate () {
                this.web_view.open (url);
        }

        public void start () {
                show_all ();
                this.web_view.open (HOME_URL);
        }

        public static void display_pbr() {

        }

        public static void display_solution() {
                // Print some general information about the load.
               /* sprintf(str,"@b%s",Sln->Name()); tbl->add(str);
                sprintf(str,"Drag Coefficient: %.3f   Projectile Weight: %d grains",Sln->BC(), Sln->Weight()); tbl->add(str);
                sprintf(str,"Initial Velocity: %d (ft/s)   Zero Range: %d yards   Shooting Angle: %d degrees",Sln->MuzzleVelocity(), Sln->ZeroRange(), Sln->ShootingAngle()); tbl->add(str);
                sprintf(str,"Wind Velocity:  %d mph    Wind Direction: %d degrees",Sln->WindSpeed(), Sln->WindAngle()); tbl->add(str);
                sprintf(str,"Altitude: %d feet   Barometer: %.2f in-Hg  Temperature: %d F   Relative Humidity: %d%%",Sln->Altitude(), Sln->Pressure(), Sln->Temp(), Sln->Humidity()); tbl->add(str);

                tbl->add("");

                tbl->add("@b@cRange\t@b@cDrop\t@b@cDrop\t@b@cVelocity\t@b@cEnergy\t@b@cWind Drift\t@b@cWindage\t@b@cTime",0);
                tbl->add("@c(yards)\t@c(inches)\t@c(MOA)\t@c(ft/s)\t@c(ft-lb)\t@c(inches)\t@c(MOA)\t@c(s)",0);

                for (int n=MIN;n<=MAX;n=n+STEP){
                        r=Sln->GetRange(n);
                        p=Sln->GetPath(n);
                        m=Sln->GetMOA(n);
                        v=Sln->GetVelocity(n);
                        wi=Sln->GetWindage(n);
                        wm=Sln->GetWindageMOA(n);
                        t=Sln->GetTime(n);
                        e=Sln->Weight()*v*v/450436;

                        sprintf(str,"@c%.0f\t@c%.2f\t@c%.2f\t@c%.0f\t@c%.0f\t@c%.2f\t@c%.2f\t@c%.2f",r,p,m,v,e,wi,wm,t);
                        tbl->add(str,0);
                }
                */
        }
}
