project ('balistica', ['vala', 'c'],
          version: '1.3',
          license: 'GPLv3+',
          default_options: [
            'warning_level=1',
            'buildtype=debugoptimized',
            ],
          meson_version: '>= 0.37.1'
          ) 

gnome = import ('gnome')
i18n = import ('i18n')

# Paths 
datadir = join_paths (get_option ('prefix'), get_option ('datadir')) 
icondir = join_paths (datadir, 'balistica', 'icons')

glib_dep = dependency ('glib-2.0', version: '>= 2.40', required: true) 
gtk_dep = dependency ('gtk+-3.0', version: '>=3.10.8', required: true)
gee_dep = dependency ('gee-0.8', version: '>=0.20.0', required: true)
sqlite3_dep = dependency ('sqlite3', required: true)
gthread_dep = dependency ('gthread-2.0')

subdir ('data') 
subdir ('help') 
subdir ('src')
subdir ('sql') 
subdir ('test') 
