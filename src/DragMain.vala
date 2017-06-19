[GtkTemplate (ui = "/org/gnome/balistica/drag.glade")]
public class Balistica.DragMain : Gtk.Box {
  [GtkChild] public Gtk.Entry txtName;
  [GtkChild] public Gtk.Entry txtDrag_coefficient;
  [GtkChild] public Gtk.Entry txtProjectile_weight;
  [GtkChild] public Gtk.Entry txtIntial_velocity;
  [GtkChild] public Gtk.Entry txtZero_range;
  [GtkChild] public Gtk.Entry txtSight_height;
  [GtkChild] public Gtk.Entry txtShooting_angle;
  [GtkChild] public Gtk.Entry txtWind_velocity;
  [GtkChild] public Gtk.Entry txtWind_angle;

  [GtkChild] public Gtk.Entry txtAltitude;
  [GtkChild] public Gtk.Entry txtTemp;
  [GtkChild] public Gtk.Entry txtBarPress;
  [GtkChild] public Gtk.Entry txtRelaHumid;

  [GtkChild] public Gtk.CheckButton ckbAtmosCorr;

  [GtkCallback]
  void atmo_toggled(Gtk.ToggleButton button) {
    var enable = button.active;
    txtAltitude.set_sensitive (enable) ;
    txtTemp.set_sensitive (enable) ;
    txtBarPress.set_sensitive (enable) ;
    txtRelaHumid.set_sensitive (enable) ;
  }
}
