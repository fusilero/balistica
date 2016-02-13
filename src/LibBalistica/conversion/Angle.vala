/* Copyright 2012-2016 Steven Oliver <oliver.steven@gmail.com>
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

public class LibBalistica.Angle : GLib.Object {
   /**
    * DegreeToMOA
    *
    * @param deg Angle in degrees
    *
    * @return Angle in MOAs
    */
   public inline static double DegreeToMOA(double deg)
   {
      return deg * 60;
   }

   /**
    * DegreeToRadian
    *
    * @param deg Angle in degrees
    *
    * @return Angle in Radians
    */
   public inline static double DegreeToRadian(double deg)
   {
      return deg * Math.PI / 180;
   }

   /**
    * RadianToDegree
    *
    * @param rad Angle in radians
    *
    * @return Angle in Degrees
    */
   public inline static double RadianToDegree(double rad)
   {
      return rad * 180 / Math.PI;
   }

   /**
    * RadianToMOA
    *
    * @param rad Angle in radians
    *
    * @return Angle in MOAs
    */
   public inline static double RadianToMOA(double rad)
   {
      return rad * 60 * 180 / Math.PI;
   }

   /**
    * MOAToDegree
    *
    * @param moa Angle in minutes of angle
    *
    * @return Angle in Degrees
    */
   public inline static double MOAToDegree(double moa)
   {
      return moa / 60;
   }

   /**
    * MOAToRadian
    *
    * @param moa Angle in minutes of angle
    *
    * @return Angle in Radians
    */
   public inline static double MOAToRadian(double moa)
   {
      return moa / 60 * Math.PI / 180;
   }
}
