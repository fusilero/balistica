/* Copyright 2016-2017 Steven Oliver <oliver.steven@gmail.com>
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

public class LibBalisticaTests : Balistica.TestCase {
   public LibBalisticaTests () {
	  base ("LibBalistica") ;
	  add_test ("[LibBalistica] Verify gravity", test_gravity) ;
	  add_test ("[LibBalistica] Verify standard pressure", test_standard_pressure) ;
	  add_test ("[LibBalistica] Verify standard tempurature", test_standard_tempurature) ;
	  add_test ("[LibBalistica] Verify computational unit", test_computation_unit) ;
   }

   public virtual void test_gravity() {
	  assert (LibBalistica.GRAVITY == -32.1609) ;
   }

   public virtual void test_standard_pressure() {
	  assert (LibBalistica.STANDARD_PRESSURE == 29.92) ;
   }

   public virtual void test_standard_tempurature() {
	  assert (LibBalistica.STANDARD_TEMP == 59.0) ;
   }

   public virtual void test_computation_unit() {
	  LibBalistica.CompUnit unit = LibBalistica.CompUnit () {
		 range = 5.1,
		 drop = 5.2,
		 correction = 5.3,
		 time = 5.4,
		 windage_in = 5.5,
		 windage_moa = 5.6,
		 velocity_com = 5.7,
		 horizontal_velocity = 5.8,
		 vertical_velocity = 5.9
	  } ;

	  assert (unit.range == 5.1) ;
	  assert (unit.drop == 5.2) ;
	  assert (unit.correction == 5.3) ;
	  assert (unit.time == 5.4) ;
	  assert (unit.windage_in == 5.5) ;
	  assert (unit.windage_moa == 5.6) ;
	  assert (unit.velocity_com == 5.7) ;
	  assert (unit.horizontal_velocity == 5.8) ;
	  assert (unit.vertical_velocity == 5.9) ;
   }

}
