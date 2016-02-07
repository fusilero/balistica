/* Copyright 2014-2016 Steven Oliver <oliver.steven@gmail.com>
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

public class LibBalistica.Mass : GLib.Object {

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
     * OunceToGrain
     *
     * @param Ounce
     *
     * @return Grains
     */
        public inline static double OunceToGrain (double ounce) {
            return ounce * 437.5;
        }

    /**
     * OunceToMiligram
     *
     * @param Ounce
     *
     * @return Miligrams
     */
        public inline static double OunceToMiligram (double ounce) {
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
}
