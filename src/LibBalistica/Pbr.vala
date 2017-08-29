/* Copyright 2014-2017 Steven Oliver <oliver.steven@gmail.com>
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
   public class PBR : GLib.Object {

	  /**
	   * Solves for the maximum Point Blank Range (PBR) and associated details
	   *
	   * @param Drag The drag function you wish to use for the solution (G1, G2, G3, etc.)
	   * @param DragCoefficient The coefficient of drag for the projectile you wish to model.
	   * @param Vi The projectile initial velocity.
	   * @param SightHeight The height of the sighting system above the bore centerline.
	   *					Most scopes are in the 1.5-2.0 inch range.
	   * @param VitalSize Size in inches of the target at which the point of impact
	   *				  must remain in, e.g. the point impact must always be within a
	   *				  two inch diameter circle.
	   *
	   * @return A LibBalistica.PbrResult struct containing our five results.
	   */
	  public static LibBalistica.PbrResult pbr(DragFunction Drag, double DragCoefficient, double Vi, double SightHeight, double VitalSize) {
		 LibBalistica.PbrResult result = LibBalistica.PbrResult () ;

		 double t = 0 ;
		 double dt = 0.5 / Vi ;
		 double v = 0 ;
		 double vx, vx1, vy, vy1 ;
		 double dv = 0, dvx = 0, dvy = 0 ;
		 double x, y ;
		 double ShootingAngle = 0 ;
		 double ZAngle = 0 ;
		 double Step = 10 ;

		 bool quit = true ;

		 bool vertex_keep = false ;
		 double y_vertex = 0 ;
		 double x_vertex = 0 ;

		 double min_pbr_range = 0 ;
		 bool min_pbr_keep = false ;

		 double max_pbr_range = 0 ;
		 bool max_pbr_keep = false ;

		 double tin100 = 0 ;

		 double zero = -1 ;
		 double farzero = 0 ;
		 bool zero_keep, farzero_keep, tinkeep ;

		 double Gx, Gy ;

		 while( quit ){
			Gy = GRAVITY * Math.cos (Angle.DegreeToRadian ((ShootingAngle + ZAngle))) ;
			Gx = GRAVITY * Math.sin (Angle.DegreeToRadian ((ShootingAngle + ZAngle))) ;

			vx = Vi * Math.cos (Angle.DegreeToRadian (ZAngle)) ;
			vy = Vi * Math.sin (Angle.DegreeToRadian (ZAngle)) ;

			x = 0 ;
			y = -SightHeight / 12.0 ;

			min_pbr_keep = false ;
			max_pbr_keep = false ;
			vertex_keep = false ;

			tin100 = 0 ;
			tinkeep = false ;
			zero_keep = false ;
			farzero_keep = false ;

			int n = 0 ;
			for( t = 0 ; ; t = t + dt ){
			   vx1 = vx ;
			   vy1 = vy ;
			   v = Math.pow (Math.pow (vx, 2) + Math.pow (vy, 2), 0.5) ;
			   dt = 0.5 / Vi ;

			   // Compute acceleration using the drag function retardation
			   dv = Retard.CalcRetard (Drag, DragCoefficient, v) ;
			   dvx = -(vx / v) * dv ;
			   dvy = -(vy / v) * dv ;

			   // Compute velocity, including the resolved gravity vectors
			   vx = vx + dt * dvx + dt * Gx ;
			   vy = vy + dt * dvy + dt * Gy ;

			   // Compute position based on average velocity
			   x = x + dt * (vx + vx1) / 2.0 ;
			   y = y + dt * (vy + vy1) / 2.0 ;

			   if((y > 0) && (zero_keep == false) && (vy >= 0)){
				  zero = x ;
				  zero_keep = true ;
			   }

			   if((y < 0) && (farzero_keep == false) && (vy <= 0)){
				  farzero = x ;
				  farzero_keep = true ;
			   }

			   if(((12 * y) > -(VitalSize / 2)) && (min_pbr_keep == false)){
				  min_pbr_range = x ;
				  min_pbr_keep = true ;
			   }

			   if(((12 * y) < -(VitalSize / 2)) && (min_pbr_keep == true) && (max_pbr_keep == false)){
				  max_pbr_range = x ;
				  max_pbr_keep = true ;
			   }

			   if((x >= 300) && (tinkeep == false)){
				  tin100 = 100.0 * y * 12.0 ;
				  tinkeep = true ;
			   }

			   if((Math.fabs (vy) > Math.fabs (3 * vx)) || (n >= BCOMP_MAX_RANGE + 1)){
				  break ;
			   }

			   // The PBR will be maximum at the point where the vertex is 1/2 vital zone size
			   if((vy < 0) && (vertex_keep == false)){
				  y_vertex = y ;
				  x_vertex = x ;
				  vertex_keep = true ;
			   }

			   if((zero_keep == true) && (farzero_keep == true) && (min_pbr_keep == true) && (max_pbr_keep == true) && (vertex_keep == true) && (tinkeep == true)){
				  break ;
			   }
			}

			if((y_vertex * 12) > (VitalSize / 2.0)){
			   // Vertex too high. Go downwards.
			   if( Step > 0 ){
				  Step = -Step / 2.0 ;
			   }
			} else if((y_vertex * 12) <= (VitalSize / 2.0)){
			   // Vertex too low. Go upwards.
			   if( Step < 0 ){
				  Step = -Step / 2.0 ;
			   }
			}

			ZAngle += Step ;

			if( Math.fabs (Step) < (0.01 / 60)){
			   quit = false ;
			}
		 }

		 result.near_zero = zero / 3 ;
		 result.far_zero = farzero / 3 ;
		 result.min_pbr = min_pbr_range / 3 ;
		 result.max_pbr = max_pbr_range / 3 ;
		 // At 100 yards (in 100ths of an inch)
		 result.sight_in_height = tin100 ;

		 return result ;
	  }

   }
} // namespace
