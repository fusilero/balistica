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


[GtkTemplate (ui = "/org/gnome/balistica/pbr.glade")]
public class Balistica.PbrDialog : Gtk.Dialog {
   [GtkChild]
   public Gtk.Button btnCalculate ;
   [GtkChild]
   public Gtk.Button btnReset ;

   [GtkChild]
   public Gtk.Entry drag_function ;
   [GtkChild]
   public Gtk.Entry drag_coeff ;
   [GtkChild]
   public Gtk.Entry initial_vel ;
   [GtkChild]
   public Gtk.Entry sight_height ;
   [GtkChild]
   public Gtk.Entry vital_zone_sz ;

   [GtkChild]
   public Gtk.TextView results ;

   private LibBalistica.DragFunction d ;

   /**
    * Constructor
    */
   public PbrDialog (double dc, double iv, double sh, int df) {
	  drag_coeff.set_text (dc.to_string ()) ;
	  initial_vel.set_text (iv.to_string ()) ;
	  sight_height.set_text (sh.to_string ()) ;

	  switch( df ){
	  case 1:
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

	  drag_function.set_text (d.to_string ()) ;
   }

   /**
    * Reset the front end to prepare for a new calculation
    */
   [GtkCallback]
   public void btnReset_clicked() {
	  vital_zone_sz.set_text ("") ;
	  results.buffer.text = "" ;
   }

   /**
    * Calculate the PBR results
    */
   [GtkCallback]
   public void btnCalculate_clicked() {
	  double pbr_results[4] = LibBalistica.PBR.pbr (d,
													double.parse (drag_coeff.get_text ()),
													double.parse (initial_vel.get_text ()),
													double.parse (sight_height.get_text ()),
													double.parse (vital_zone_sz.get_text ())) ;

	  results.buffer.text = "Near Zero: " + pbr_results[0].to_string () + " yards\n" ;
	  results.buffer.text += "Far Zero: " + pbr_results[1].to_string () + " yards\n" ;
	  results.buffer.text += "Minimum PBR: " + pbr_results[2].to_string () + " yards\n" ;
	  results.buffer.text += "Maximum PBR: " + pbr_results[3].to_string () + " yards\n\n" ;
	  results.buffer.text += "Sight-in at 100 yards: " + pbr_results[4].to_string () + " inches high" ;
   }

}
