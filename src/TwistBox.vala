/* Copyright 2017 Steven Oliver <oliver.steven@gmail.com>
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

[GtkTemplate (ui = "/org/gnome/balistica/twist.glade")]
public class Balistica.TwistBox : Gtk.Box {

   // Fields
   [GtkChild]
   private Gtk.Entry mdiameter ;
   [GtkChild]
   private Gtk.Entry mlength ;
   [GtkChild]
   private Gtk.Entry mmass ;
   [GtkChild]
   private Gtk.Entry msafe_value ;
   [GtkChild]
   private Gtk.Entry gdiameter ;
   [GtkChild]
   private Gtk.Entry glength ;
   [GtkChild]
   private Gtk.Entry gspec_gravity ;
   [GtkChild]
   private Gtk.Entry gc ;
   [GtkChild]
   private Gtk.Entry results ;

   // Buttons
   [GtkChild]
   private Gtk.Button btnReset ;
   [GtkChild]
   private Gtk.Button btnSolve ;

   // Radio buttons for calculation step size
   [GtkChild]
   private Gtk.RadioButton radGreenhill ;
   [GtkChild]
   private Gtk.RadioButton radMiller ;

   public TwistBox () {
	  // Default Twist calculation type
	  radMiller.active = true ;

	  radMiller.toggled.connect (() => {
		 mdiameter.set_sensitive (true) ;
		 mlength.set_sensitive (true) ;
		 mmass.set_sensitive (true) ;
		 msafe_value.set_sensitive (true) ;

		 gdiameter.set_sensitive (false) ;
		 glength.set_sensitive (false) ;
		 gspec_gravity.set_sensitive (false) ;
		 gc.set_sensitive (false) ;
	  }) ;

	  radGreenhill.toggled.connect (() => {
		 mdiameter.set_sensitive (false) ;
		 mlength.set_sensitive (false) ;
		 mmass.set_sensitive (false) ;
		 msafe_value.set_sensitive (false) ;

		 gdiameter.set_sensitive (true) ;
		 glength.set_sensitive (true) ;
		 gspec_gravity.set_sensitive (true) ;
		 gc.set_sensitive (true) ;
	  }) ;
   }

   /**
    * Reset the front end to prepare for a new twist calculation
    */
   [GtkCallback]
   public void btnResetTwist_clicked() {
	  mdiameter.set_text ("") ;
	  mlength.set_text ("") ;
	  mmass.set_text ("") ;
	  msafe_value.set_text ("") ;

	  gdiameter.set_text ("") ;
	  glength.set_text ("") ;
	  gspec_gravity.set_text ("") ;
	  gc.set_text ("") ;

	  results.set_text ("") ;
   }

   /**
    * Solve the twist calculation for the selected formula
    */
   [GtkCallback]
   public void btnCalculateTwist_clicked() {
	  if( radMiller.get_active ()){
		 LibBalistica.Miller m = new LibBalistica.Miller () ;

		 m.diameter = double.parse (mdiameter.get_text ()) ;
		 m.length = double.parse (mlength.get_text ()) ;
		 m.mass = double.parse (mmass.get_text ()) ;
		 m.safe_value = int.parse (msafe_value.get_text ()) ;

		 results.set_text (m.calc_twist ().to_string ()) ;
	  } else {
		 LibBalistica.Greenhill g = new LibBalistica.Greenhill () ;

		 g.diameter = double.parse (gdiameter.get_text ()) ;
		 g.length = double.parse (glength.get_text ()) ;
		 g.specific_gravity = double.parse (gspec_gravity.get_text ()) ;
		 g.C = int.parse (gc.get_text ()) ;

		 results.set_text (g.calc_twist ().to_string ()) ;
	  }
   }
}
