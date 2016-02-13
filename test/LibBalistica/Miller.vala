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

public class MillerTests : Balistica.TestCase {
   public MillerTests()
   {
      base("Miller");
      add_test("[Twist] Calculate twist", test_calc_twist);
      add_test("[Stability] Calculate stability", test_calc_stability);
   }

   public virtual void test_calc_twist()
   {
      LibBalistica.Miller m = new LibBalistica.Miller();
      m.diameter   = 0.5;
      m.length     = 1.5;
      m.mass       = 1;
      m.safe_value = 2;
      assert(m.calc_twist() == 4.4941338051705939);

      m = new LibBalistica.Miller();
      assert(m.calc_twist() == 1.3693063937629153);
   }

   public virtual void test_calc_stability()
   {
      LibBalistica.Miller m = new LibBalistica.Miller();
      m.diameter   = 0.5;
      m.length     = 1.5;
      m.mass       = 1;
      m.safe_value = 2;
      assert(m.calc_stability() == 2.4375);

      m = new LibBalistica.Miller();
      assert(m.calc_stability() == 8);
   }
}
