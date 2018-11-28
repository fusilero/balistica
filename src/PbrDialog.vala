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


[GtkTemplate (ui = "/org/gnome/balistica/ui/pbr.glade")]
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

   private Logging logger ;
   private LibBalistica.DragFunction d ;

   /**
    * Constructor
    */
   public PbrDialog (double dc, double iv, double sh, int df) {
	  Object (use_header_bar: 1) ;

	  this.logger = Logging.get_default () ;
	  this.drag_coeff.set_text (dc.to_string ()) ;
	  this.initial_vel.set_text (iv.to_string ()) ;
	  this.sight_height.set_text (sh.to_string ()) ;

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

	  this.drag_function.set_text (d.to_string ()) ;
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
	  string v = vital_zone_sz.get_text () ;
	  if( v == "" ){
		 logger.publish (new LogMsg (_("Vital Zone size is required to calculate PBR"))) ;
		 return ;
	  }

	  LibBalistica.PbrResult pbr_result = LibBalistica.PBR.pbr (d,
																double.parse (drag_coeff.get_text ()),
																double.parse (initial_vel.get_text ()),
																double.parse (sight_height.get_text ()),
																double.parse (v)) ;

	  results.buffer.text = _("Near Zero: %.2f yards\n").printf (pbr_result.near_zero) ;
	  results.buffer.text += _("Far Zero: %.2f yards\n").printf (pbr_result.far_zero) ;
	  results.buffer.text += _("Minimum PBR: %.2f yards\n").printf (pbr_result.min_pbr) ;
	  results.buffer.text += _("Maximum PBR: %.2f yards\n\n").printf (pbr_result.max_pbr) ;
	  results.buffer.text += _("Sight-in at 100 yards: %.2f\" high").printf (pbr_result.sight_in_height) ;
   }

}
