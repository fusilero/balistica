#!/usr/bin/env python3

from os import environ, path
from subprocess import call

prefix = environ.get('MESON_INSTALL_PREFIX', '/usr/local')
datadir = path.join(prefix, 'share')
destdir = environ.get('DESTDIR', '')

if not destdir:
    print('Updating icon cache...')
    call(['gtk-update-icon-cache', '-tf', path.join(datadir, 'icons', 'hicolor')])

    print('Updating desktop database...')
    call(['update-desktop-database', path.join(datadir, 'applications')])
