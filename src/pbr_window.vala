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

using Gtk;

namespace Balistica {
	public class PbrWindow : GLib.Object {
		private Gtk.Dialog dialog;
		public signal void destroy();
		
		public PbrWindow( Gtk.Window parent) {
			Gtk.Builder pbr_builder ;
			try {
				pbr_builder = Balistica.create_builder ("pbr.glade") ;
				pbr_builder.connect_signals (null) ;
				var pbr_content = pbr_builder.get_object ("pbr_main") as Gtk.Box ;
			} catch (GLib.Error e) {

			}

			dialog = pbr_builder.get_object("pbr_dialog") as Gtk.Dialog;
			dialog.set_transient_for(parent);
		}		

		public void show_all() {
			dialog.show_all();
			dialog.response.connect( () => {
					dialog.destroy();
					destroy();
					});
		}

		public void present() {
			dialog.present();
		}
	}
}
