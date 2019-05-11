YAJL-Fort: A Modern Fortran Interface to YAJL
=============================================
The YAJL-Fort package provides a modern object-oriented Fortran interface to
the [YAJL](http://lloyd.github.com/yajl/) C library, which is an event-driven
parser for JSON data streams. [JSON](http://www.json.org/) is an open standard
data interchange format. It is lightweight, easy for humans to read and write,
and language independent.

Note that unlike most other JSON libraries, YAJL does not provide or impose
an in-memory data structure representation of the JSON data. That is left to
higher-level application code through custom parsing event callback functions.

Also included in YAJL-Fort is a module that defines data structures for
representing arbitrary JSON data, and procedures built on the YAJL interface
for populating the data structures with JSON data read from a file or string.

Documentation for building and using YAJL-Fort is at
[ReadTheDocs](http://yajl-fort.readthedocs.io/)

### Compiler Status

The following compilers are known to work:

* NAG 5.3.2, 6.0, 6.1, and 6.2
* Intel 16.0.2, 17.0.6, 18.0.1
* GFortran 6.4.1, 7.2.1, 7.3.1, 8.1, 8.2
* IBM xlf 15.1.6, 16.1.0 (must use the xlf2008 executable)

The following compilers **appear** to work now. All tests are passing but
the interface has not been extensively exercised in actual applications.

* Flang March 2019 Binary Release (but no earlier)
* PGI 19.4 (but no earlier)

The ``CMakeLists.txt`` file has special stanzas for some compilers that set
compiler flags and preprocessor macros that are known to be needed. If you
are using another compiler it too may need specific compiler flags or macros
defined.  These can be set on the ``cmake`` command line with
``CMAKE_Fortran_FLAGS`` or a stanza can be added to the ``CMakeLists.txt``
file.
