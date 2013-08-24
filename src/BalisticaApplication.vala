/* Copyright 2012, 2013 Steven Oliver <oliver.steven@gmail.com> 
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

// Defined by the build script.
extern const string _VERSION;
extern const string _INSTALL_PREFIX;
extern const string _GSETTINGS_DIR;
extern const string _SOURCE_ROOT_DIR;

public class BalisticaApplication : GLib.Object {
        public const string NAME = "Balistica";
        public const string COPYRIGHT = _("Copyright 2012-2013 Steven Oliver");
        public const string WEBSITE = "http://steveno.github.com/balistica/";

        public const string DESKTOP_NAME = _("balisitica");
        public const string DESKTOP_GENERIC_NAME = _("Ballistics Calculator");
        public const string DESKTOP_KEYWORDS = _("ballistics;calculator;");

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
}

