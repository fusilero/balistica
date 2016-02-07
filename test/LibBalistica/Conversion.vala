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

public class ConversionTests : Balistica.TestCase {
    public ConversionTests () {
        base("Conversion");
        add_test("[Angle] Degree to MOA", test_degree_to_moa); 
        add_test("[Angle] Degree to Radian", test_degree_to_radian); 
        add_test("[Angle] Radian to Degree", test_radian_to_degree); 
        add_test("[Angle] Radian to MOA", test_radian_to_moa); 
        add_test("[Angle] MOA to Degree", test_moa_to_degree); 
        add_test("[Angle] MOA to Radian", test_moa_to_radian); 

        add_test("[Mass] Grain to Pound", test_grain_to_pound); 
        add_test("[Mass] Grain to Ounce", test_grain_to_ounce);
   }

    public virtual void test_degree_to_moa() {
        assert(LibBalistica.Angle.DegreeToMOA(2) == 120);
        assert(LibBalistica.Angle.DegreeToMOA(0) == 0);
        assert(LibBalistica.Angle.DegreeToMOA(-2) == -120);
    }

    public virtual void test_degree_to_radian() {
        assert(LibBalistica.Angle.DegreeToRadian(2) == 0.034906585039886591);
        assert(LibBalistica.Angle.DegreeToRadian(0) == 0);
        assert(LibBalistica.Angle.DegreeToRadian(-2) == -0.034906585039886591);
    }

    public virtual void test_radian_to_degree() {
        assert(LibBalistica.Angle.RadianToDegree(2) == 114.59155902616465);
        assert(LibBalistica.Angle.RadianToDegree(0) == 0);
        assert(LibBalistica.Angle.RadianToDegree(-2) == -114.59155902616465);
    }

    public virtual void test_radian_to_moa() {
        assert(LibBalistica.Angle.RadianToMOA(2) == 6875.4935415698792);
        assert(LibBalistica.Angle.RadianToMOA(0) == 0);
        assert(LibBalistica.Angle.RadianToMOA(-2) == -6875.4935415698792);
    }
    
    public virtual void test_moa_to_radian() {
        assert(LibBalistica.Angle.MOAToRadian(2) == 0.00058177641733144316);
        assert(LibBalistica.Angle.MOAToRadian(0) == 0);
        assert(LibBalistica.Angle.MOAToRadian(-2) == -0.00058177641733144316);
    }

    public virtual void test_moa_to_degree() {
        assert(LibBalistica.Angle.MOAToDegree(2) == 0.033333333333333333);
        assert(LibBalistica.Angle.MOAToDegree(0) == 0);
        assert(LibBalistica.Angle.MOAToDegree(-2) == -0.033333333333333333);
    }

    public virtual void test_grain_to_pound() {
        assert(LibBalistica.Mass.GrainToPound(2) == 0.00028571428571428574);
        assert(LibBalistica.Mass.GrainToPound(0) == 0);
        assert(LibBalistica.Mass.GrainToPound(-2) == -0.00028571428571428574);
    }

    public virtual void test_grain_to_ounce() {
        stdout.printf(LibBalistica.Mass.GrainToOunce(2).to_string());
        assert(LibBalistica.Mass.GrainToOunce(2) == 0.0045714285714285718);
        assert(LibBalistica.Mass.GrainToOunce(0) == 0);
        assert(LibBalistica.Mass.GrainToOunce(-2) == -0.0045714285714285718);
    }


}
