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

public class LibBalistica.Temperature : GLib.Object {
	/**
	 * CelsiusToFahrenheit
	 *
	 * @param cel Degress in Celsius
	 *
	 * @return Degress in Fahrenheit
	 */
	public inline static double CelsiusToFahrenheit(double cel)
	{
		return cel * 9 / 5 + 32;
	}

	/**
	 * CelsiusToKelvin
	 *
	 * @param cel Degrees in Celsius
	 *
	 * @return Degress in Kelvin
	 */
	public inline static double CelsiusToKelvin(double cel)
	{
		return cel + 273.15;
	}

	/**
	 * CelsiusToRankine
	 *
	 * @param cel Degrees in Celsius
	 *
	 * @return Degress in Rankine
	 */
	public inline static double CelsiusToRankine(double cel)
	{
		return (cel + 273.15) * 9 / 5;
	}

	/**
	 * FahrenheitToCelsius
	 *
	 * @param fahr Degrees in Fahrenheit
	 *
	 * @return Degress in Celsius
	 */
	public inline static double FahrenheitToCelsius(double fahr)
	{
		return (fahr - 32) * 5 / 9;
	}

	/**
	 * FahrenheitToKelvin
	 *
	 * @param fahr Degrees in Fahrenheit
	 *
	 * @return Degress in Kelvin
	 */
	public inline static double FahrenheitToKelvin(double fahr)
	{
		return (fahr + 459.67) * 5 / 9;
	}

	/**
	 * FahrenheitToRankine
	 *
	 * @param fahr Degrees in Fahrenheit
	 *
	 * @return Degress in Rankine
	 */
	public inline static double FahrenheitToRankine(double fahr)
	{
		return fahr + 459.67;
	}

	/**
	 * KelvinToCelsius
	 *
	 * @param kel Degrees in Kelvin
	 *
	 * @return Degress in Celsius
	 */
	public inline static double KelvinToCelsius(double kel)
	{
		return kel - 273.15;
	}

	/**
	 * KelvinToFahrenheit
	 *
	 * @param kel Degrees in Kelvin
	 *
	 * @return Degress in Fahrenheit
	 */
	public inline static double KelvinToFahrenheit(double kel)
	{
		return kel * 9 / 5 - 459.67;
	}

	/**
	 * KelvinToRankine
	 *
	 * @param kel Degrees in Kelvin
	 *
	 * @return Degress in Rankine
	 */
	public inline static double KelvinToRankine(double kel)
	{
		return kel * 9 / 5;
	}

	/**
	 * RankineToCelsius
	 *
	 * @param ran Degrees in Rankine
	 *
	 * @return Degress in Celsius
	 */
	public inline static double RankineToCelsius(double ran)
	{
		return (ran - 491.67) * 5 / 9;
	}

	/**
	 * RankineToFahrenheit
	 *
	 * @param ran Degrees in Rankine
	 *
	 * @return Degress in Fahrenheit
	 */
	public inline static double RankineToFahrenheit(double ran)
	{
		return ran - 459.67;
	}

	/**
	 * RankineToKelvin
	 *
	 * @param ran Degrees in Rankine
	 *
	 * @return Degress in Kelvin
	 */
	public inline static double RankineToKelvin(double ran)
	{
		return ran * 5 / 9;
	}
}
