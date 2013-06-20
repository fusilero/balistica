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
using Balistica;

namespace Args {

        private const OptionEntry[] options = {
                { "miller-twist", 0, OptionArg.NONE, ref miller_twist, N_("Calculate twist using the Miller twist rule.") },
                { "miller-stability", 0, OptionArg.NONE, ref miller_stability, N_("Calculate stability using the Miller twist rule") },
                { "green", 0, OptionArg.NONE, ref green, N_("Calculate twist using the Greenhill formula") },
                { "help", 'h', OptionArg.NONE, ref help, N_("Show this Help message") },
                { "version", 'v', OptionArg.NONE, ref version, N_("Show Balisitica verion") },
                { null }
        };

        public bool miller_twist = false;
        public bool miller_stability = false;
        public bool green = false;
        public bool help = false;
        public bool version = false;

        public class CmdHandler : GLib.Object {
                // Global help strings
                private const string USAGE = "balistica [version] [-g|--green] [-m|--miller]" 
                        + " [help] <command> [<args>]";

                private const string COMMON_CMDS = "     Commonly used commands:"
                        + "\n     miller-twist\t\tCalculate twist using the Miller twist rule" 
                        + "\n     miller-stability\t\tCalculate stability using the Miller twist rule" 
                        + "\n     green\t\tCalculate twist using the Greenhill formula";

                // Specific help
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

                /**
                 * Default constructor
                 */
                public static CmdHandler () {

                }

                /**
                 * Handle arguments
                 */
                public static int handle_args(string[] args) {
                        if (args.length == 1 || args[1] == "help") {
                                if (args[2] == "miller-twist") {
                                        stdout.printf("%s\n", miller_twist_help);
                                        return 0;
                                } else if (args[2] == "miller-stability") {
                                        stdout.printf("%s\n", miller_stability_help);
                                        return 0;
                                } else if (args[2] == "greenhill") {
                                        stdout.printf("%s\n", greenhill_help);
                                        return 0;
                                } else {
                                        print_help();
                                        return 0;
                                }
                        }

                        for (int i = 1; i < args.length; i++) {
                                if (args[i] == "miller-twist") {
                                        calculate_miller_twist(args);
                                        break;
                                } else if (args[i] == "miller-stability") {
                                        calculate_miller_stability(args);
                                        break; 
                                } else if (args[i] == "greenhill") {
                                        calculate_greenhill(args);
                                        break;
                                } else {
                                        stdout.printf("%s\n", "You have entered an unknown option!");
                                        break;
                                }
                        }

                        return 0;
                }

                /**
                 * Print help message
                 */
                private static void print_help() {
                        stdout.printf("%s\n\n", usage);
                        stdout.printf("%s\n\n", common_cmds);
                        stdout.printf("%s\n", specific_cmd);
                }


        }

}       // namespace

