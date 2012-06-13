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

public class Balistica.Miller : GLib.Object {
        public double diameter { get; set; }
        public double length { get; set; }
        public double mass { get; set; }
        public int safe_value { get; set; }
        public double twist { get; set; }

        /**
         * Default constructor
         */
        public static Miller() {
                this.diameter = 0.0;
                this.length = 0.0;
                this.mass = 0.0;
                this.safe_value = 2;
        }

        /**
         * Calculate bullet twist rate
         */
        public double calc_twist() {
                double temp1 = Math.sqrt(30.0 * this.mass);
                double temp2 = this.safe_value * Math.pow(this.diameter, 3) * this.length * (1.0 + Math.pow(this.length, 2));
                return temp1 / temp2;
        }

        /**
         * Calculate bullet stability
         */
        public double calc_stability() {
                double temp1 = 30.0 * this.mass;
                double temp2 = Math.pow(this.twist, 2) * Math.pow(this.diameter, 3) * this.length * (1.0 + Math.pow(this.length, 2));
                return temp1 / temp2;
        }
}
