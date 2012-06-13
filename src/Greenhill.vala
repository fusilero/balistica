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

public class Balistica.Greenhill : GLib.Object {
        public int C { get; set; }
        public double diameter { get; set; }
        public double length { get; set; }
        public double specific_gravity { get; set; }

        /**
         * Default contstructor
         */
        public static Greenhill() {
                this.diameter = 0;
                this.length = 0;
                this.specific_gravity = 0;
        }
        
        /**
         * Calculate the twist of the bullet
         */
        public double calc_twist() {
                double temp1 = C * Math.pow(this.diameter, 2) / this.length;
                double temp2 = Math.sqrt(this.specific_gravity / 10.9);
                return temp1 * temp2;
        }
}
