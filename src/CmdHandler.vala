/* Copyright 2012 Steven Oliver <oliver.steven@gmail.com> 
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

public class Balistica.CmdHandler : GLib.Object {
        // Global help strings
        const string usage = "balistica [version] [-g|--green] [-m|--miller]" 
                + " [help] <command> [<args>]";

        const string common_cmds = "     Commonly used commands:"
                + "\n     miller\t\tCalculate a variable using the Miller twist rule" 
                + "\n     green\t\tCalculate a variable using the Greenhill formula";

        // Specific help
        const string specific_cmd = "See balistica help <command> for more information on a specific formula";

        const string miller_help = "\nThe Miller Twist Rule can be used to calculate the twist rate or "
                + "\nthe stability factor of a specific round."
                + "\n\n The variables used to calculate twist rate: "
                + "\n   --diameter   - the diameter of the bullet"
                + "\n   --length     - the length of the bullet"
                + "\n   --mass       - the mass of the bullet in grams"
                + "\n   --safe-value - Miller generally assumes a 'safe value'"
                + "\n                  of 2. This parameter is optional."
                + "\n\n The variables used to calculate the stability factor: "
                + "\n   --diameter - the diameter of the bullet"
                + "\n   --length   - the length of the bullet"
                + "\n   --mass     - the mass of the bullet in grams"
                + "\n   --twist    - the known twist rate\n";

        const string greenhill_help = "\nThe Greenhill formula can only be used to calculate the twist"
                + "\nrate of a round."
                + "\n\n The variables used to calculate the twist rate:"
                + "\n   --C                - a constant that should be set 150 for slow rounds "
                + "\n                        or 180 for faster rounds (above 840 m/s)"
                + "\n   --diameter         - the diameter of the bullet"
                + "\n   --length           - the length of the bullet"
                + "\n   --specific-gravity - the specific gravity of the bullet\n";

        // Default constructor. Not used.
        public static CmdHandler () {

        }

        // Handle arguments
        public static int handle_args(string[] args) {
                if (args.length == 1 || args[1] == "help") {
                        if (args[2] == "miller") {
                                stdout.printf("%s\n", miller_help);
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
                        if (args[i] == "miller") {

                        } else if (args[i] == "greenhill") {

                        } else {
                                stdout.printf("%s\n", "You have entered an unknown option!");
                                break;
                        }
                }

                return 0;
        }

        private static void print_help() {
                stdout.printf("%s\n\n", usage);
                stdout.printf("%s\n\n", common_cmds);
                stdout.printf("%s\n", specific_cmd);
        }
}
