/* Copyright 2012, 2013 Steven Oliver <oliver.steven@gmail.com>
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

using Gtk;

public static int main (string[] args) {
        try {
                var gtk_builder = new Builder();
                gtk_builder.add_from_file("ui/main.glade");
                var window = gtk_builder.get_object("window") as Window;
                window.show_all();
                Gtk.main();
        } catch (Error e) {
                stderr.printf("Could not load UI: %s\n", e.message);
                return 1;
        }

        return 0;
}
