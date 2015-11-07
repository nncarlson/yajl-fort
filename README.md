YAJL-Fort: A Fortran Interface to YAJL
======================================
The YAJL-Fort package provides a modern object-oriented Fortran interface to
the [YAJL](http://lloyd.github.com/yajl/) C library, which is an event-driven
(SAX-style) parser for JSON data streams.  [JSON](http://www.json.org/) is an
open standard data interchange format.  It is lightweight, easy for humans to
read and write, and language independent.

Note that YAJL, and therefore YAJL-Fort, does not concern itself with any
in-memory data representation of the JSON document like most other JSON parsers.
That is left to higher-level application code through customized parsing
event callbacks.  An example of this can be found in the Parameter List
component of the [Petaca](https://github.com/nncarlson/petaca) package on
GitHub.

Source Code
-----------
YAJL-Fort is made available under the MIT license and can be obtained from
the project GitHub repository https://github.com/nncarlson/yajl-fort

Documentation
-------------
The `doc/yajl_fort.pdf` document is the reference for the Fortran interface
implemented by the `yajl_fort` module.  The example program
`examples/yajl_fort_parse_example.F90` provides an example of how to use
YAJL-Fort, however it is so trivial (the program merely echoes the JSON input)
that it is perhaps inadequate.  A real use example can be found in the
[Petaca package](https://github.com/nncarlson/petaca) in the source file
[parameter_list_json.F90](https://github.com/nncarlson/petaca/blob/master/src/parameter_list_json.F90)

Compiling
---------
The code is written in modern Fortran (2003 plus minor 2008 features)
and requires a compiler that has a reasonably complete implementation of the
standard, which many do not.  At this time the following compilers are known
to work:
* NAG versions >= 5.3
* Intel versions >= 13.0.1 <sup>\*</sup>

The following compilers *may* work:
* GFortran versions 4.9.2, 5.2 <sup>\*\*</sup>

The following compilers are known to *not work*:
* Intel versions < 13.0
* GFortran versions <= 4.8.1

Reports of working/non-working compilers are appreciated.

Version 2.0.1 or later of the yajl library is required.  Source releases
for the library can be found at https://github.com/lloyd/yajl/releases.
Note that this library is a standard package in all of the major Linux
distributions.

The source consists of a single file `yajl_fort.F90` which implements the
interface, a small C file `yajl_ext.c`, plus two small files (`f90_assert.F90`
and `f90_assert.fpp`) that implement a simple design-by-contract (DBC) system.
These files can be can be easily incorporated directly into a software project.
The DBC can be trivially disabled or easily stripped from the code, if desired,
leaving just two files.

Alternatively, the code can be compiled into a library using the CMake-based
build system described next.

#### Building the library with CMake
Cmake (>=2.8) is used to build the library and examples. To ensure it uses the
Fortran compiler you intend, set your environment variable `FC` to the path to
the compiler.  Use the `-DENABLE_EXAMPLES:BOOL=ON` cmake option to build the
example program (default is `OFF`).  Use the standard CMake variables
`CMAKE_INSTALL_PREFIX` and `CMAKE_BUILD_TYPE` to define the installation
directory (default `/usr/local`) and build type (default `RELEASE`).  The
`libyajl-fort.a` library will be installed in the `lib` subdirectory of the
installation directory, and the corresponding `.mod` file will be installed
in the `include` subdirectory.  The example programs are not installed.

CMake will automatically find the YAJL header files and library if they are
installed in a standard location.  Otherwise use the `YAJL_LIBRARY_DIR` and `YAJL_INCLUDE_DIR` CMake variables to give the (full) path to the directories
containing the library and header files (which are stored in the "yajl"
subdirectory of the directory.)

So, for example, starting in the top-level directory:
```
mkdir build
cd build
cmake -DENABLE_EXAMPLES:BOOL=ON -DCMAKE_INSTALL_PREFIX=/opt ..
make
make install
```



---
<sup>\*</sup> The Intel 13.0.1 compiler has a bug in the way stream input is handled
when an EOF is encountered (issue number DPD200237439).  This was fixed in
version 13.1.0.  The example includes a workaround for the bug, however
most any application using yajl-fort will also need to work around it.

<sup>\*\*</sup> Despite claiming support for deferred-length allocatable
character variables, there are some serious bugs in their implementation
in all GFortran versions since 4.8 including the current 6.0 development
trunk (as of 11/6/15).  The trivial example program appears to work, but use
of YAJL-Fort in more complex applications has not been tested.
