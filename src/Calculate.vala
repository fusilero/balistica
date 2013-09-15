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

public class Balistica.Calculate {
        /**
         * Calculate twist using the Miller formula
         */
        public static void miller_twist(string[] args) {
                LibBalistica.Miller m = new LibBalistica.Miller();

                for (int i = 2; i < args.length; i++) {
                        if (args[i] == "--diameter") {
                                m.diameter = double.parse(args[i+1]);
                        } else if (args[i] == "--length") {
                                m.length = double.parse(args[i+1]);
                        } else if (args[i] == "--mass"){
                                m.mass = double.parse(args[i+1]);
                        } else if (args[i] == "--safe-value") {
                                m.safe_value = int.parse(args[i+1]);
                        }
                }

                stdout.printf("%g\n", m.calc_twist());
        }

        /**
         * Calculate stability using the Miller formula
         */
        public static void miller_stability(string[] args) {
                LibBalistica.Miller m = new LibBalistica.Miller();

                for (int i = 2; i < args.length; i++) {
                        if (args[i] == "--diameter") {
                                m.diameter = double.parse(args[i+1]);
                        } else if (args[i] == "--length") {
                                m.length = double.parse(args[i+1]);
                        } else if (args[i] == "--mass"){
                                m.mass = double.parse(args[i+1]);
                        } else if (args[i] == "--twist") {
                                m.twist = double.parse(args[i+1]);
                        }
                }

                stdout.printf("%g\n", m.calc_stability());
        }

        /**
         * Calculate twist using the Greenhill formula
         */
        public static void greenhill(string[] args) {
                LibBalistica.Greenhill g = new LibBalistica.Greenhill();

                for (int i = 2; i < args.length; i++) {
                        if (args[i] == "--diameter") {
                                g.diameter = double.parse(args[i+1]);
                        } else if (args[i] == "--length") {
                                g.length = double.parse(args[i+1]);
                        } else if (args[i] == "--specific-gravity"){
                                g.specific_gravity = double.parse(args[i+1]);
                        } else if (args[i] == "--C") {
                                g.C = int.parse(args[i+1]);
                        }
                }

                stdout.printf("%g\n", g.calc_twist());
        }
}
