/* Copyright 2016 Steven Oliver <oliver.steven@gmail.com>
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

}
