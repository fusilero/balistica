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

using Gee ;

namespace LibBalistica{
   public class Solve : GLib.Object {
	  /**
	   * A function to generate a ballistic solution table in 1 yard increments, up to BCOMP_MAXRANGE.
	   *
	   * @param DragFunction The drag function you wish to use for the solution (G1, G2, G3, G5, G6, G7, or G8)
	   * @param DragCoefficient The coefficient of drag for the projectile you wish to model.
	   * @param Vi The projectile initial velocity.
	   * @param SightHeight The height of the sighting system above the bore centerline.
	   *              Most scopes are in the 1.5-2.0 inch range.
	   * @param ShootingAngle The uphill or downhill shooting angle, in degrees.  Usually 0, but can be anything from
	   *              90 (directly up), to -90 (directly down).
	   * @param ZeroAngle The angle of the sighting system relative to the bore, in degrees.  This can be easily computed
	   *              using the ZeroAngle() function documented above.
	   * @param WindSpeed The wind velocity, in mi/hr
	   * @param WindAngle The angle at which the wind is approaching from, in degrees.
	   *              0 degrees is a straight headwind
	   *              90 degrees is from right to left
	   *              180 degrees is a straight tailwind
	   *              -90 or 270 degrees is from left to right.
	   * @return An integer representing the maximum valid range of the solution.  This also indicates the maximum
	   *         number of rows in the solution matrix, and should not be exceeded.
	   */
	  public static Gee.LinkedList<LibBalistica.CompUnit ? > SolveAll(DragFunction drag, double DragCoefficient, double Vi, double SightHeight, double ShootingAngle,
																	  double ZeroAngle, double WindSpeed, double WindAngle) {
		 double t = 0 ;
		 double dt = 0.5 / Vi ;
		 double v = 0 ;
		 double vx = 0, vx1 = 0, vy = 0, vy1 = 0 ;
		 double dv = 0, dvx = 0, dvy = 0 ;
		 double x = 0, y = 0 ;

		 double headwind = Windage.HeadWind (WindSpeed, WindAngle) ;
		 double crosswind = Windage.CrossWind (WindSpeed, WindAngle) ;

		 double Gy = GRAVITY * Math.cos (Angle.DegreeToRadian ((ShootingAngle + ZeroAngle))) ;
		 double Gx = GRAVITY * Math.sin (Angle.DegreeToRadian ((ShootingAngle + ZeroAngle))) ;

		 // Compute the horizontal and vertical components of velocity, respectively
		 vx = Vi * Math.cos (Angle.DegreeToRadian (ZeroAngle)) ;
		 vy = Vi * Math.sin (Angle.DegreeToRadian (ZeroAngle)) ;

		 y = -SightHeight / 12 ;

		 Gee.LinkedList<LibBalistica.CompUnit ? > solution = new Gee.LinkedList<LibBalistica.CompUnit ? >() ;
		 int n = 0 ;
		 for( t = 0 ; ; t = t + dt ){
			vx1 = vx ;
			vy1 = vy ;
			v = Math.pow (Math.pow (vx, 2) + Math.pow (vy, 2), 0.5) ;
			dt = 0.5 / v ;

			// Compute acceleration using the drag function retardation
			dv = Retard.CalcRetard (drag, DragCoefficient, v + headwind) ;
			dvx = -(vx / v) * dv ;
			dvy = -(vy / v) * dv ;

			// Compute velocity, including the resolved gravity vectors.
			vx = vx + dt * dvx + dt * Gx ;
			vy = vy + dt * dvy + dt * Gy ;

			if( x / 3 >= n ){
			   double wind_tmp = Windage.CalcWindage (crosswind, Vi, x, t + dt) ;
			   CompUnit unit = CompUnit () {
				  range = x / 3,
				  path = y * 12,
				  correction = -Angle.RadianToMOA (Math.atan (y / x)),
				  time = t + dt,
				  windage_in = wind_tmp,
				  windage_moa = Angle.RadianToMOA (Math.atan (wind_tmp)),
				  velocity_com = v,
				  horizontal_velocity = vx,
				  vertical_velocity = vy
			   } ;

			   solution.add (unit) ;
			   n++ ;
			}

			// Compute position based on average velocity.
			x = x + dt * (vx + vx1) / 2 ;
			y = y + dt * (vy + vy1) / 2 ;

			if( Math.fabs (vy) > Math.fabs (3 * vx)){
			   break ;
			}

			if( n >= BCOMP_MAX_RANGE + 1 ){
			   break ;
			}
		 }

		 return solution ;
	  }

   }
} // namespace
