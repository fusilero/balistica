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

public class Balistica.Calculate : GLib.Object {
    /**
     * Calculate the G1-G8 drag functions
     *
     * @param bc The ballistic coefficient
     * @param v The velocity
     * @param sh The sight height above the bore
     * @param weight The weight of the projectile
     * @param angle The shooting angle
     * @param zero The zero range
     * @param wspeed The wind speed
     * @param wangle The wind angle
     * @param alt The altitude
     * @param bar The pressure in bar
     * @param tp The current temparture
     * @param rh The relative humidity
     * @param name The solution's name
     * @param df The selected drag function
     *
     * @return
     */
    public static LibBalistica.Solution drag(double bc, double v, double sh, double weight, double angle, double zero,
                                             double wspeed, double wangle, double alt, double bar, double tp, double rh,
                                             string name, int df) {
        LibBalistica.DragFunction d ;
        int numRows ;
        double zero_angle ;          // Bore / sight angle
        var solution = new Gee.LinkedList<double ? >() ;

        double corrected_bc = LibBalistica.Atmosphere.atm_correct (bc, alt, bar, tp, rh) ;

        switch( df ){
        case 1 :
            d = LibBalistica.DragFunction.G1 ;
            break ;

        case 2:
            d = LibBalistica.DragFunction.G2 ;
            break ;

        case 5:
            d = LibBalistica.DragFunction.G5 ;
            break ;

        case 6:
            d = LibBalistica.DragFunction.G6 ;
            break ;

        case 7:
            d = LibBalistica.DragFunction.G7 ;
            break ;

        case 8:
            d = LibBalistica.DragFunction.G8 ;
            break ;

        default:
            assert_not_reached () ;
        }

        // Find the zero angle of the bore relative to the sighting system
        zero_angle = LibBalistica.Zero.ZeroAngle (d, corrected_bc, v, sh, zero, 0) ;

        // Generate a solution
        numRows = LibBalistica.Solve.SolveAll (d, corrected_bc, v, sh, angle, zero_angle, wspeed, wangle, solution) ;

        // If this succedes then we have a valid solution
        if((numRows > 0) && (solution.size > 0)){
            LibBalistica.Solution lsln = new LibBalistica.Solution.full (solution, name, corrected_bc, sh, weight, v, angle, zero,
                                                                         wspeed, wangle, tp, rh, bar, alt,
                                                                         solution.size, d) ;

            return lsln ;
        }

        // If we reach here we've failed to generate a proper solution, so
        // return an empty one to signify failure
        return new LibBalistica.Solution () ;
    }

}
