# balística

[![Coverage Status](https://img.shields.io/coveralls/steveno/balistica.svg)](https://coveralls.io/r/steveno/balistica)
[![Stories in Ready](https://badge.waffle.io/steveno/balistica.png?label=ready)](https://waffle.io/steveno/balistica)

## About
balística is a simple open source external ballistics calculator. It's 
named after the Catalan word for "ballistics" in English. Enjoy!

## Current Status
While the GUI is still a work in progress, the back end currently exists
to make several different computations. Here's a task list of what I feel
are major outstanding issues:
- [x] Miller Twist Rule
- [x] Miller Stability Rule
- [x] Greenhill Twist
- [x] Standard Drag Functions G1-G8
- [x] Drag Functions Ingalls and British
- [x] The PBR function (Point Blank Range)
- [X] GUI for Miller Twist
- [X] GUI for Greenhill Twist
- [ ] GUI for Miller Stability
- [ ] An icon (!)
- [ ] A database backend to store hand loads
- [ ] GUI for said DB of hand loads

## Minimum Requirements
* vala >= 0.28.0 
* glib-2.0 >= 2.46.0
* gtk+-3.0 >= 3.18.0
* gee-0.8 >= 0.18.0
* cmake 

### Fedora
```bash
sudo dnf install gtk3-devel glib-devel libgee-devel vala cmake vala-compat-tools
```

### Ubuntu
```bash
sudo apt-get install libgtk-3-dev vala cmake
```

## Build Instructions
```bash
cd balistica
mkdir build && cd build
cmake ..
make
make install
```

## Contributing
[![Gitter chat](https://badges.gitter.im/steveno/balistica.png)](https://gitter.im/steveno/balistica)
Please see [the contributing file](https://github.com/steveno/balistica/blob/master/CONTRIBUTING.md)

## DISCLAIMER
It is to be used as REFERENCE or curiosity ONLY. Much like
Wikipedia, information gleaned from this program is not to be 
used in an illegal fashion and I take no responsibility whatsoever
for any acts, criminal or otherwise, committed using any calculations 
derived by this program. This is also stated in the GNU GPL, 
but repeated here just to make sure.
