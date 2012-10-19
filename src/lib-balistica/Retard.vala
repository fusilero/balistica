/* Copyright 2012 Steven Oliver <oliver.steven@gmail.com> 
 *
 * This file is part of balistica.
 *
 * balistica is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * balistica is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with balistica.  If not, see <http://www.gnu.org/licenses/>.
 */

/* The code in this file was originally part of the GNU Exterior 
 * Balisitics Computer. It was licensed under the GNU General Public
 * License Version 2 by Derek Yates.
 * 
 * I obviously converted it from C to Vala.
 */

using GLib;

public class Balistica.Retard : GLib.Object {

        enum DragFunctions {
                G1 = 1,
                G2,
                G3,
                G4,
                G5,
                G6,
                G7,
                G8;
/*
                public string to_string() {
                        switch (this) {
                                case G1: return "G1";
                                case G2: return "G2";
                                case G3: return "G3";
                                case G4: return "G4";
                                case G5: return "G5";
                                case G6: return "G6";
                                case G7: return "G7";
                                case G8: return "G8";
                                default: assert_not_reached();
                        }
                }
*/
        }

        /**
         * A function to calculate ballistic retardation values based on standard drag functions.
         * 
         * @param DragFunction G1, G2, G3, G4, G5, G6, G7, or G8.  All are enumerated.
         * @param DragCoefficient The coefficient of drag for the projectile for the given drag function.
         * @param Vi The Velocity of the projectile.
         *
         * @return The projectile drag retardation velocity, in ft/s per second.
         */
        public static double Retard(int DragFunction, double DragCoefficient, double Velocity) {
                double vp = Velocity;
                double val = -1;
                double A = -1;
                double M = -1;

                switch (DragFunction) {
                        case DragFunctions.G1:
                                if (vp > 4230) { A = 1.477404177730177e-04; M = 1.9565; }
                                else if (vp> 3680) { A = 1.920339268755614e-04; M = 1.925 ; }
                                else if (vp> 3450) { A = 2.894751026819746e-04; M = 1.875 ; }
                                else if (vp> 3295) { A = 4.349905111115636e-04; M = 1.825 ; }
                                else if (vp> 3130) { A = 6.520421871892662e-04; M = 1.775 ; }
                                else if (vp> 2960) { A = 9.748073694078696e-04; M = 1.725 ; }
                                else if (vp> 2830) { A = 1.453721560187286e-03; M = 1.675 ; }
                                else if (vp> 2680) { A = 2.162887202930376e-03; M = 1.625 ; }
                                else if (vp> 2460) { A = 3.209559783129881e-03; M = 1.575 ; }
                                else if (vp> 2225) { A = 3.904368218691249e-03; M = 1.55  ; }
                                else if (vp> 2015) { A = 3.222942271262336e-03; M = 1.575 ; }
                                else if (vp> 1890) { A = 2.203329542297809e-03; M = 1.625 ; }
                                else if (vp> 1810) { A = 1.511001028891904e-03; M = 1.675 ; }
                                else if (vp> 1730) { A = 8.609957592468259e-04; M = 1.75  ; }
                                else if (vp> 1595) { A = 4.086146797305117e-04; M = 1.85  ; }
                                else if (vp> 1520) { A = 1.954473210037398e-04; M = 1.95  ; }
                                else if (vp> 1420) { A = 5.431896266462351e-05; M = 2.125 ; }
                                else if (vp> 1360) { A = 8.847742581674416e-06; M = 2.375 ; }
                                else if (vp> 1315) { A = 1.456922328720298e-06; M = 2.625 ; }
                                else if (vp> 1280) { A = 2.419485191895565e-07; M = 2.875 ; }
                                else if (vp> 1220) { A = 1.657956321067612e-08; M = 3.25  ; }
                                else if (vp> 1185) { A = 4.745469537157371e-10; M = 3.75  ; }
                                else if (vp> 1150) { A = 1.379746590025088e-11; M = 4.25  ; }
                                else if (vp> 1100) { A = 4.070157961147882e-13; M = 4.75  ; }
                                else if (vp> 1060) { A = 2.938236954847331e-14; M = 5.125 ; }
                                else if (vp> 1025) { A = 1.228597370774746e-14; M = 5.25  ; }
                                else if (vp>  980) { A = 2.916938264100495e-14; M = 5.125 ; }
                                else if (vp>  945) { A = 3.855099424807451e-13; M = 4.75  ; }
                                else if (vp>  905) { A = 1.185097045689854e-11; M = 4.25  ; }
                                else if (vp>  860) { A = 3.566129470974951e-10; M = 3.75  ; }
                                else if (vp>  810) { A = 1.045513263966272e-08; M = 3.25  ; }
                                else if (vp>  780) { A = 1.291159200846216e-07; M = 2.875 ; }
                                else if (vp>  750) { A = 6.824429329105383e-07; M = 2.625 ; }
                                else if (vp>  700) { A = 3.569169672385163e-06; M = 2.375 ; }
                                else if (vp>  640) { A = 1.839015095899579e-05; M = 2.125 ; }
                                else if (vp>  600) { A = 5.71117468873424e-05 ; M = 1.950 ; }
                                else if (vp>  550) { A = 9.226557091973427e-05; M = 1.875 ; }
                                else if (vp>  250) { A = 9.337991957131389e-05; M = 1.875 ; }
                                else if (vp>  100) { A = 7.225247327590413e-05; M = 1.925 ; }
                                else if (vp>   65) { A = 5.792684957074546e-05; M = 1.975 ; }
                                else if (vp>    0) { A = 5.206214107320588e-05; M = 2.000 ; }
                                break;
                        case DragFunctions.G2:
                                if (vp> 1674 ) { A = 0.0079470052136733;  M = 1.36999902851493; }
                                else if (vp> 1172 ) { A = 1.00419763721974e-03;  M = 1.65392237010294; }
                                else if (vp> 1060 ) { A = 7.15571228255369e-23;  M = 7.91913562392361; }
                                else if (vp>  949 ) { A = 1.39589807205091e-10;  M = 3.81439537623717; }
                                else if (vp>  670 ) { A = 2.34364342818625e-04;  M = 1.71869536324748; }
                                else if (vp>  335 ) { A = 1.77962438921838e-04;  M = 1.76877550388679; }
                                else if (vp>    0 ) { A = 5.18033561289704e-05;  M = 1.98160270524632; }
                                break;
                        case DragFunctions.G5:
                                if (vp> 1730 ){ A = 7.24854775171929e-03; M = 1.41538574492812; }
                                else if (vp> 1228 ){ A = 3.50563361516117e-05; M = 2.13077307854948; }
                                else if (vp> 1116 ){ A = 1.84029481181151e-13; M = 4.81927320350395; }
                                else if (vp> 1004 ){ A = 1.34713064017409e-22; M = 7.8100555281422 ; }
                                else if (vp>  837 ){ A = 1.03965974081168e-07; M = 2.84204791809926; }
                                else if (vp>  335 ){ A = 1.09301593869823e-04; M = 1.81096361579504; }
                                else if (vp>    0 ){ A = 3.51963178524273e-05; M = 2.00477856801111; }	
                                break;
                        case DragFunctions.G6:
                                if (vp> 3236 ) { A = 0.0455384883480781; M = 1.15997674041274; }
                                else if (vp> 2065 ) { A = 7.167261849653769e-02; M = 1.10704436538885; }
                                else if (vp> 1311 ) { A = 1.66676386084348e-03 ; M = 1.60085100195952; }
                                else if (vp> 1144 ) { A = 1.01482730119215e-07 ; M = 2.9569674731838 ; }
                                else if (vp> 1004 ) { A = 4.31542773103552e-18 ; M = 6.34106317069757; }
                                else if (vp>  670 ) { A = 2.04835650496866e-05 ; M = 2.11688446325998; }
                                else if (vp>    0 ) { A = 7.50912466084823e-05 ; M = 1.92031057847052; }
                                break;
                        case DragFunctions.G7:
                                if (vp> 4200 ) { A = 1.29081656775919e-09; M = 3.24121295355962; }
                                else if (vp> 3000 ) { A = 0.0171422231434847  ; M = 1.27907168025204; }
                                else if (vp> 1470 ) { A = 2.33355948302505e-03; M = 1.52693913274526; }
                                else if (vp> 1260 ) { A = 7.97592111627665e-04; M = 1.67688974440324; }
                                else if (vp> 1110 ) { A = 5.71086414289273e-12; M = 4.3212826264889 ; }
                                else if (vp>  960 ) { A = 3.02865108244904e-17; M = 5.99074203776707; }
                                else if (vp>  670 ) { A = 7.52285155782535e-06; M = 2.1738019851075 ; }
                                else if (vp>  540 ) { A = 1.31766281225189e-05; M = 2.08774690257991; }
                                else if (vp>    0 ) { A = 1.34504843776525e-05; M = 2.08702306738884; }
                                break;
                        case DragFunctions.G8:
                                if (vp> 3571 ) { A = 0.0112263766252305   ; M = 1.33207346655961; }
                                else if (vp> 1841 ) { A = 0.0167252613732636   ; M = 1.28662041261785; }
                                else if (vp> 1120 ) { A = 2.20172456619625e-03; M = 1.55636358091189; }
                                else if (vp> 1088 ) { A = 2.0538037167098e-16 ; M = 5.80410776994789; }
                                else if (vp>  976 ) { A = 5.92182174254121e-12; M = 4.29275576134191; }
                                else if (vp>    0 ) { A = 4.3917343795117e-05 ; M = 1.99978116283334; }
                                break;                                
                        default: break;
                }

                if (A != -1 && M != -1 && vp > 0 && vp < 10000){
                        val = A * Math.pow(vp, M) / DragCoefficient;
                        return val;
                }
                else return -1;
        }
}
