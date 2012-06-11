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
	opts.load('compiler_c')
	opts.load('vala')
	opts.load('glib2')
        opts.load('libxml2')

def configure(conf):	
	conf.check_vala((0, 14, 2))

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
        
        conf.check_cfg(package = 'libgda-4.0',
                uselib_store = 'GDA',
                mandatory = True,
                args = '--cflags --libs')

        conf.load('compiler_c')        
        conf.load('vala')        
        conf.load('glib2')

def build(bld):
	bld.add_post_fun(post_build)
	
	bld.env.append_value('CFLAGS', ['-O2', '-g'])
	bld.env.append_value('LINKFLAGS', ['-O2', '-g', '-lm'])
	bld.env.append_value('VALAFLAGS', ['-g', '--enable-checking', '--fatal-warnings'])
	
	bld.recurse('src')
	
	# Remove executables in root folder.
	if bld.cmd == 'clean':
		if os.path.isfile('balistica') :
			os.remove('balistica')

def post_build(bld):
	# Copy executables to root folder.
        waflib.Logs.info("Finished.")
