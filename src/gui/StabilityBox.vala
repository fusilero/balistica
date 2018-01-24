/* Copyright 2018 Steven Oliver <oliver.steven@gmail.com>
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

[GtkTemplate (ui = "/org/gnome/balistica/ui/stability.glade")]
public class Balistica.StabilityBox : Gtk.Box {

   // Fields
   [GtkChild]
   private Gtk.Entry diameter ;
   [GtkChild]
   private Gtk.Entry length ;
   [GtkChild]
   private Gtk.Entry mass ;
   [GtkChild]
   private Gtk.Entry safe_value ;
   [GtkChild]
   private Gtk.Entry results ;

   /**
    * Reset the front end to prepare for a new stability calculation
    */
   [GtkCallback]
   public void btnResetStability_clicked() {
	  diameter.set_text ("") ;
	  length.set_text ("") ;
	  mass.set_text ("") ;
	  safe_value.set_text ("") ;

	  results.set_text ("") ;
   }

   /**
    * Solve the stability calculation
    */
   [GtkCallback]
   public void btnCalculateStability_clicked() {
	  LibBalistica.Miller m = new LibBalistica.Miller () ;

	  m.diameter = double.parse (diameter.get_text ()) ;
	  m.length = double.parse (length.get_text ()) ;
	  m.mass = double.parse (mass.get_text ()) ;
	  m.safe_value = int.parse (safe_value.get_text ()) ;

	  results.set_text (m.calc_stability ().to_string ()) ;
   }

}
