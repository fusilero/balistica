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
        const string balistica_usage = "balistica [version] [-g|--green] [-m|--miller]\n" 
                + "     [help] <command> [<args>]";

        const string balistica_common_cmds = "     Commonly used commands:\n"
                + "     miller\t\tCalculate a variable using the Miller twist rule" 
                + "\n     green\t\tCalculate a variable using the Greenhill formula";

        const string balistica_specific_cmd = "See balistica help <command> for more information on a specific formula";

        public static CmdHandler () {

        }

        // Handle arguments
        public static int handle_args(string[] args) {
                if(args.length == 1) {
                        print_help();
                        return 0;
                }

                for (int i = 1; i < args.length; i++) {
                        if (args[i] == "help") {
                                print_help();
                                break;
                        } else if (args[i] == "miller") {

                        } else if (args[i] == "greenhill") {
                        
                        } else {
                                stdout.printf("%s\n", "You have entered an unknown option!");
                                break;
                        }
                }

                return 0;
        }

        private static void print_help() {
                stdout.printf("%s\n\n", balistica_usage);
                stdout.printf("%s\n\n", balistica_common_cmds);
                stdout.printf("%s\n", balistica_specific_cmd);
        }
}
