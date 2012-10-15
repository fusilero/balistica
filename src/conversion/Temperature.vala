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

public class Balistica.Temerature : GLib.Object {
        public static double CelsiusToFahrenheit (double cel) {
                return cel * 9/5 + 32;
        }

        public static double CelisusToKelvin (double cel) {
                return cel + 273.15;
        }

        public static double CelisusToRankine (double cel) {
                return (cel + 273.15) * 9/5;
        }

        public static double FahrenheitToCelsius (double fahr) {
                return (fahr - 32) * 5/9;
        }

        public static double FahrenheitToKelvin (double fahr) {
                return (fahr + 459.67) * 5/9;
        }

        public static double FahrenheitToRankine (double fahr) {
                return fahr + 459.67;
        }

        public static double KelvinToCelsius (double kel) {
                return kel - 273.15;
        }

        public static double KelvinToFahrenheit (double kel) {
                return kel * 9/5 - 459.67;
        }

        public static double KelvinToRankine (double kel) {
                return kel * 9/5;
        }

        public static double RankineToCelsius (double ran) {
                return (ran - 491.67) * 5/9;
        }

        public static double RankineToFahrenheit (double ran) {
                return ran - 459.67;
        }

        public static double RankineToKelvin (double ran) {
                return ran * 5/9;
        }
}
