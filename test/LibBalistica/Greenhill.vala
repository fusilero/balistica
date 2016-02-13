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

public class GreenhillTests : Balistica.TestCase {
   public GreenhillTests()
   {
      base("Greenhill");
      add_test("[Twist] Calculate twist", test_calc_twist);
   }

   public virtual void test_calc_twist()
   {
      LibBalistica.Greenhill g = new LibBalistica.Greenhill();
      g.diameter         = 0.5;
      g.length           = 1.5;
      g.specific_gravity = 1;
      g.C = 150;
      assert(g.calc_twist() == 7.5722816601922833);

      g = new LibBalistica.Greenhill();
      assert(g.calc_twist() == 0);
   }
}
