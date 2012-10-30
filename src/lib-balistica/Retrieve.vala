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

/* The code in this file was originally part of the GNU Exterior 
 * Balisitics Computer. It was licensed under the GNU General Public
 * License Version 2 by Derek Yates.
 *
 * I obviously converted it from C to Vala.
 */

using GLib;
using Balistica;

// Functions for retrieving data from a solution generated with SolveAll()
public class Balistica.Retrieve : GLib.Object {

        // Returns range, in yards.
        public double GetRange(double* sln, int yardage){
                double size = sln[BCompMaxRange * 10 + 1];
                if (yardage<size){
                        return sln[10*yardage];
                }
                else return 0;
        }

        // Returns projectile path, in inches, relative to the line of sight.
        public double GetPath(double* sln, int yardage){
                double size=sln[BCompMaxRange*10+1];
                if (yardage<size){
                        return sln[10*yardage+1];
                }
                else return 0;
        }

        // Returns an estimated elevation correction for achieving a zero at this range.
        // this is useful for "click charts" and the like.
        public double GetMOA(double* sln, int yardage){
                double size=sln[BCompMaxRange*10+1];
                if (yardage<size){
                        return sln[10*yardage+2];
                }
                else return 0;
        }

        // Returns the projectile's time of flight to this range.
        public double GetTime(double* sln, int yardage){
                double size=sln[BCompMaxRange*10+1];
                if (yardage<size){
                        return sln[10*yardage+3];
                }
                else return 0;
        }

        // Returns the windage correction in inches required to achieve zero at this range.
        public double GetWindage(double* sln, int yardage){
                double size=sln[BCompMaxRange*10+1];
                if (yardage<size){
                        return sln[10*yardage+4];
                }
                else return 0;
        }

        // Returns an approximate windage correction in MOA to achieve a zero at this range.
        public double GetWindageMOA(double* sln, int yardage){
                double size=sln[BCompMaxRange*10+1];
                if (yardage<size){
                        return sln[10*yardage+5];
                }
                else return 0;
        }

        // Returns the projectile's total velocity (Vector product of Vx and Vy)
        public double GetVelocity(double* sln, int yardage){
                double size=sln[BCompMaxRange*10+1];
                if (yardage<size){
                        return sln[10*yardage+6];
                }
                else return 0;
        }

        // Returns the velocity of the projectile in the bore direction.
        // For very steep shooting angles, Vx can actually become what you would think of as Vy relative to the ground, 
        // because Vx is referencing the bore's axis.  All computations are carried out relative to the bore's axis, and
        // have very little to do with the ground's orientation.
        public double GetVx(double* sln, int yardage){
                double size=sln[BCompMaxRange*10+1];
                if (yardage<size){
                        return sln[10*yardage+7];
                }
                else return 0;
        }

        // Returns the velocity of the projectile perpendicular to the bore direction.
        public double GetVy(double* sln, int yardage){
                double size=sln[BCompMaxRange*10+1];
                if (yardage<size){
                        return sln[10*yardage+8];
                }
                else return 0;
        }

        public double GetDrop(double* sln, int yardage){
                double size=sln[BCompMaxRange*10+1];
                if (yardage<size){
                        return sln[10*yardage+9];
                }
                else return 0;
        }
}
