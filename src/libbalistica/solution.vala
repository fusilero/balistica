/* Copyright 2012-2017 Steven Oliver <oliver.steven@gmail.com>
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

namespace LibBalistica{
   public class Solution : GLib.Object {
	  int _df ;
	  private Gee.LinkedList<CompUnit ? > _sln ;
	  private string _name ;
	  private double _weight ;
	  private double _bc ;
	  private double _sightheight ;
	  private double _mv ;
	  private double _angle ;
	  private double _zerorange ;
	  private double _windspeed ;
	  private double _windangle ;
	  private double _temp ;

	  private double _pressure ;
	  private double _humidity ;
	  private double _altitude ;

	  /**
	   * Default constructor.
	   *
	   * This is primarly used to reset the object
	   * state and prepare for a new calculation but can also be used to
	   * represent one of the following:
	   * 1) a calculation failure
	   * 2) an empty state where no calculation has taken place
	   */
	  public Solution () {
		 this._sln = new Gee.LinkedList<CompUnit ? >() ;
		 this._name = "" ;
		 this._bc = -1 ;
		 this._sightheight = -1 ;
		 this._weight = -1 ;
		 this._mv = -1 ;
		 this._angle = -1 ;
		 this._zerorange = -1 ;
		 this._windspeed = -1 ;
		 this._windangle = -1 ;
		 this._temp = -1 ;
		 this._humidity = -1 ;
		 this._pressure = -1 ;
		 this._altitude = -1 ;
		 this._df = 1 ;
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
	   * @param df The selected drag function (G1-G8)
	   */
	  public Solution.full (Gee.LinkedList<CompUnit ? > solution, string name, double bc, double sh,
							double w, double mv, double angle, double zr, double ws, double wa,
							double t, double h, double p, double a, int df)
	  {
		 this._sln = solution ;
		 this._name = name ;
		 this._bc = bc ;
		 this._sightheight = sh ;
		 this._weight = w ;
		 this._mv = mv ;
		 this._angle = angle ;
		 this._zerorange = zr ;
		 this._windspeed = ws ;
		 this._windangle = wa ;
		 this._temp = t ;
		 this._humidity = h ;
		 this._pressure = p ;
		 this._altitude = a ;
		 this._df = df ;
	  }

	  /**
	   * @return Solution calculation results
	   */
	  public Gee.LinkedList<CompUnit ? > getSolution() {
		 return this._sln ;
	  }

	  /**
	   * @return Instance name
	   */
	  public string getName() {
		 return this._name ;
	  }

	  /**
	   * @return Instance value of weight
	   */
	  public double getWeight() {
		 return this._weight ;
	  }

	  /**
	   * @return Instance value of the ballistic coefficient
	   */
	  public double getBc() {
		 return this._bc ;
	  }

	  /**
	   * @return Instance value of sight height
	   */
	  public double getSightheight() {
		 return this._sightheight ;
	  }

	  /**
	   * @return Instance value of the velocity
	   */
	  public double getMv() {
		 return this._mv ;
	  }

	  /**
	   * @return Instance value of shooting angle
	   */
	  public double getAngle() {
		 return this._angle ;
	  }

	  /**
	   * @return Instance value of zero range
	   */
	  public double getZerorange() {
		 return this._zerorange ;
	  }

	  /**
	   * @return Instance value of wind speed
	   */
	  public double getWindspeed() {
		 return this._windspeed ;
	  }

	  /**
	   * @return Instance value of wind angle
	   */
	  public double getWindangle() {
		 return this._windangle ;
	  }

	  /**
	   * @return Instance value of temperature
	   */
	  public double getTemp() {
		 return this._temp ;
	  }

	  /**
	   * @return Instance value of pressure
	   */
	  public double getPressure() {
		 return this._pressure ;
	  }

	  /**
	   * @return Instance value of humidity
	   */
	  public double getHumidity() {
		 return this._humidity ;
	  }

	  /**
	   * @return Instance value of altitude
	   */
	  public double getAltitude() {
		 return this._altitude ;
	  }

	  /**
	   * @return Instance value of number of rows in a solution
	   */
	  public int getSolutionSize() {
		 return this._sln.size ;
	  }

	  /**
	   * @param position
	   *
	   * @return The calculated range, in yards, at a given position.
	   */
	  public double getRange(int position) {
		 CompUnit cu ;
		 if( position > this._sln.size ){
			cu = this._sln[this._sln.size] ;
		 } else {
			cu = this._sln[position] ;
		 }

		 return cu.range ;
	  }

	  /**
	   * @param position
	   *
	   * @return The projectile drop, in inches, relative to the line of sight.
	   */
	  public double getDrop(int position) {
		 CompUnit cu ;
		 if( position > this._sln.size ){
			cu = this._sln[this._sln.size] ;
		 } else {
			cu = this._sln[position] ;
		 }

		 return cu.drop ;
	  }

	  /**
	   * @param position
	   *
	   * @return An estimated elevation correction for achieving a zero at this range.
	   *         This is useful for "click charts" and the like.
	   */
	  public double getMOA(int position) {
		 CompUnit cu ;
		 if( position > this._sln.size ){
			cu = this._sln[this._sln.size] ;
		 } else {
			cu = this._sln[position] ;
		 }

		 return cu.correction ;
	  }

	  /**
	   * @param position
	   *
	   * @return The projectile's time of flight to this range.
	   */
	  public double getTime(int position) {
		 CompUnit cu ;
		 if( position > this._sln.size ){
			cu = this._sln[this._sln.size] ;
		 } else {
			cu = this._sln[position] ;
		 }

		 return cu.time ;
	  }

	  /**
	   * @param position
	   *
	   * @return The windage correction in inches required to achieve zero at this range.
	   */
	  public double getWindage(int position) {
		 CompUnit cu ;
		 if( position > this._sln.size ){
			cu = this._sln[this._sln.size] ;
		 } else {
			cu = this._sln[position] ;
		 }

		 return cu.windage_in ;
	  }

	  /**
	   * @param position
	   *
	   * @return An approximate windage correction in MOA to achieve a zero at this range.
	   */
	  public double getWindageMOA(int position) {
		 CompUnit cu ;
		 if( position > this._sln.size ){
			cu = this._sln[this._sln.size] ;
		 } else {
			cu = this._sln[position] ;
		 }

		 return cu.windage_moa ;
	  }

	  /**
	   * @param position
	   *
	   * @return The projectile's total velocity (Vector product of Vx and Vy)
	   */
	  public double getVelocity(int position) {
		 CompUnit cu ;
		 if( position > this._sln.size ){
			cu = this._sln[this._sln.size] ;
		 } else {
			cu = this._sln[position] ;
		 }

		 return cu.velocity_com ;
	  }

	  /**
	   * For very steep shooting angles, Vx can actually become what you would think of as Vy relative
	   * to the ground, because Vx is referencing the bore's axis.  All computations are carried out
	   * relative to the bore's axis, and have very little to do with the ground's orientation.
	   *
	   * @param position
	   *
	   * @return The velocity of the projectile in the bore direction.
	   */
	  public double getVx(int position) {
		 CompUnit cu ;
		 if( position > this._sln.size ){
			cu = this._sln[this._sln.size] ;
		 } else {
			cu = this._sln[position] ;
		 }

		 return cu.vertical_velocity ;
	  }

	  /**
	   * @param position
	   *
	   * @return The velocity of the projectile perpendicular to the bore direction.
	   */
	  public double getVy(int position) {
		 CompUnit cu ;
		 if( position > this._sln.size ){
			cu = this._sln[this._sln.size] ;
		 } else {
			cu = this._sln[position] ;
		 }

		 return cu.horizontal_velocity ;
	  }

	  /**
	   * @param yardage
	   *
	   * @return Calculated kinetic energry (ft/lbs) at specified yard downrange.
	   */
	  public double getKineticEnergy(int yardage) {
		 /* The 450436 is (2 x 7000 x 32.174)
		  *     - 7000 converts grains to pounds
		  *     - 32.174 converts pounds to slugs (unit of mass in the English system)
		  * 2 is from the formula for kinetic energy (1/2 x Mass x Velocity^2)
		  */
		 return this._weight * Math.pow (getVelocity (yardage), 2) / 450436 ;
	  }

   }
} // namespace
