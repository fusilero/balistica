#! /usr/bin/env python
# encoding: utf-8

# Copyright 2012 Steven Oliver <oliver.steven@gmail.com>
#
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without any warranty.

import os
import waflib

top = '.'
out = 'build'

VERSION = '0.0.1'
APPNAME = 'balistica'

def options(opts):
	opts.load('compiler_c vala glib2')
        opts.load('libxml2')
        
        opts.add_option(
        	'--debug',
        	help='performs a debug build',
        	action='store_true',
        	default=False)

def configure(conf):	
	conf.check_vala((0, 14, 2))
	conf.env.DEBUG = conf.options.debug

	conf.check_cfg(
		package = 'glib-2.0',
		uselib_store = 'GLIB',
		atleast_version = '2.30.0',
		mandatory = True,
		args = '--cflags --libs')
	
        conf.check_cfg(
                package = 'libxml-2.0',
                uselib_store = 'LIBXML',
                atleast_version = '2.0',
                mandatory = True,
                args = '--cflags --libs')
        
        conf.check_cfg(package = 'libgda-5.0',
                uselib_store = 'GDA',
                mandatory = True,
                args = '--cflags --libs')

        conf.load('compiler_c vala glib2')

def build(bld):
	bld.add_post_fun(post_build)
	
	if bld.env.DEBUG:
		bld.env.append_value('CFLAGS', ['-O0', '-g', '-D_PREFIX="' + bld.env.PREFIX + '"'])
		bld.env.append_value('LINKFLAGS', ['-O0', '-g', '-lm'])
		bld.env.append_value('VALAFLAGS', ['-g', '--enable-checking', '--fatal-warnings'])
	else:
		bld.env.append_value('CFLAGS', ['-O2', '-g', '-D_PREFIX="' + bld.env.PREFIX + '"'])
		bld.env.append_value('LINKFLAGS', ['-O2', '-g', '-lm'])
		bld.env.append_value('VALAFLAGS', ['-g', '--enable-checking', '--fatal-warnings'])
	
	bld.recurse('src')
	
	# Remove executables in root folder.
	if bld.cmd == 'clean':
		if os.path.isfile('balistica') :
			os.remove('balistica')
	# Install balistica
	elif bld.cmd == 'install'
		bld.install_files('${MANDIR}/balistica.1', m, flat=True)

def post_build(bld):
	# Copy executables to root folder.
        waflib.Logs.info("Finished.")
        
def dist():
	# bzip2 (default) the executable
	import sha1
	from Scripting import dist
	(f, filename) = dist(APPNAME, VERSION)
	f = file(filename, 'rb')    
	
	# compute the SHA1 hash 0.5MB at a time
	s = sha1.sha1()
	readBytes = 500000
	while (readBytes):
		readString = f.read(readBytes)
		s.update(readString)
		readBytes = len(readString)
	f.close()
	
	# Write the hash to a seperate file
	f = open(dist(APPNAME), 'w')
	f.write(s.hexdigest())
	f.close()
	
	# Quit
	sys.exit(0)
    