// Gravity in imperial measurements
public const double Gravity = -32.194;

// Standard Atmospheric Pressure in inches mercury
const double StandardPressure = 29.5333727;

// Standard Tempurature in degrees Fahrenheit
const double StandardTemp = 59.0;

// FIXME A constant to prevent buffer overflows when this
// C program
public const double BCompMaxRange = 50001;

public enum DragFunctions {
        G1 = 1,
        G2,
        G3,
        G4,
        G5,
        G6,
        G7,
        G8;
        /* We comment this out because at this point I'm not using it and
           my compilation settings will cry foul if it find unused functions 
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
        }*/

}
