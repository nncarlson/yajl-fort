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
