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

public class AngleTests : Balistica.TestCase {
    public AngleTests () {
        base("Angle");
        add_test("[Angle] Conversion from Degree to MOA ", test_degree_to_moa); 
    }

    public virtual void test_degree_to_moa() {
        double result = LibBalistica.Angle.DegreeToMOA(2);

        assert(result == 120);
    }
}
