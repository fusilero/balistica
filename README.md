# balística
[![Build Status](https://travis-ci.org/steveno/balistica.svg?branch=master)](https://travis-ci.org/steveno/balistica)
[![Stories in Ready](https://badge.waffle.io/steveno/balistica.png?label=ready)](https://waffle.io/steveno/balistica)

## About
balística is a simple open source external ballistics calculator. It's 
named after the Catalan word for "ballistics" in English. Enjoy!

## Minimum Requirements
* vala >= 0.28.0
* glib-2.0 >= 2.40.0
* gtk+-3.0 >= 3.10.8
* gee-0.8 >= 0.16.1
* cmake 

### Fedora
```bash
sudo dnf install gtk3-devel glib-devel libgee-devel vala cmake
```
Optionally, if you'd like to generate the valadoc documentation
```bash
sudo dnf install graphviz-devel
git clone git://git.gnome.org/valadoc
cd valadoc && ./autogen.sh && make 
sudo make install
```

### Ubuntu
```bash
sudo apt-get install libgtk-3-dev vala valadoc cmake
```

## Build Instructions
```bash
cd balistica
mkdir -p build && cd build
./../configure
make && make test
sudo make install
```

## Contributing
[![Gitter chat](https://badges.gitter.im/steveno/balistica.png)](https://gitter.im/steveno/balistica)

Please see [the contributing file](https://github.com/steveno/balistica/blob/master/CONTRIBUTING.md)

## DISCLAIMER
This program is to be used as REFERENCE or curiosity ONLY. Much like
Wikipedia, information gleaned from this program is not to be 
used in an illegal fashion and I take no responsibility whatsoever
for any acts, criminal or otherwise, committed using any calculations 
derived by this program.
