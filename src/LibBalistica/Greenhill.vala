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

        public class Greenhill : GLib.Object {
                public int _C { get; set; }
                public double _diameter { get; set; }
                public double _length { get; set; }
                public double _specific_gravity { get; set; }

                /**
                 * Default constructor
                 */
                public Greenhill() {
                        this._diameter = 0;
                        this._length = 0;
                        this._specific_gravity = 0;
                }

                /**
                 * Full constructor
                 *
                 * @param d The bullet's diameter as a double
                 * @param l The bullet's length as a double
                 * @param sg The bullet's specific gravity as a double
                 */
                public Greenhill.full(double d, double l, double sg) {
                        this._diameter = d;
                        this._length = l;
                        this._specific_gravity = sg;
                }

                /**
                 * Calculate the twist of the bullet
                 */
                public double calc_twist() {
                        double temp1 = this._C * Math.pow(this._diameter, 2) / this._length;
                        double temp2 = Math.sqrt(this._specific_gravity / 10.9);
                        return temp1 * temp2;
                }
        }
}
