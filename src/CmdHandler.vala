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

namespace Balistica {

        private const OptionEntry[] options = {
                { "miller-twist", 0, 0, OptionArg.NONE, ref miller_twist, "Calculate twist using the Miller twist rule" },
                { "miller-stability", 0, 0, OptionArg.NONE, ref miller_stability, "Calculate stability using the Miller twist rule" },
                { "greenhill", 0, 0, OptionArg.NONE, ref greenhill, "Calculate twist using the Greenhill formula" },
                { "help", 'h', 0, OptionArg.NONE, ref help, "Show this Help message" },
                { "version", 'v', 0, OptionArg.NONE, ref version, "Show balística verion" },
                { null }
        };

        public bool miller_twist = false;
        public bool miller_stability = false;
        public bool greenhill = false;
        public bool help = false;
        public bool version = false;

        public class CmdHandler : Gtk.Application {
                // Global help strings
                private const string USAGE = "Usage:\n  balistica [version] [-g|--greenhill] [-m|--miller]"
                        + " [help] <command> [<args>]";

                private const string APPLICATION_OPTIONS = "Application Options:"
                        + "\n  miller-twist\t\tCalculate twist using the Miller twist rule"
                        + "\n  miller-stability\tCalculate stability using the Miller twist rule"
                        + "\n  greenhill\t\tCalculate twist using the Greenhill formula";

                // Specific help
                private const string SPECIFIC_CMD = "See balística help <command> for more information on a specific formula";

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

                /**
                 * Parse arguments
                 */
                public static int parse_args(string[] args) {
                        var context = new OptionContext("");
                        context.set_help_enabled(false);
                        context.add_main_entries(options, null);

                        try {
                                context.parse(ref args);
                        } catch (OptionError error) {
                                stdout.printf("Failed to parse command line options \"%s\"\n", error.message);
                                return 1;
                        }

                        if (version) {
                                stdout.printf("%s %s\n", "Balística", BalisticaApplication.VERSION);
                                return 1;
                        }

                        if (help) {
                                if (args[1] == "miller-twist") {
                                        stdout.printf("%s\n", MILLER_TWIST_HELP);
                                        return 0;
                                } else if (args[2] == "miller-stability") {
                                        stdout.printf("%s\n", MILLER_STABILITY_HELP);
                                        return 0;
                                } else if (args[2] == "greenhill") {
                                        stdout.printf("%s\n", GREENHILL_HELP);
                                        return 0;
                                } else {
                                        stdout.printf("%s\n\n", USAGE);
                                        stdout.printf("%s\n\n", APPLICATION_OPTIONS);
                                        stdout.printf("%s\n", SPECIFIC_CMD);
                                        return 0;
                                }
                        }

                        if (miller_twist) {
                                Calculate.miller_twist(args);
                        }

                        if (miller_stability) {
                                Calculate.miller_stability(args);
                        }

                        if (greenhill) {
                                Calculate.greenhill(args);
                        }

                        return 0;
                }

                /**
                 * Overridden method of GApplication, to handle the arguments locally.
                 *
                 * Copied from cheese: https://git.gnome.org/browse/cheese/
                 *
                 * @param arguments the command-line arguments
                 * @param exit_status the exit status to return to the OS
                 * @return true if the arguments were successfully processed, false
                 * otherwise
                 */
                protected override bool local_command_line ([CCode (array_null_terminated = true, array_length = false)]
                                ref unowned string[] argv,
                                out int exit_status)
                {
                        // Try to register.
                        try
                        {
                                register ();
                        }
                        catch (Error e)
                        {
                                warning ("Unable to register application: %s", e.message);
                                exit_status = 1;
                                return true;
                        }

                        // Workaround until bug 642885 is solved.
                        unowned string[] arguments = argv;
                        var n_args = arguments.length;

                        if (n_args <= 1)
                        {
                                activate ();
                                exit_status = 0;
                        }
                        else
                        {
                                try
                                {
                                        var context = new OptionContext ("- Take photos and videos from your webcam");
                                        context.set_help_enabled (true);
                                        context.add_main_entries (options, null);
                                        context.parse (ref arguments);
                                }
                                catch (OptionError e)
                                {
                                        warning ("%s", e.message);
                                        stdout.printf ("Run '%s --help' to see a full list of available command line options.",
                                                        arguments[0]);
                                        stdout.printf ("\n");
                                        exit_status = 1;
                                        return true;
                                }

                                if (version)
                                {
                                        stdout.printf("%s %s\n", "Balística", BalisticaApplication.VERSION);
                                        exit_status = 1;
                                        return true;
                                }

                                activate ();
                                exit_status = 0;
                        }

                        return base.local_command_line (ref arguments, out exit_status);
                }
        }
} // namespace

