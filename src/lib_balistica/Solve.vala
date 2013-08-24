/* Copyright 2012, 2013 Steven Oliver <oliver.steven@gmail.com>
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

/* The code in this file was originally part of the GNU Exterior 
 * Balisitics Computer. It was licensed under the GNU General Public
 * License Version 2 by Derek Yates.
 *
 * I obviously converted it from C to Vala.
 */

using GLib;
using Conversion;

public class Balistica.LibBalistica.Solve : GLib.Object {
        /**
         * A function to generate a ballistic solution table in 1 yard increments, up to BCOMP_MAXRANGE.
         *
         * @param DragFunction The drag function you wish to use for the solution (G1, G2, G3, G5, G6, G7, or G8)
         * @param DragCoefficient The coefficient of drag for the projectile you wish to model.
         * @param Vi The projectile initial velocity.
         * @param SightHeight The height of the sighting system above the bore centerline.
         *             Most scopes are in the 1.5-2.0 inch range.
         * @param ShootingAngle The uphill or downhill shooting angle, in degrees.  Usually 0, but can be anything from
         *               90 (directly up), to -90 (directly down).
         * @param ZeroAngle The angle of the sighting system relative to the bore, in degrees.  This can be easily computed
         *           using the ZeroAngle() function documented above.
         * @param WindSpeed The wind velocity, in mi/hr
         * @param WindAngle The angle at which the wind is approaching from, in degrees.
         *              0 degrees is a straight headwind
         *              90 degrees is from right to left
         *              180 degrees is a straight tailwind
         *              -90 or 270 degrees is from left to right.
         * @return An integer representing the maximum valid range of the solution.  This also indicates the maximum
         *         number of rows in the solution matrix, and should not be exceeded in order to avoid a memory
         *         segmentation fault.
         */
        public int SolveAll(int DragFunction, double DragCoefficient, double Vi, double SightHeight, double ShootingAngle, double ZAngle, double WindSpeed, double WindAngle) {
                double[] ptr = {};

                double t=0;
                double dt=0.5 / Vi;
                double v=0;
                double vx=0, vx1=0, vy=0, vy1=0;
                double dv=0, dvx=0, dvy=0;
                double x=0, y=0;

                double headwind = Windage.HeadWind(WindSpeed, WindAngle);
                double crosswind = Windage.CrossWind(WindSpeed, WindAngle);

                double Gy = Gravity * Math.cos(Angle.DegreeToRadian((ShootingAngle + ZAngle)));
                double Gx = Gravity * Math.sin(Angle.DegreeToRadian((ShootingAngle + ZAngle)));

                vx = Vi * Math.cos(Angle.DegreeToRadian(ZAngle));
                vy = Vi * Math.sin(Angle.DegreeToRadian(ZAngle));

                y = -SightHeight / 12;

                int n = 0;
                for (t = 0;; t = t + dt) {
                        vx1 = vx;
                        vy1 = vy;
                        v = Math.pow(Math.pow(vx, 2) + Math.pow(vy, 2), 0.5);
                        dt = 0.5 / v;

                        // Compute acceleration using the drag function retardation
                        dv = Retard.CalcRetard(DragFunction, DragCoefficient, v + headwind);
                        dvx = -(vx / v) * dv;
                        dvy = -(vy / v) * dv;

                        // Compute velocity, including the resolved gravity vectors.
                        vx = vx + dt * dvx + dt * Gx;
                        vy = vy + dt * dvy + dt * Gy;

                        if (x / 3 >= n){
                                ptr[10 * n + 0] = x / 3;		// Range in yds
                                ptr[10 * n + 1] = y * 12;		// Path in inches
                                ptr[10 * n + 2] = -1 * Angle.RadianToMOA(Math.atan(y/x));	        // Correction in MOA
                                ptr[10 * n + 3] = t + dt;		// Time in s
                                ptr[10 * n + 4] = Windage.CalcWindage(crosswind, Vi, x, t + dt);	// Windage in inches
                                ptr[10 * n + 5] = Angle.RadianToMOA(Math.atan(ptr[10 * n + 4]));        // Windage in MOA
                                ptr[10 * n + 6] = v;			// Velocity (combined)
                                ptr[10 * n + 7] = vx;			// Velocity (x)
                                ptr[10 * n + 8] = vy;			// Velocity (y)
                                ptr[10 * n + 9] = 0;			// Reserved
                                n++;
                        }

                        // Compute position based on average velocity.
                        x = x + dt * (vx + vx1) / 2;
                        y = y + dt * (vy + vy1) / 2;

                        if (Math.fabs(vy) > Math.fabs(3 * vx)) break;
                        if (n >= BCompMaxRange + 1) break;
                }

                ptr[10 * BCompMaxRange + 1] = (double)n;

                return n;
        }
}
