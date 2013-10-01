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

using GLib;
using Gtk;

// Defined by cmake build script.
extern const string _VERSION;
extern const string _GSETTINGS_DIR;

public class BalisticaApplication : Gtk.Application {
        /**
         * These are publicly shared variables that will
         * be available throughout the base of the application
         */
        public const string NAME = "Balística";
        public const string PRGNAME = "balística";
        public const string COPYRIGHT = "Copyright 2012-2013 Steven Oliver";
        public const string WEBSITE = "http://steveno.github.com/balistica/";

        public const string DESKTOP_NAME = "balística";
        public const string DESKTOP_GENERIC_NAME = "Ballistics Calculator";
        public const string DESKTOP_KEYWORDS = "ballistics;calculator;";

        public const string VERSION = _VERSION;
        public const string INSTALL_PREFIX = _INSTALL_PREFIX;
        public const string GSETTINGS_DIR = _GSETTINGS_DIR;
        public const string SOURCE_ROOT_DIR = _SOURCE_ROOT_DIR;

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

        /*
         * Startup the program
         */

        private GLib.Settings settings;

        public BalisticaApplication() {
                GLib.Object(application_id: "org.gnome.balistica");
        }

        protected override void startup() {
                settings = new GLib.Settings("org.gnome.balistica");

                base.startup();
        }

} //namespace

