project ('balistica', ['vala', 'c'],
          version: '1.3',
          license: 'GPLv3+',
          default_options: [
            'warning_level=1',
            'buildtype=debugoptimized',
            ],
          meson_version: '>= 0.37.1'
          )

# Minimum version of Vala
vala_version_required = '0.38.0'
vala = meson.get_compiler('vala')
if not vala.version().version_compare('>= @0@'.format(vala_version_required))
	error('valac >= @0@ required!'.format(vala_version_required))
endif

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
libbalistica_dep = dependency ('libbalistica', version: '>=1.0', required: true)
sqlite3_dep = dependency ('sqlite3', version: '3.19.3', required: true)

subdir ('data')
subdir ('help')
subdir ('po')
subdir ('src')
subdir ('sql')
