/* Copyright 2014 Steven Oliver <oliver.steven@gmail.com>
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

	public class PBR : GLib.Object {
		/**
		 * Solves for the maximum Point blank range and associated details.
		 *
		 * @param DragFunction The drag function you wish to use for the solution (G1, G2, G3, G5, G6, G7, or G8)
		 *
		 * @return
		 */
		public int pbr(int DragFunction, double DragCoefficient, double Vi, double SightHeight, double VitalSize, int* oresult) {
			double t = 0;
			double dt = 0.5/Vi;
			double v = 0;
			double vx = 0, vx1 = 0, vy = 0, vy1 = 0;
			double dv = 0, dvx = 0, dvy = 0;
			double x = 0, y = 0;
			double ShootingAngle = 0;
			double ZAngle = 0;
			double Step = 10;

			int result = 0;
			int quit = 0;

			double zero = -1;
			double farzero = 0;

			int vertex_keep = 0;
			double y_vertex = 0;
			double x_vertex = 0;

			double min_pbr_range =0 ;
			int min_pbr_keep = 0;

			double max_pbr_range = 0;
			int max_pbr_keep = 0;

			int tin100 = 0;

			double Gy = GRAVITY*cos(DegtoRad((ShootingAngle + ZAngle)));
			double Gx = GRAVITY*sin(DegtoRad((ShootingAngle + ZAngle)));

			while (quit == 0) {
				Gy = GRAVITY*cos(DegtoRad((ShootingAngle + ZAngle)));
				Gx = GRAVITY*sin(DegtoRad((ShootingAngle + ZAngle)));

				vx = Vi*cos(DegtoRad(ZAngle));
				vy = Vi*sin(DegtoRad(ZAngle));

				x = 0;
				y = -SightHeight/12;

				int keep = 0;
				int keep2 = 0;
				int tinkeep = 0;
				min_pbr_keep = 0;
				max_pbr_keep = 0;
				vertex_keep = 0;

				tin100 = 0;
				tinkeep = 0;

				int n = 0;
				for (t = 0; ; t = t + dt) {
					vx1 = vx, vy1 = vy;
					v = pow(pow(vx,2)+pow(vy,2),0.5);
					dt = 0.5/v;

					// Compute acceleration using the drag function retardation
					dv = retard(DragFunction,DragCoefficient,v);
					dvx = -(vx/v)*dv;
					dvy = -(vy/v)*dv;

					// Compute velocity, including the resolved gravity vectors
					vx=vx + dt*dvx + dt*Gx;
					vy=vy + dt*dvy + dt*Gy;

					// Compute position based on average velocity
					x=x+dt*(vx+vx1)/2;
					y=y+dt*(vy+vy1)/2;

					if (y>0 && keep==0 && vy>=0) {
						zero=x;
						keep=1;
					}

					if (y<0 && keep2==0 && vy<=0){
						farzero=x;
						keep2=1;
					}

					if ((12*y)>-(VitalSize/2) && min_pbr_keep==0){
						min_pbr_range=x;
						min_pbr_keep=1;
					}

					if ((12*y)<-(VitalSize/2) && min_pbr_keep==1 && max_pbr_keep==0){
						max_pbr_range=x;
						max_pbr_keep=1;
					}

					if (x>=300 && tinkeep==0){
						tin100=(int)((float)100*(float)y*(float)12);
						tinkeep=1;
					}


					if (fabs(vy)>fabs(3*vx)) { result=PBR_ERROR; break; }
					if (n>=__BCOMP_MAXRANGE__+1) { result=PBR_ERROR; break;}


					// The PBR will be maximum at the point where the vertex is 1/2 vital zone size
					if (vy<0 && vertex_keep==0){
						y_vertex=y;
						x_vertex=x;
						vertex_keep=1;
					}


					if (keep==1 && keep2==1 && min_pbr_keep==1 && max_pbr_keep==1 && vertex_keep==1 && tinkeep==1) {
						break;
					}
				}

				if ((y_vertex*12)>(VitalSize/2)) {
					if (Step>0)
						Step=-Step/2; // Vertex too high.  Go downwards.
				} else if ((y_vertex*12)<=(VitalSize/2)) { // Vertex too low.  Go upwards.
					if (Step < 0)
						Step =-Step/2;
				}

				ZAngle += Step;

				if (fabs(Step) < (0.01/60))
					quit=1;
			}

			oresult[0]=(int)(zero/3); // Near Zero
			oresult[1]=(int)(farzero/3); // Far zero
			oresult[2]=(int)(min_pbr_range/3); // Minimum PBR
			oresult[3]=(int)(max_pbr_range/3); // Maximum PBR
			oresult[4]=(int)tin100; // Sight-in at 100 yds (in 100ths of an inch)

			return 0;
		}
	}
} //namespace
