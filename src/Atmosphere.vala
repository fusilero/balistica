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

/* The code in this file was originally part of the GNU Balisitics 
 * Calculator. It was licensed under the GNU General Public License
 * Version 2 by Derek Yates.
 * 
 * I obviously converted it from C to Vala.
 */

using GLib;

public class Balistica.Atmosphere : GLib.Object {
        
        // Standard Atmospheric Pressure in mercury
        const double StandardPressure = 29.53;

        public double calcFR (double Temperature, double Pressure, double RelativeHumidity) {
                double VPw = 4e-6 * Math.pow(Temperature, 3) - 0.0004 * Math.pow(Temperature,2) + 0.0234 * Temperature - 0.2517;
                double FRH = 0.995 * (Pressure/(Pressure-(0.3783) * (RelativeHumidity) * VPw));
                return FRH;
        }

        public double calcFP (double Pressure) {
                return (Pressure - StandardPressure) / StandardPressure;
        }

        public double calcFT (double Temperature, double Altitude) {
                double Tstd = -0.0036 * Altitude + 59;
                double FT = (Temperature-Tstd) / (459.6 + Tstd);
                return FT;
        }

        public double calcFA (double Altitude) {
                double fa = -4e-15 * Math.pow(Altitude, 3) + 4e-10 * Math.pow(Altitude, 2) -3e-5 * Altitude + 1;
                return (1/fa);
        }

        public double AtmCorrect (double DragCoefficient, double Altitude, double Barometer, double Temperature, double RelativeHumidity) {

                double FA = calcFA(Altitude);
                double FT = calcFT(Temperature, Altitude);
                double FR = calcFR(Temperature, Barometer, RelativeHumidity);
                double FP = calcFP(Barometer);

                // Calculate the atmospheric correction factor
                double CD = (FA*(1+FT-FP)*FR);
                return DragCoefficient*CD;
        }
}
