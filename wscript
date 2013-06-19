#! /usr/bin/env python
# encoding: utf-8

import os
import waflib

top = '.'
out = 'build'

VERSION = '0.0.1'
APPNAME = 'balistica'
WEBSITE = 'http://steveno.github.com/balistica/'
COPYRIGHT = "Copyright \xc2\xa9 2012 Steven N. Oliver"
VERSION_MAJOR = '.'.join (VERSION.split ('.')[0:1])

def options(opts):
	opts.load('compiler_c vala glib2')

        opts.add_option(
        	'--debug',
        	help='performs a debug build',
        	action='store_true',
        	dest='debug',
        	default=False)

def configure(conf):	
	conf.check_vala((0, 20, 0))
	conf.env.DEBUG = conf.options.debug

	conf.check_cfg(
		package = 'glib-2.0',
		uselib_store = 'GLIB',
		atleast_version = '2.30.0',
		mandatory = True,
		args = '--cflags --libs')

	conf.define ('NAME', APPNAME)	
	conf.define ('VERSION', VERSION)
	conf.define ('GETTEXT_PACKAGE', APPNAME)
	conf.define ('COPYRIGHT', COPYRIGHT)
	conf.define ('WEBSITE', WEBSITE)	
	conf.define ('VAPI_VERSION', VERSION_MAJOR)

	conf.load('compiler_c vala glib2')

def build(bld):
	bld.add_post_fun(post_build)

	if bld.env.DEBUG:
		bld.env.append_value('CFLAGS', ['-O0', '-g', '-D_PREFIX="' + bld.env.PREFIX + '"'])
		bld.env.append_value('LINKFLAGS', ['-O0', '-g', '-lm'])
		bld.env.append_value('VALAFLAGS', ['-g', '--enable-checking', '--fatal-warnings', '--debug'])
	else:
		bld.env.append_value('CFLAGS', ['-O2', '-g', '-D_PREFIX="' + bld.env.PREFIX + '"'])
		bld.env.append_value('LINKFLAGS', ['-O2', '-g', '-lm'])
		bld.env.append_value('VALAFLAGS', ['-g', '--enable-checking', '--fatal-warnings'])

	bld.recurse('src')

	# Remove executables in root folder.
	if bld.cmd == 'clean':
		if os.path.isfile('balistica') :
			os.remove('balistica')
	# Install balistica manpage
        elif bld.cmd == 'install':
		bld.install_files('${MANDIR}/balistica.1', m, flat=True)

def dist ():	
	import Scripting
	Scripting.dist (APPNAME, VERSION)

def post_build(bld):
	# Copy executables to root folder.
        waflib.Logs.info("Finished.")
