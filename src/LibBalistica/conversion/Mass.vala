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
	 
	 /**
	 * MiligramToGrain
	 *
	 * @param Miligram
	 *
	 * @return Grains
	 */
	 public inline static double MiligramToGrain (double miligram) {
	 	return miligram * 0.0154323584;
	 }
	 
	 /**
	 * MiligramToPound
	 *
	 * @param Miligram
	 *
	 * @return Pounds
	 */
	 public inline static double MiligramToPound (double miligram) {
	 	return miligram * 0.0000022;
	 }
	 
	 /**
	 * MiligramToOunce
	 *
	 * @param Miligram
	 *
	 * @return Ounces
	 */
	 public inline static double MiligramToOunce (double miligram) {
	 	return miligram * 0.000035274;
	 }
	 
	 /**
	 * MiligramToSlug
	 *
	 * @param Miligram
	 *
	 * @return Slugs
	 */
	 public inline static double MiligramToSlug (double miligram) {
	 	return miligram * 0.014593902999991705;
	 }
	 
	 /**
	 * PoundToGrain
	 *
	 * @param Pound
	 *
	 * @return Grains
	 */
	 public inline static double PoundToGrain (double pound) {
	 	return pound * 7000;
	 }
	 
	 /**
	 * PoundToMiligram
	 *
	 * @param Pound
	 *
	 * @return Miligrams
	 */
	 public inline static double PoundToMiligram (double pound) {
	 	return pound * 453592;
	 }
	 
	 /**
	 * PoundToOunce
	 *
	 * @param Pound
	 *
	 * @return Ounces
	 */
	 public inline static double PoundToOunce (double pound) {
	 	return pound * 16.0;
	 }
	 
	 /**
	 * PoundToSlug
	 *
	 * @param Pound
	 *
	 * @return Slugs
	 */
	 public inline static double PoundToSlug (double pound) {
	 	return pound * 0.0310809502;
	 }
	 
	 /**
	 * OunceToGrain
	 *
	 * @param Ounce
	 *
	 * @return Grains
	 */
	 public inline static double PoundToGrain (double ounce) {
	 	return ounce * 437.5;
	 }
	 
	 /**
	 * OunceToMiligram
	 *
	 * @param Ounce
	 *
	 * @return Miligrams
	 */
	 public inline static double PoundToMiligram (double ounce) {
	 	return ounce * 28349.5;
	 }
	 
	 /**
	 * OunceToPound
	 *
	 * @param Ounce
	 *
	 * @return Pounds
	 */
	 public inline static double OunceToPound (double ounce) {
	 	return ounce * 0.0625;
	 }
	 
	 /**
	 * OunceToSlug
	 *
	 * @param Ounce
	 *
	 * @return Slugs
	 */
	 public inline static double OunceToSlug (double ounce) {
	 	return ounce * 0.00194255939;
	 }
}
