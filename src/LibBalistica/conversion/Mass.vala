/* Copyright 2014 Steven Oliver <oliver.steven@gmail.com>
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

public class Conversion.Mass : GLib.Object {

        /**
        * GrainToSlug
        *
        * @param grain
        *
        * @return Slugs
        */
        public inline static double GrainToSlug (double grain) {
                return grain * 225218.34 ;
        }

        /**
        * GrainToPound
        *
        * @param grain
        *
        * @return Pounds
        */
        public inline static double GrainToPound (double grain) {
                return grain * 7000;
        }

        /**
        * GrainToOunce
        *
        * @param grain
        *
        * @return ounces
        */
        public inline static double GrainToOunce (double grain) {
                return grain * 437.5;
        }

	/**
	 * GrainToMiligrams
	 *
	 * @param grain
	 *
	 * @return Miligrams
	 */
	 public inline static double GrainToMiligrams (double grain) {
		 return grain * 64.79891;
	 }
	 
	 /**
	 * SlugToGrain
	 *
	 * @param slug
	 *
	 * @return Grains
	 */
	 public inline static double SlugToGrain (double slug) {
	 	return slug * 0.00000444013571969;
	 }
	 
	 /**
	 * SlugToPound
	 *
	 * @param slug
	 *
	 * @return Pounds
	 */
	 public inline static double SlugToPound (double slug) {
	 	return slug * 0.0310809502;
	 }
	 
	 /**
	 * SlugToOunce
	 *
	 * @param slug
	 *
	 * @return Ounces
	 */
	 public inline static double SlugToOunce (double slug) {
	 	return slug * 0.00194255939;
	 }
	 
	 /**
	 * SlugToMiligrams
	 *
	 * @param slug
	 *
	 * @return Miligrams
	 */
	 public inline static double SlugToMiligrams (double slug) {
	 	return slug * 0.014593902999991705;
	 }
}
