/* Copyright 2012-2014 Steven Oliver <oliver.steven@gmail.com>
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

namespace Balistica.LibBalistica {

	/**
	 *
	 */
	public class Solution : GLib.Object {
		int _df;
		private Gee.LinkedList<double?> _sln;
		private string _name;
		private int _weight;
		private double _bc;
		private double _sightheight;
		private int _mv;
		private int _angle;
		private int _zerorange;
		private int _windspeed;
		private int _windangle;
		private int _temp;
		private int _ckweather;

		private double _pressure;
		private int _humidity;
		private int _altitude;
		private int _rows;

		/**
		 *
		 */
		public Solution (Gee.LinkedList<double?> solution, string name, double bc, double sh,
				int w, int mv, int angle, int zr, int ws, int wa, int t, int h,
				double p, int a, int entries, int useweather, int df) {
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
			_ckweather = useweather;
			_df = df;
		}

		/**
		 * @return
		 */
		public string getName() {
			return this._name;
		}

		/**
		 * @return
		 */
		public int getWeight() {
			return this._weight;
		}

		/**
		 * @return
		 */
		public double getBc() {
			return this._bc;
		}

		/**
		 * @return
		 */
		public double getSightheight() {
			return this._sightheight;
		}

		/**
		 * @return
		 */
		public int getMv() {
			return this._mv;
		}

		/**
		 * @return
		 */
		public int getAngle() {
			return this._angle;
		}

		/**
		 * @return
		 */
		public int getZerorange() {
			return this._zerorange;
		}

		/**
		 * @return
		 */
		public int getWindspeed() {
			return this._windspeed;
		}

		/**
		 * @return
		 */
		public int getWindangle() {
			return this._windangle;
		}

		/**
		 * @return
		 */
		public int getTemp() {
			return this._temp;
		}

		/**
		 * @return
		 */
		public int getCkweater() {
			return this._ckweather;
		}

		/**
		 * @return
		 */
		public double getPressure() {
			return this._pressure;
		}

		/**
		 * @return
		 */
		public int getHumidity() {
			return this._humidity;
		}

		/**
		 * @return
		 */
		public int getAltitude() {
			return this._altitude;
		}

		/**
		 * @return
		 */
		public int getRows() {
			return this._rows;
		}

		/**
		 * @param yardage
		 *
		 * @return Range, in yards.
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
		 * @return Projectile path, in inches, relative to the line of sight.
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
		 * @return
		 */
		public double getDrop(int yardage){
			double size = this._sln[BCOMP_MAX_RANGE*10 + 1];
			if (yardage < size){
				return this._sln[10*yardage + 9];
			}
			else return 0;
		}

		/**
		 *
		 */
		public double getEnergy(int k) {
			return (double)this._weight * Math.pow(getVelocity(k), 2) / 450436;
		}
	}
} //namespace
