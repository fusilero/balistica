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

namespace Balistica {

        private const OptionEntry[] options = {
                { "miller-twist", 0, 0, OptionArg.NONE, ref miller_twist, N_("Calculate twist using the Miller twist rule.") },
                { "miller-stability", 0, 0, OptionArg.NONE, ref miller_stability, N_("Calculate stability using the Miller twist rule") },
                { "greenhill", 0, 0, OptionArg.NONE, ref greenhill, N_("Calculate twist using the Greenhill formula") },
                { "help", 'h', 0, OptionArg.NONE, ref help, N_("Show this Help message") },
                { "version", 'v', 0, OptionArg.NONE, ref version, N_("Show Balística verion") },
                { null }
        };

        public bool miller_twist = false;
        public bool miller_stability = false;
        public bool greenhill = false;
        public bool help = false;
        public bool version = false;

        public class CmdHandler : GLib.Object {
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
                                stdout.printf(_("Failed to parse command line options \"%s\"\n"), error.message);
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

        }
} // namespace

