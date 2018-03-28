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

# Test for how strict the compiler can be
cc = meson.get_compiler('c')

global_c_args = []
test_c_args = [
  '-Wcast-align',
  '-Wdeclaration-after-statement',
  '-Wformat-nonliteral',
  '-Wformat-security',
  '-Wmissing-include-dirs',
  '-Wnested-externs',
  '-Wno-missing-field-initializers',
  '-Wno-sign-compare',
  '-Wno-unused-parameter',
  '-Wpointer-arith',
  '-Wredundant-decls',
  '-Wswitch-default',
  '-Wswitch-enum',
  '-Wuninitialized',
  ['-Werror=format-security', '-Werror=format=2' ],
  '-Werror=empty-body',
  '-Werror=implicit-function-declaration',
  '-Werror=incompatible-pointer-types',
  '-Werror=pointer-arith',
  '-Werror=init-self',
  '-Werror=int-conversion',
  '-Werror=misleading-indentation',
  '-Werror=missing-include-dirs',
  '-Werror=overflow',
  '-Werror=parenthesis',
  '-Werror=return-type',
  '-Werror=shadow',
  '-Werror=strict-prototypes',
  '-Werror=undef',
]
if get_option('buildtype') != 'plain'
  test_c_args += '-fstack-protector-strong'
endif

foreach arg: test_c_args
  if cc.has_multi_arguments(arg)
    global_c_args += arg
  endif
endforeach

# Imports
gnome = import ('gnome')
i18n = import ('i18n')

# Add our config VAPI
add_project_arguments(
  [
    '--vapidir', join_paths(meson.source_root(), 'src'),
    '--pkg', 'config',
  ],
  language: 'vala'
)

add_project_arguments(global_c_args, language: 'c')

# Paths
config_h_dir = include_directories('.')
locale_dir = join_paths(get_option('prefix'), get_option('localedir'))
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

# Configuration
conf = configuration_data()
conf.set_quoted('GETTEXT_PACKAGE', meson.project_name())
conf.set_quoted('LOCALE_DIR', locale_dir)
conf.set_quoted('NAME', 'balística')
conf.set_quoted('VERSION', meson.project_version())
configure_file(output: 'config.h', configuration: conf)

# Post-install scripts
meson.add_install_script('meson_post_install.py')

# Subfolders
subdir ('data')
subdir ('help')
subdir ('po')
subdir ('src')
