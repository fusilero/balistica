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
	  base ("Conversion") ;
	  add_test ("[Angle] Degree to MOA", test_degree_to_moa) ;
	  add_test ("[Angle] Degree to Radian", test_degree_to_radian) ;
	  add_test ("[Angle] Radian to Degree", test_radian_to_degree) ;
	  add_test ("[Angle] Radian to MOA", test_radian_to_moa) ;
	  add_test ("[Angle] MOA to Degree", test_moa_to_degree) ;
	  add_test ("[Angle] MOA to Radian", test_moa_to_radian) ;

	  add_test ("[Mass] Grain to Pound", test_grain_to_pound) ;
	  add_test ("[Mass] Grain to Ounce", test_grain_to_ounce) ;
	  add_test ("[Mass] Grain to Miligram", test_grain_to_miligram) ;
	  add_test ("[Mass] Miligram to Grain", test_miligram_to_grain) ;
	  add_test ("[Mass] Miligram to Pound", test_miligram_to_pound) ;
	  add_test ("[Mass] Miligram to Ounce", test_miligram_to_ounce) ;
	  add_test ("[Mass] Pound to Grain", test_pound_to_grain) ;
	  add_test ("[Mass] Pound to Miligram", test_pound_to_miligram) ;
	  add_test ("[Mass] Pound to Ounce", test_pound_to_ounce) ;
	  add_test ("[Mass] Ounce to Grain", test_ounce_to_grain) ;
	  add_test ("[Mass] Ounce to Miligram", test_ounce_to_miligram) ;
	  add_test ("[Mass] Ounce to Pound", test_ounce_to_pound) ;

	  add_test ("[Temp] Fahrenheit to Kelvin", test_fahrenheit_to_kelvin) ;
	  add_test ("[Temp] Fahrenheit to Celsius", test_fahrenheit_to_celsius) ;
	  add_test ("[Temp] Fahrenheit to Rankine", test_fahrenheit_to_rankine) ;
	  add_test ("[Temp] Kelvin to Fahrenheit", test_kelvin_to_fahrenheit) ;
	  add_test ("[Temp] Kelvin to Celsius", test_kelvin_to_celsius) ;
	  add_test ("[Temp] Kelvin to Rankine", test_kelvin_to_rankine) ;
	  add_test ("[Temp] Celsius to Fahrenheit", test_celsius_to_fahrenheit) ;
	  add_test ("[Temp] Celsius to Kelvin", test_celsius_to_kelvin) ;
	  add_test ("[Temp] Celsius to Rankine", test_celsius_to_rankine) ;
	  add_test ("[Temp] Rankine to Fahrenheit", test_rankine_to_fahrenheit) ;
	  add_test ("[Temp] Rankine to Celsius", test_rankine_to_celsius) ;
	  add_test ("[Temp] Rankine to Kelvin", test_rankine_to_kelvin) ;
   }

   /*
    * Angle Tests
    */
   public virtual void test_degree_to_moa() {
	  assert (LibBalistica.Angle.DegreeToMOA (2) == 120) ;
	  assert (LibBalistica.Angle.DegreeToMOA (0) == 0) ;
	  assert (LibBalistica.Angle.DegreeToMOA (-2) == -120) ;
   }

   public virtual void test_degree_to_radian() {
	  assert (LibBalistica.Angle.DegreeToRadian (2) == 0.034906585039886591) ;
	  assert (LibBalistica.Angle.DegreeToRadian (0) == 0) ;
	  assert (LibBalistica.Angle.DegreeToRadian (-2) == -0.034906585039886591) ;
   }

   public virtual void test_radian_to_degree() {
	  assert (LibBalistica.Angle.RadianToDegree (2) == 114.59155902616465) ;
	  assert (LibBalistica.Angle.RadianToDegree (0) == 0) ;
	  assert (LibBalistica.Angle.RadianToDegree (-2) == -114.59155902616465) ;
   }

   public virtual void test_radian_to_moa() {
	  assert (LibBalistica.Angle.RadianToMOA (2) == 6875.4935415698792) ;
	  assert (LibBalistica.Angle.RadianToMOA (0) == 0) ;
	  assert (LibBalistica.Angle.RadianToMOA (-2) == -6875.4935415698792) ;
   }

   public virtual void test_moa_to_radian() {
	  assert (LibBalistica.Angle.MOAToRadian (2) == 0.00058177641733144316) ;
	  assert (LibBalistica.Angle.MOAToRadian (0) == 0) ;
	  assert (LibBalistica.Angle.MOAToRadian (-2) == -0.00058177641733144316) ;
   }

   public virtual void test_moa_to_degree() {
	  assert (LibBalistica.Angle.MOAToDegree (2) == 0.033333333333333333) ;
	  assert (LibBalistica.Angle.MOAToDegree (0) == 0) ;
	  assert (LibBalistica.Angle.MOAToDegree (-2) == -0.033333333333333333) ;
   }

   /*
    * Mass Tests
    */
   public virtual void test_grain_to_pound() {
	  assert (LibBalistica.Mass.GrainToPound (2) == 0.00028571428571428574) ;
	  assert (LibBalistica.Mass.GrainToPound (0) == 0) ;
	  assert (LibBalistica.Mass.GrainToPound (-2) == -0.00028571428571428574) ;
   }

   public virtual void test_grain_to_ounce() {
	  assert (LibBalistica.Mass.GrainToOunce (2) == 0.0045714285714285718) ;
	  assert (LibBalistica.Mass.GrainToOunce (0) == 0) ;
	  assert (LibBalistica.Mass.GrainToOunce (-2) == -0.0045714285714285718) ;
   }

   public virtual void test_grain_to_miligram() {
	  assert (LibBalistica.Mass.GrainToMiligram (2) == 129.59782000000001) ;
	  assert (LibBalistica.Mass.GrainToMiligram (0) == 0) ;
	  assert (LibBalistica.Mass.GrainToMiligram (-2) == -129.59782000000001) ;
   }

   public virtual void test_miligram_to_grain() {
	  assert (LibBalistica.Mass.MiligramToGrain (2) == 0.030864716800000001) ;
	  assert (LibBalistica.Mass.MiligramToGrain (0) == 0) ;
	  assert (LibBalistica.Mass.MiligramToGrain (-2) == -0.030864716800000001) ;
   }

   public virtual void test_miligram_to_pound() {
	  assert (LibBalistica.Mass.MiligramToPound (2) == 4.4000000000000002e-06) ;
	  assert (LibBalistica.Mass.MiligramToPound (0) == 0) ;
	  assert (LibBalistica.Mass.MiligramToPound (-2) == -4.4000000000000002e-06) ;
   }

   public virtual void test_miligram_to_ounce() {
	  assert (LibBalistica.Mass.MiligramToOunce (2) == 7.0548000000000003e-05) ;
	  assert (LibBalistica.Mass.MiligramToOunce (0) == 0) ;
	  assert (LibBalistica.Mass.MiligramToOunce (-2) == -7.0548000000000003e-05) ;
   }

   public virtual void test_pound_to_grain() {
	  assert (LibBalistica.Mass.PoundToGrain (2) == 14000) ;
	  assert (LibBalistica.Mass.PoundToGrain (0) == 0) ;
	  assert (LibBalistica.Mass.PoundToGrain (-2) == -14000) ;
   }

   public virtual void test_pound_to_miligram() {
	  assert (LibBalistica.Mass.PoundToMiligram (2) == 907184) ;
	  assert (LibBalistica.Mass.PoundToMiligram (0) == 0) ;
	  assert (LibBalistica.Mass.PoundToMiligram (-2) == -907184) ;
   }

   public virtual void test_pound_to_ounce() {
	  assert (LibBalistica.Mass.PoundToOunce (2) == 32) ;
	  assert (LibBalistica.Mass.PoundToOunce (0) == 0) ;
	  assert (LibBalistica.Mass.PoundToOunce (-2) == -32) ;
   }

   public virtual void test_ounce_to_grain() {
	  assert (LibBalistica.Mass.OunceToGrain (2) == 875) ;
	  assert (LibBalistica.Mass.OunceToGrain (0) == 0) ;
	  assert (LibBalistica.Mass.OunceToGrain (-2) == -875) ;
   }

   public virtual void test_ounce_to_miligram() {
	  assert (LibBalistica.Mass.OunceToMiligram (2) == 56699) ;
	  assert (LibBalistica.Mass.OunceToMiligram (0) == 0) ;
	  assert (LibBalistica.Mass.OunceToMiligram (-2) == -56699) ;
   }

   public virtual void test_ounce_to_pound() {
	  assert (LibBalistica.Mass.OunceToPound (2) == 0.125) ;
	  assert (LibBalistica.Mass.OunceToPound (0) == 0) ;
	  assert (LibBalistica.Mass.OunceToPound (-2) == -0.125) ;
   }

   /*
    * Temperature Tests
    */
   public virtual void test_fahrenheit_to_kelvin() {
	  assert (LibBalistica.Temperature.FahrenheitToKelvin (2) == 256.48333333333335) ;
	  assert (LibBalistica.Temperature.FahrenheitToKelvin (0) == 255.37222222222221) ;
	  assert (LibBalistica.Temperature.FahrenheitToKelvin (-2) == 254.26111111111109) ;
   }

   public virtual void test_fahrenheit_to_celsius() {
	  assert (LibBalistica.Temperature.FahrenheitToCelsius (2) == -16.666666666666668) ;
	  assert (LibBalistica.Temperature.FahrenheitToCelsius (0) == -17.777777777777779) ;
	  assert (LibBalistica.Temperature.FahrenheitToCelsius (-2) == -18.888888888888889) ;
   }

   public virtual void test_fahrenheit_to_rankine() {
	  assert (LibBalistica.Temperature.FahrenheitToRankine (2) == 461.67000000000002) ;
	  assert (LibBalistica.Temperature.FahrenheitToRankine (0) == 459.67000000000002) ;
	  assert (LibBalistica.Temperature.FahrenheitToRankine (-2) == 457.67000000000002) ;
   }

   public virtual void test_kelvin_to_fahrenheit() {
	  assert (LibBalistica.Temperature.KelvinToFahrenheit (2) == -456.06999999999999) ;
	  assert (LibBalistica.Temperature.KelvinToFahrenheit (0) == -459.67000000000002) ;
	  assert (LibBalistica.Temperature.KelvinToFahrenheit (-2) == -463.27000000000004) ;
   }

   public virtual void test_kelvin_to_celsius() {
	  assert (LibBalistica.Temperature.KelvinToCelsius (2) == -271.14999999999998) ;
	  assert (LibBalistica.Temperature.KelvinToCelsius (0) == -273.14999999999998) ;
	  assert (LibBalistica.Temperature.KelvinToCelsius (-2) == -275.14999999999998) ;
   }

   public virtual void test_kelvin_to_rankine() {
	  assert (LibBalistica.Temperature.KelvinToRankine (2) == 3.6000000000000001) ;
	  assert (LibBalistica.Temperature.KelvinToRankine (0) == 0) ;
	  assert (LibBalistica.Temperature.KelvinToRankine (-2) == -3.6000000000000001) ;
   }

   public virtual void test_celsius_to_fahrenheit() {
	  assert (LibBalistica.Temperature.CelsiusToFahrenheit (2) == 35.600000000000001) ;
	  assert (LibBalistica.Temperature.CelsiusToFahrenheit (0) == 32) ;
	  assert (LibBalistica.Temperature.CelsiusToFahrenheit (-2) == 28.399999999999999) ;
   }

   public virtual void test_celsius_to_kelvin() {
	  assert (LibBalistica.Temperature.CelsiusToKelvin (2) == 275.14999999999998) ;
	  assert (LibBalistica.Temperature.CelsiusToKelvin (0) == 273.14999999999998) ;
	  assert (LibBalistica.Temperature.CelsiusToKelvin (-2) == 271.14999999999998) ;
   }

   public virtual void test_celsius_to_rankine() {
	  assert (LibBalistica.Temperature.CelsiusToRankine (2) == 495.26999999999998) ;
	  assert (LibBalistica.Temperature.CelsiusToRankine (0) == 491.66999999999996) ;
	  assert (LibBalistica.Temperature.CelsiusToRankine (-2) == 488.06999999999999) ;
   }

   public virtual void test_rankine_to_fahrenheit() {
	  assert (LibBalistica.Temperature.RankineToFahrenheit (2) == -457.67000000000002) ;
	  assert (LibBalistica.Temperature.RankineToFahrenheit (0) == -459.67000000000002) ;
	  assert (LibBalistica.Temperature.RankineToFahrenheit (-2) == -461.67000000000002) ;
   }

   public virtual void test_rankine_to_celsius() {
	  assert (LibBalistica.Temperature.RankineToCelsius (2) == -272.03888888888889) ;
	  assert (LibBalistica.Temperature.RankineToCelsius (0) == -273.14999999999998) ;
	  assert (LibBalistica.Temperature.RankineToCelsius (-2) == -274.26111111111112) ;
   }

   public virtual void test_rankine_to_kelvin() {
	  assert (LibBalistica.Temperature.RankineToKelvin (2) == 1.1111111111111112) ;
	  assert (LibBalistica.Temperature.RankineToKelvin (0) == 0) ;
	  assert (LibBalistica.Temperature.RankineToKelvin (-2) == -1.1111111111111112) ;
   }

}
