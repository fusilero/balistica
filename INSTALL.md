balística Installation
---

To build and install balística, type the following commands:

```bash
$ mkdir -p build && cd build
$ cmake .. && make
$ make test
$ make install
# or if needed
$ sudo make install
```

PS. You may need to execute "make install" as root (i.e. sudo make install)
  if installing to system directories.
