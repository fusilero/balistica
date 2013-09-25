/* Copyright 2012, 2013 Steven Oliver <oliver.steven@gmail.com>
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

/* The code in this file was originally part of the GNU Exterior
 * Balisitics Computer. It was licensed under the GNU General Public
 * License Version 2 by Derek Yates.
 *
 * I converted it from C to Vala.
 */

using GLib;
using Conversion;

namespace Balistica.LibBalistica {

        public class Atmosphere : GLib.Object {

                /**
                 * Refraction
                 * @param Temperature
                 * @param Pressure
                 * @param RelativeHumidity
                 *
                 * @return Standardized refraction
                 */
                private double calcFR (double Temperature, double Pressure, double RelativeHumidity) {
                        double VPw = 4e-6 * Math.pow(Temperature, 3) - 0.0004 * Math.pow(Temperature, 2) + 0.0234 * Temperature - 0.2517;
                        double FRH = 0.995 * (Pressure / (Pressure - (0.3783) * (RelativeHumidity) * VPw));
                        return FRH;
                }

                /**
                 * Pressure
                 * @param Pressure
                 *
                 * @return Standardized pressure
                 */
                private double calcFP (double Pressure) {
                        return (Pressure - STANDARD_PRESSURE) / STANDARD_PRESSURE;
                }

                /**
                 * Temperature
                 * @param Temp
                 * @param Altitude
                 *
                 * @return Standardized temperature
                 */
                private double calcFT (double Temp, double Altitude) {
                        // We're calculating the standard temperature at your
                        // altitude using the lapse rate
                        // http://en.wikipedia.org/wiki/Lapse_rate
                        double Tstd = -0.0036 * Altitude + STANDARD_TEMP;

                        // Funny math where you divide by "standard temp" above
                        // converted to Ranking
                        double FT = (Temp - Tstd) / Temperature.FahrenheitToRankine(Tstd);
                        return FT;
                }

                /**
                 * Altitude
                 * @param Altitude
                 *
                 * @return Standardized altitude
                 */
                private double calcFA (double Altitude) {
                        double fa = -4e-15 * Math.pow(Altitude, 3) + 4e-10 * Math.pow(Altitude, 2) -3e-5 * Altitude + 1;
                        return (1 / fa);
                }

                /**
                 * A function to correct a "standard" Drag Coefficient for differing atmospheric conditions. 
                 * Returns the corrected drag coefficient for supplied drag coefficient and atmospheric conditions.
                 *
                 * @param DragCoefficient The coefficient of drag for a given projectile.
                 * @param Altitude The altitude above sea level in feet.  Standard altitude is 0 feet above sea level.
                 * @param Barometer The barometric pressure in inches of mercury (in Hg). This is not "absolute" pressure, it is the 
                 *                  "standardized" pressure reported in the papers and news. Standard pressure is 29.53 in Hg.
                 * @param Temperature The temperature in Fahrenheit.  Standard temperature is 59 degrees.
                 * @param RelativeHumidity The relative humidity fraction.  Ranges from 0.00 to 1.00, with 0.50 being 50% relative humidity.
                 *                         Standard humidity is 78%
                 *
                 * @return The function returns a ballistic coefficient, corrected for the supplied atmospheric conditions.
                 */
                public double AtmCorrect (double DragCoefficient, double Altitude, double Barometer, double Temperature, double RelativeHumidity) {
                        double FA = calcFA(Altitude);
                        double FT = calcFT(Temperature, Altitude);
                        double FR = calcFR(Temperature, Barometer, RelativeHumidity);
                        double FP = calcFP(Barometer);

                        // Calculate the atmospheric correction factor
                        double CD = (FA * (1 + FT - FP) * FR);
                        return DragCoefficient * CD;
                }
        }
} //namespace
