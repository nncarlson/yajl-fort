Building
========

Prerequisites:

* CMake version 3.1 or newer.

* YAJL 2.0.1 or newer. You need both the library and the header files.
  This is a standard binary package in most any Linux distribution. Note
  that the header files are often in a separate "devel" package. The source
  can be downloaded from https://github.com/lloyd/yajl/releases if you must
  build the library yourself.

* A Fortran compiler that supports the 2003/2008 features used by YAJL-Fort,
  and its companion (or a compatible) C compiler.

The YAJL-Fort website is at https://github.com/nncarlson/yajl-fort.

Clone the YAJL-Fort source repository with SSH::

  git clone git@github.com:nncarlson/yajl-fort.git

or with HTTPS::

  git clone https://github.com/nncarlson/yajl-fort.git

Set your ``FC`` and ``CC`` environment variables to your Fortran and C
compilers. Create a build directory and run ``cmake`` from the directory::

  cd yajl-fort
  mkdir build
  cd build
  cmake ..

CMake should find your compilers with the help of the ``FC`` and ``CC``
variables. The default is to configure a ``Release`` build. Some CMake
variables you might want to set on the ``cmake`` command line:

* ``CMAKE_BUILD_TYPE``: to specify a ``Debug`` build type, for example
* ``CMAKE_Fortran_FLAGS``: additional Fortran compiler flags
* ``CMAKE_INSTALL_PREFIX``: where to install the library and module files

Note: installation/packaging might not be fully working at this time.

Then compile the library and tests, and run the tests (all should pass)::

  make
  ctest

Then see the documentation for the :ref:`yajl_fort <yajl_fort>` and
:ref:`json <json-module>` modules and the examples therein.

Compiler status
---------------
The following compilers are known to work:

* NAG 5.3.2, 6.0, 6.1, and 6.2
* Intel 16.0.2, 17.0.6, 18.0.1
* GFortran 6.4.1, 7.2.1, 7.3.1, 8.0.1 (20180311 trunk)

The following compilers are known to **not** work:

* Flang (5.0.1, b356fc9b, 20180316 master) 

The ``CMakeLists.txt`` file has special stanzas for some compilers (Intel,
NAG, GNU) that set specific flags that are known to be needed. If you are
using another compiler it too may need some special flags.  These can be
set on the ``cmake`` command line with ``CMAKE_Fortran_FLAGS`` or a stanza
can be added to the ``CMakeLists.txt`` file.