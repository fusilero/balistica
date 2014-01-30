/* Copyright 2012-2014 Steven Oliver <oliver.steven@gmail.com>
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

namespace Balistica.LibBalistica {

        public class Miller : GLib.Object {
                public double _diameter { get; set; }
                public double _length { get; set; }
                public double _mass { get; set; }
                public int _safe_value { get; set; }
                public double _twist { get; set; }

                /**
                 * Default constructor
                 */
                public Miller() {
                        this._diameter = 0.0;
                        this._length = 0.0;
                        this._mass = 0.0;
                        this._safe_value = 2;
                }

                /**
                 * Full constructor
                 *
                 * @param d The bullet's diameter as a double
                 * @param l The bullet's length as a double
                 * @param m The bullet's mass as a double
                 * @param sv The "safe value". Generally 2.
                 */
                public Miller.full(double d, double l, double m, int sv) {
                        this._diameter = d;
                        this._length = l;
                        this._mass = m;
                        this._safe_value = sv;
                }

                /**
                 * Calculate bullet twist rate
                 */
                public double calc_twist() {
                        double temp1 = Math.sqrt(30.0 * this._mass);
                        double temp2 = this._safe_value * Math.pow(this._diameter, 3) * this._length * (1.0 + Math.pow(this._length, 2));
                        return temp1 / temp2;
                }

                /**
                 * Calculate bullet stability
                 */
                public double calc_stability() {
                        double temp1 = 30.0 * this._mass;
                        double temp2 = Math.pow(this._twist, 2) * Math.pow(this._diameter, 3) * this._length * (1.0 + Math.pow(this._length, 2));
                        return temp1 / temp2;
                }
        }

}
