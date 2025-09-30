Building
========

Prerequisites:

* CMake version 3.20.2 or newer.

* YAJL 2.0.1 or newer. You need both the library and the header files.
  This is a standard binary package in most any Linux distribution. Note
  that the header files are often in a separate "devel" package. The source
  can be downloaded from https://github.com/lloyd/yajl/releases if you must
  build the library yourself.

* A Fortran compiler that supports the 2018 features used by YAJL-Fort,
  and its companion (or a compatible) C compiler.

Clone the YAJL-Fort source repository with SSH::

  git clone git@github.com:nncarlson/yajl-fort.git

or with HTTPS::

  git clone https://github.com/nncarlson/yajl-fort.git

Set your ``FC`` and ``CC`` environment variables to your Fortran and C
compilers. If YAJL is not in a standard location you will also need to
set your ``YAJL_ROOT`` environment variable to the root directory of the
YAJL installation. Then create a build directory and run ``cmake`` from
the directory::

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

Then compile the library and tests, and run the tests (all should pass)::

  make
  ctest

Then see the documentation for the :ref:`yajl_fort <yajl_fort>` and
:ref:`json <json-module>` modules and the examples therein.
