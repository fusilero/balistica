resources = gnome.compile_resources ('resources', 'balistica.gresource.xml',
                                     source_dir: '.',
                                     c_name: 'resources')

vala_args = [ 
  '--pkg=gio-2.0',
  '--pkg=sqlite3',
  '--thread',
  '--enable-checking',
  ]

libbalistica = shared_library ( 'libbalistica',
  [ 'LibBalistica/Atmosphere.vala',
    'LibBalistica/Greenhill.vala',
    'LibBalistica/Miller.vala',
    'LibBalistica/Retard.vala',
    'LibBalistica/Solve.vala',
    'LibBalistica/Zero.vala',
    'LibBalistica/LibBalistica.vala',
    'LibBalistica/Pbr.vala',
    'LibBalistica/Solution.vala',
    'LibBalistica/Windage.vala',
    'LibBalistica/conversion/Mass.vala',
    'LibBalistica/conversion/Angle.vala',
    'LibBalistica/conversion/Temperature.vala'
  ],
  dependencies: [ glib_dep, gee_dep ],
  c_args: [ '-g' ],
  link_args: ['-lm'],
  install: true
  )

balisitica = executable ('balistica',
  [ 'BalisticaApplication.vala',
    'Calculate.vala',
    'Database.vala',
    'Logging.vala',
    'LogMsg.vala',
    'Main.vala',

    # Calculations
    'gui/PbrDialog.vala',
    'gui/DragBox.vala',
    'gui/TwistBox.vala',
    'gui/StabilityBox.vala',
    'gui/LogViewerDialog.vala',

    # Reloading
    'gui/CaseBox.vala',
    'gui/PowderBox.vala',
    'gui/PrimerBox.vala',
    'gui/ProjectileBox.vala'] + resources,
  dependencies: [ glib_dep, gtk_dep, gee_dep ],
  c_args: [  
    '-g',
    '-DVERSION="@0@"'.format (meson.project_version ()),
    '-DICON_DIR="@0@"'.format (icondir),
  ],
  vala_args: vala_args,
  link_args: ['-lm'],
  link_with: libbalistica,
  install: true
  )
