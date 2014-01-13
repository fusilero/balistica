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
using Conversion;

namespace Balistica.LibBalistica {

	public class PBR : GLib.Object {
		/**
		 * Solves for the maximum Point Blank Range (PBR) and associated details
		 *
		 * @param Drag The drag function you wish to use for the solution (G1, G2, G3, G5, G6, G7, or G8)
		 * @param DragCoefficient The coefficient of drag for the projectile you wish to model.
		 * @param Vi The projectile initial velocity.
		 * @param SightHeight The height of the sighting system above the bore centerline.
		 *              Most scopes are in the 1.5-2.0 inch range.
		 * @param VitalSize ??
		 * @param oresult ??
		 *
		 * @return ??
		 */
		public int pbr(DragFunction Drag, double DragCoefficient, double Vi, double SightHeight, double VitalSize, int* oresult) {
			const int PBR_ERROR = 3;

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
			bool quit = true;

			double zero = -1;
			double farzero = 0;

			bool vertex_keep = false;
			double y_vertex = 0;
			double x_vertex = 0;

			double min_pbr_range = 0;
			bool min_pbr_keep = false;

			double max_pbr_range = 0;
			bool max_pbr_keep = false;

			int tin100 = 0;
			bool keep = false;
			bool keep2 = false;
			bool tinkeep = false;

			double Gy = GRAVITY * Math.cos(Angle.DegreeToRadian((ShootingAngle + ZAngle)));
			double Gx = GRAVITY * Math.sin(Angle.DegreeToRadian((ShootingAngle + ZAngle)));

			while (quit) {
				Gy = GRAVITY * Math.cos(Angle.DegreeToRadian((ShootingAngle + ZAngle)));
				Gx = GRAVITY * Math.sin(Angle.DegreeToRadian((ShootingAngle + ZAngle)));

				vx = Vi * Math.cos(Angle.DegreeToRadian(ZAngle));
				vy = Vi * Math.sin(Angle.DegreeToRadian(ZAngle));

				x = 0;
				y = -SightHeight / 12;

				min_pbr_keep = false;
				max_pbr_keep = false;
				vertex_keep = false;

				tin100 = 0;
				tinkeep = false;
				keep = false;
				keep2 = false;

				int n = 0;
				for (t = 0; ; t = t + dt) {
					vx1 = vx;
					vy1 = vy;
					v = Math.pow(Math.pow(vx,2) + Math.pow(vy,2), 0.5);
					dt = 0.5/v;

					// Compute acceleration using the drag function retardation
					dv = Retard.CalcRetard(Drag, DragCoefficient, v);
					dvx = -(vx/v) * dv;
					dvy = -(vy/v) * dv;

					// Compute velocity, including the resolved gravity vectors
					vx = vx + dt * dvx + dt*Gx;
					vy = vy + dt * dvy + dt*Gy;

					// Compute position based on average velocity
					x = x + dt * (vx + vx1) / 2;
					y = y + dt * (vy + vy1) / 2;

					if (y > 0 && keep == false && vy >= 0) {
						zero = x;
						keep = true;
					}

					if (y < 0 && keep2 == false && vy <= 0) {
						farzero = x;
						keep2 = true;
					}

					if ((12 * y) > -(VitalSize / 2) && min_pbr_keep == false) {
						min_pbr_range = x;
						min_pbr_keep = true;
					}

					if ((12 * y) < -(VitalSize / 2) && min_pbr_keep == true && max_pbr_keep == false) {
						max_pbr_range = x;
						max_pbr_keep = true;
					}

					if (x >= 300 && tinkeep == false){
						tin100 = (int)(100.0 * y * 12.0);
						tinkeep = true;
					}

					if ((Math.fabs(vy) > Math.fabs(3 * vx)) || (n >= BCOMP_MAX_RANGE + 1)) {
						result = PBR_ERROR;
						break;
					}

					// The PBR will be maximum at the point where the vertex is 1/2 vital zone size
					if (vy < 0 && vertex_keep == false){
						y_vertex = y;
						x_vertex = x;
						vertex_keep = true;
					}

					if (keep == true && keep2 == true && min_pbr_keep == true && max_pbr_keep == true && vertex_keep == true && tinkeep == true) {
						break;
					}
				}

				if ((y_vertex * 12) > (VitalSize / 2)) {
					if (Step > 0)
						Step = -Step / 2; // Vertex too high. Go downwards.
				} else if ((y_vertex * 12) <= (VitalSize / 2)) { // Vertex too low. Go upwards.
					if (Step < 0)
						Step = -Step / 2;
				}

				ZAngle += Step;

				if (Math.fabs(Step) < (0.01 / 60))
					quit = false;
			}

			oresult[0] = (int)(zero/3); // Near Zero
			oresult[1] = (int)(farzero/3); // Far zero
			oresult[2] = (int)(min_pbr_range/3); // Minimum PBR
			oresult[3] = (int)(max_pbr_range/3); // Maximum PBR
			oresult[4] = tin100; // Sight-in at 100 yds (in 100ths of an inch)

			return 0;
		}
	}
} //namespace
