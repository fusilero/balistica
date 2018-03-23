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


[GtkTemplate (ui = "/org/gnome/balistica/ui/preferences.glade")]
public class Balistica.PreferencesWindow : Gtk.Window {
   [GtkChild]
   public Gtk.Button btnChangeSaveDir ;
   [GtkChild]
   public Gtk.Entry txtSaveDir ;

   private Settings settings ;
   private Logging logger ;

   /**
    * Constructor
    */
   public PreferencesWindow (Settings settings) {
	  this.logger = Logging.get_default () ;
	  this.settings = settings ;
	  this.set_default_size (500, 125) ;
	  this.border_width = 8 ;

	  // Set the placeholder text for the save directory
	  this.txtSaveDir.placeholder_text = Environment.get_home_dir () ;

	  // If a non-empty save directory is set, populate that
	  string current_save_dir = this.settings.get_string ("save-directory") ;
	  if( current_save_dir != "" ){
		 this.txtSaveDir.set_text (current_save_dir) ;
	  }

	  // Reset the saved save directory when cleared
	  this.txtSaveDir.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "edit-clear") ;
	  this.txtSaveDir.icon_press.connect ((pos, event) => {
		 if( pos == Gtk.EntryIconPosition.SECONDARY ){
			this.txtSaveDir.set_text ("") ;
			this.settings.set_string ("save-directory", "") ;
		 }
	  }) ;

	  // Set the focus on the button so that the default
	  // entry will appear if not set in the stored settings
	  this.btnChangeSaveDir.can_focus = true ;
	  this.btnChangeSaveDir.grab_focus () ;
   }

   /**
    *
    */
   [GtkCallback]
   public void btnChangeSaveDir_clicked() {
	  var file_chooser = new Gtk.FileChooserDialog ("Choose save location", this,
													Gtk.FileChooserAction.OPEN,
													"_Cancel", Gtk.ResponseType.CANCEL,
													"_Select", Gtk.ResponseType.ACCEPT) ;
	  file_chooser.set_action (Gtk.FileChooserAction.SELECT_FOLDER) ;
	  if( file_chooser.run () == Gtk.ResponseType.ACCEPT ){
		 txtSaveDir.set_text (file_chooser.get_current_folder ()) ;
		 this.settings.set_string ("save-directory", file_chooser.get_current_folder ()) ;
	  }
	  file_chooser.destroy () ;
   }

}
