/* Copyright 2012-2016 Steven Oliver <oliver.steven@gmail.com>
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

namespace LibBalistica {
/**
 * Gravity in feet per second squared
 * Value according to Wolfram Alpha
 */
public const double GRAVITY = -32.1609;

/**
 * Standard Atmospheric Pressure in inches mercury
 * Value according to Wolfram Alpha
 */
public const double STANDARD_PRESSURE = 29.92;

/**
 * Standard Tempurature in degrees Fahrenheit
 * This value was determined by the US Ordnance Department as an
 * average value over a wide range of altitudes
 */
public const double STANDARD_TEMP = 59.0;

/**
 * Arbitrary constant used to denote the max range
 * of calculations
 */
public const int BCOMP_MAX_RANGE = 50001;

/**
 * The different drag functions you are allowed to pick from
 */
public enum DragFunction
{
	G1 = 1,
	G2,
	G3,
	G4,
	G5,
	G6,
	G7,
	G8,
	I,
	B;

	public string to_string()
	{
		switch (this)
		{
		case G1:
			return "G1";

		case G2:
			return "G2";

		case G3:
			return "G3";

		case G4:
			return "G4";

		case G5:
			return "G5";

		case G6:
			return "G6";

		case G7:
			return "G7";

		case G8:
			return "G8";

		case I:
			return "Ingalls";

		case B:
			return "British";

		default:
			assert_not_reached();
		}
	}
}
} //namespace
