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
using Conversion;

namespace Balistica.LibBalistica {
        public class Zero : GLib.Object {

                /**
                 * ZeroAngle
                 *
                 * A function to determine the bore angle needed to achieve a target zero at Range yards
                 * (at standard conditions and on level ground.)
                 *
                 * @param DragFunction The drag function to use (G1, G2, G3, G5, G6, G7, G8)
                 * @param DragCoefficient The coefficient of drag for the projectile, for the supplied drag function.
                 * @param Vi The initial velocity of the projectile, in feet/s
                 * @param SightHeight The height of the sighting system above the bore centerline, in inches.
                 *              Most scopes fall in the 1.6 to 2.0 inch range.
                 * @param ZeroRange The range in yards, at which you wish the projectile to intersect yIntercept.
                 * @param yIntercept The height, in inches, you wish for the projectile to be when it crosses ZeroRange yards.
                 *             This is usually 0 for a target zero, but could be any number.  For example if you wish
                 *             to sight your rifle in 1.5 inches high at 100 yds, then you would set yIntercept to 1.5,
                 *             and ZeroRange to 100
                 *
                 * @return The angle of the bore relative to the sighting system, in degrees.
                 */
                public static double ZeroAngle(DragFunction drag, double DragCoefficient, double Vi, double SightHeight, double ZeroRange, double yIntercept){
                        // Numerical Integration variables
                        double t = 0;
                        // The solution accuracy generally doesn't suffer if its within a foot for each second of time.
                        double dt = 1 / Vi;
                        double y = -SightHeight/12;
                        double x = 0;
                        // The change in the bore angle used to iterate in on the correct zero angle.
                        double da;

                        // State variables for each integration loop.
                        double v = 0, vx = 0, vy = 0; // velocity
                        double vx1 = 0, vy1 = 0; // Last frame's velocity, used for computing average velocity.
                        double dv = 0, dvx = 0, dvy = 0; // acceleration
                        double Gx = 0, Gy = 0; // Gravitational acceleration

                        double angle = 0; // The actual angle of the bore.

                        bool quit = false;

                        // Start with a very coarse angular change, to quickly solve even large launch angle problems.
                        da = Angle.DegreeToRadian(14);

                        // The general idea here is to start at 0 degrees elevation, and increase the elevation by
                        // 14 degrees until we are above the correct elevation.  Then reduce the angular change by half,
                        // and begin reducing the angle.  Once we are again below the correct angle, reduce the angular
                        // change by half again, and go back up.  This allows for a fast successive approximation of the
                        // correct elevation, usually within less than 20 iterations.
                        for (angle = 0; quit == false; angle = angle + da){
                                vy = Vi * Math.sin(angle);
                                vx = Vi * Math.cos(angle);
                                Gx = GRAVITY * Math.sin(angle);
                                Gy = GRAVITY * Math.cos(angle);

                                for (t = 0, x = 0, y = -SightHeight / 12; x <= ZeroRange * 3; t = t + dt){
                                        vy1 = vy;
                                        vx1 = vx;
                                        v = Math.pow((Math.pow(vx,2) + Math.pow(vy,2)), 0.5);
                                        dt = 1 / v;

                                        dv = Retard.CalcRetard(drag, DragCoefficient, v);
                                        dvy = -dv * vy / v*dt;
                                        dvx = -dv * vx / v*dt;

                                        vx = vx + dvx;
                                        vy = vy + dvy;
                                        vy = vy + dt * Gy;
                                        vx = vx + dt * Gx;

                                        x = x + dt * (vx + vx1) / 2;
                                        y = y + dt * (vy + vy1) / 2;

                                        // Break early to save CPU time if we won't find a solution
                                        if (vy < 0 && y < yIntercept) {
                                                break;
                                        }

                                        if (vy > 3 * vx) {
                                                break;
                                        }
                                }

                                if (y > yIntercept && da > 0) {
                                        da = -da / 2;
                                }

                                if (y < yIntercept && da < 0) {
                                        da = -da / 2;
                                }

                               // If our accuracy is sufficient, we can stop approximating
                               if (Math.fabs(da) < Angle.MOAToRadian(0.01)) {
                                        quit = true;
                                }

				// If we exceed the 45 degree launch angle, then the projectile just
				// won't get there, so stop trying
                                if (angle > Angle.DegreeToRadian(45)) {
					quit = true;
                                }
                        }

                        // Convert to degrees for return value.
                        return Angle.RadianToDegree(angle);
                }
        }
} //namespace
