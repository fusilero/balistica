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

/* The code in this file was originally part of the GNU Exterior
 * Balisitics Computer. It was licensed under the GNU General Public
 * License Version 2 by Derek Yates.
 */

using GLib;

namespace Balistica.LibBalistica {

	public class Solution : GLib.Object {
		int _df;
		private Gee.LinkedList<double?> _sln;
		private string _name;
		private double _weight;
		private double _bc;
		private double _sightheight;
		private double _mv;
		private double _angle;
		private double _zerorange;
		private double _windspeed;
		private double _windangle;
		private double _temp;

		private double _pressure;
		private double _humidity;
		private double _altitude;
		private int _rows;

		/**
		 * Default constructor. This is primarly used to reset the object
                 * state and prepare for a new calculation but can also be used to
                 * represent one of the following:
		 * 1) a calculation failure
                 * 2) an empty state where no calculation has taken place
		 */
		public Solution() {
                        _sln = new Gee.LinkedList<double?>();
			_name = "";
			_bc = -1;
			_sightheight = -1;
			_weight = -1;
			_mv = -1;
			_angle = -1;
			_zerorange = -1;
			_windspeed = -1;
			_windangle = -1;
			_temp = -1;
			_humidity = -1;
			_pressure = -1;
			_altitude = -1;
			_rows = -1;
			_df = 1;
		}

		/**
		 * @param solution Calculated solution
		 * @param name Calculation's name
		 * @param bc Ballistic coefficent
		 * @param sh Sightheight
		 * @param w Weight
		 * @param mv Velocity
		 * @param angle Shooting angle
		 * @param zr Zero range
		 * @param ws Wind speed
		 * @param wa Wind angle
		 * @param t Temperature
		 * @param h Humidity
		 * @param p Pressure
		 * @param a Altitude
		 * @param entries Number of entries in the solution
		 * @param df The selected drag function (G1-G8)
		 */
		public Solution.full (Gee.LinkedList<double?> solution, string name, double bc, double sh,
				 double w, double mv, double angle, double zr, double ws, double wa,
				 double t, double h, double p, double a, int entries, int df) {
			_sln = solution;
			_name = name;
			_bc = bc;
			_sightheight = sh;
			_weight = w;
			_mv = mv;
			_angle = angle;
			_zerorange = zr;
			_windspeed = ws;
			_windangle = wa;
			_temp = t;
			_humidity = h;
			_pressure = p;
			_altitude = a;
			_rows = entries;
			_df = df;
		}

                /**
                 * @return Solution calculation results
                 */
                public Gee.LinkedList<double?> getSolution() {
                        return this._sln;
                }

		/**
		 * @return Instance name
		 */
		public string getName() {
			return this._name;
		}

		/**
		 * @return Instance value of weight
		 */
		public double getWeight() {
			return this._weight;
		}

		/**
		 * @return Instance value of the ballistic coefficient
		 */
		public double getBc() {
			return this._bc;
		}

		/**
		 * @return Instance value of sight height
		 */
		public double getSightheight() {
			return this._sightheight;
		}

		/**
		 * @return Instance value of the velocity
		 */
		public double getMv() {
			return this._mv;
		}

		/**
		 * @return Instance value of shooting angle
		 */
		public double getAngle() {
			return this._angle;
		}

		/**
		 * @return Instance value of zero range
		 */
		public double getZerorange() {
			return this._zerorange;
		}

		/**
		 * @return Instance value of wind speed
		 */
		public double getWindspeed() {
			return this._windspeed;
		}

		/**
		 * @return Instance value of wind angle
		 */
		public double getWindangle() {
			return this._windangle;
		}

		/**
		 * @return Instance value of temperature
		 */
		public double getTemp() {
			return this._temp;
		}

		/**
		 * @return Instance value of pressure
		 */
		public double getPressure() {
			return this._pressure;
		}

		/**
		 * @return Instance value of humidity
		 */
		public double getHumidity() {
			return this._humidity;
		}

		/**
		 * @return Instance value of altitude
		 */
		public double getAltitude() {
			return this._altitude;
		}

		/**
		 * @return Instance value of number of rows in a solution
		 */
		public int getRows() {
			return this._rows;
		}

		/**
		 * @param yardage
		 *
		 * @return The calculated range, in yards.
		 */
		public double getRange(int yardage){
			double size = this._sln[BCOMP_MAX_RANGE * 10 + 1];
			if (yardage < size){
				return this._sln[10*yardage];
			}
			else return 0;
		}

		/**
		 * @param yardage
		 *
		 * @return The projectile path, in inches, relative to the line of sight.
		 */
		public double getPath(int yardage){
			double size = this._sln[BCOMP_MAX_RANGE*10 + 1];
			if (yardage < size){
				return this._sln[10*yardage + 1];
			}
			else return 0;
		}

		/**
		 * @param yardage
		 *
		 * @return An estimated elevation correction for achieving a zero at this range. 
		 *         This is useful for "click charts" and the like.
		 */
		public double getMOA(int yardage){
			double size = this._sln[BCOMP_MAX_RANGE*10 + 1];
			if (yardage < size){
				return this._sln[10*yardage + 2];
			}
			else return 0;
		}

		/**
		 * @param yardage
		 *
		 * @return The projectile's time of flight to this range.
		 */
		public double getTime(int yardage){
			double size = this._sln[BCOMP_MAX_RANGE*10 + 1];
			if (yardage < size){
				return this._sln[10*yardage + 3];
			}
			else return 0;
		}

		/**
		 * @param yardage
		 *
		 * @return The windage correction in inches required to achieve zero at this range.
		 */
		public double getWindage(int yardage){
			double size = this._sln[BCOMP_MAX_RANGE*10 + 1];
			if (yardage < size){
				return this._sln[10*yardage + 4];
			}
			else return 0;
		}

		/**
		 * @param yardage
		 *
		 * @return An approximate windage correction in MOA to achieve a zero at this range.
		 */
		public double getWindageMOA(int yardage){
			double size = this._sln[BCOMP_MAX_RANGE*10 + 1];
			if (yardage < size){
				return this._sln[10*yardage + 5];
			}
			else return 0;
		}

		/**
		 * @param yardage
		 *
		 * @return The projectile's total velocity (Vector product of Vx and Vy)
		 */
		public double getVelocity(int yardage){
			double size = this._sln[BCOMP_MAX_RANGE*10 + 1];
			if (yardage < size){
				return this._sln[10*yardage + 6];
			}
			else return 0;
		}

		/**
		 * For very steep shooting angles, Vx can actually become what you would think of as Vy relative
		 * to the ground, because Vx is referencing the bore's axis.  All computations are carried out
		 * relative to the bore's axis, and have very little to do with the ground's orientation.
		 *
		 * @param yardage
		 *
		 * @return The velocity of the projectile in the bore direction.
		 */
		public double getVx(int yardage){
			double size = this._sln[BCOMP_MAX_RANGE*10 + 1];
			if (yardage < size){
				return this._sln[10*yardage + 7];
			}
			else return 0;
		}

		/**
		 * @param yardage
		 *
		 * @return The velocity of the projectile perpendicular to the bore direction.
		 */
		public double getVy(int yardage){
			double size = this._sln[BCOMP_MAX_RANGE*10 + 1];
			if (yardage < size){
				return this._sln[10*yardage + 8];
			}
			else return 0;
		}

		/**
		 * @param yardage
		 *
		 * @return Calculated bullet drop in yards.
		 */
		public double getDrop(int yardage){
			double size = this._sln[BCOMP_MAX_RANGE*10 + 1];
			if (yardage < size){
				return this._sln[10*yardage + 9];
			}
			else return 0;
		}

		/**
		 * @param yardage
		 *
		 * @return Calculated kinetic energry (ft/lbs) at specified yard downrange.
		 */
		public double getKineticEnergy(int yardage) {
			/* The 450436 is (2 x 7000 x 32.174)
			 * 2 is from the formula for kinetic energy (1/2 x Mass x Velocity^2)
			 * 7000 converts grains to pounds
			 * 32.174 converts pounds to slugs (unit of mass in the English system)
			 */
			return this._weight * Math.pow(getVelocity(yardage), 2) / 450436;
		}
	}
} //namespace
