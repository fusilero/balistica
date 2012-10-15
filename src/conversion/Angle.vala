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

public class Balistica.Angle : GLib.Object {
        
        /**
        * DegreeToMOA
        *
        * @param deg Angle in degrees
        */
        public static double DegreeToMOA (double deg) {
                return deg * 60;
        }

        /**
        * DegreeToRadian
        *
        * @param deg Angle in degrees
        */
        public static double DegreeToRadian (double deg) {
                return deg * Math.PI/180;
        }

        /**
        * RadianToDegree
        *
        * @param rad Angle in radians
        */
        public static double RadianToDegree (double rad) {
                return rad * 180/Math.PI;
        }

        /**
        * RadianToMOA
        *
        * @param rad Angle in radians
        */
        public static double RadianToMOA (double rad) {
                return rad * 60 * 180/Math.PI;
        }

        /**
        * MOAToDegree
        *
        * @param moa Angle in minutes of angle
        */
        public static double MOAToDegree (double moa) {
                return moa/60;
        }

        /**
        * MOAToRadian
        *
        * @param moa Angle in minutes of angle
        */
        public static double MOAToRadian (double moa) {
                return moa/60 * Math.PI/180;
        }
}
