project ('balistica', ['vala', 'c'],
          version: '1.3',
          license: 'GPLv3+',
          default_options: [
            'warning_level=1',
            'buildtype=debugoptimized',
            ],
          meson_version: '>= 0.37.1'
          ) 

# Imports
gnome = import ('gnome')
i18n = import ('i18n')

# Paths 
datadir = join_paths (get_option ('prefix'), get_option ('datadir')) 
icondir = join_paths (datadir, 'balistica', 'icons')
po_dir = join_paths(meson.source_root(), 'po')

# Dependencies
glib_min_version = '2.40.0'

glib_dep = dependency ('glib-2.0', version: '>= ' + glib_min_version)
gio_dep = dependency ('gio-2.0', version: '>= ' + glib_min_version)
gobject_dep = dependency ('gobject-2.0', version: '>= ' + glib_min_version)
gthread_dep = dependency ('gthread-2.0', version: '>= ' + glib_min_version)
gtk_dep = dependency ('gtk+-3.0', version: '>=3.10.8')
gee_dep = dependency ('gee-0.8', version: '>=0.20.0')
sqlite3_dep = dependency ('sqlite3', required: true)

subdir ('data') 
subdir ('help') 
subdir ('src')
subdir ('sql') 
subdir ('test') 
