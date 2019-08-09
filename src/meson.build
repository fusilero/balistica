resource_files = files('balistica.gresource.xml')
resources = gnome.compile_resources ('resources', 'balistica.gresource.xml',
                                     source_dir: '.',
                                     c_name: 'resources')

vala_args = [ 
  '--target-glib', glib_min_version,
  '--thread',
  '--enable-checking',
  '--gresources', resource_files
]

c_args = [  
  '-g',
  '-include', 'config.h',
  '-DVERSION="@0@"'.format (meson.project_version ()),
  '-DICON_DIR="@0@"'.format (icondir),
]

balisitica = executable (meson.project_name(),
  [ 'BalisticaApplication.vala',
    'Calculate.vala',
    'Logging.vala',
    'LogMsg.vala',

    # UI
    'DragBox.vala',
    'LogViewerDialog.vala',
    'PbrDialog.vala',
    'TwistBox.vala',
    'StabilityBox.vala',
    ] + resources,
  include_directories: config_h_dir,
  dependencies: [ glib_dep, gtk_dep, gio_dep, gee_dep, libbalistica_dep ],
  c_args: c_args,
  vala_args: vala_args,
  link_args: ['-lm'],
  install: true
)
