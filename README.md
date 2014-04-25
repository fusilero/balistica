# balística

[![Build Status](https://travis-ci.org/steveno/balistica.png?branch=master)](https://travis-ci.org/steveno/balistica)
[![Coverage Status](https://coveralls.io/repos/steveno/balistica/badge.png)](https://coveralls.io/r/steveno/balistica)
[![Stories in Ready](https://badge.waffle.io/steveno/balistica.png?label=ready)](https://waffle.io/steveno/balistica)

## About
balística is a simple open source external ballistics calculator. It's 
named after the Catalan word for "ballistics" in English. Enjoy!

## Current Status
While the GUI is still a work in progress, the back end currently 
exists to compute the following:

✓ Miller Twist Rule  
✓ Miller Stability Rule  
✓ Greenhill Twist  
✓ Standard Drag Functions G1-G8  
✓ Drag Functions Ingalls and British  
✓ The PBR function (Point Blank Range)

With the exception of the GUI for the cacluation of the Standard
Drag Functions (still a WIP), several items are still very much outstanding: 
* An icon (!)
* GUI for Miller Twist
* GUI for Miller Stability
* GUI for Greenhill Twist
* A database backend to store hand loads
* GUI for said DB of hand loads

## Minimum Requirements
* vala >= 0.20.1 
* glib-2.0 >= 2.32.0
* gtk+-3.0 >= 3.4.2
* gee-0.8 >= 0.8.5
* cmake 

## Build Instructions
```bash
cd balistica
mkdir build && cd build
cmake ..
make
make install
```
## Contributing
Please see CONTRIBUTING.md

## DISCLAIMER
It is to be used as REFERENCE or curiosity ONLY. Much like
Wikipedia, information gleaned from this program is not to be 
used in an illegal fashion and I take no responsibility whatsoever
for any acts, criminal or otherwise, committed using any calculations 
derived by this program. This is also stated in the GNU GPL, 
but repeated here just to make sure.
