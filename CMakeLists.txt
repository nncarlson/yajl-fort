cmake_minimum_required(VERSION 3.10)

project(YAJL-Fort C Fortran)

set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

find_package(YAJL REQUIRED)
if("${YAJL_VERSION}" VERSION_LESS "2.0.1")
  message(FATAL_ERROR "ERROR! version 2.0.1 or later of the yajl library is required")
endif()

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

# NAG Fortran compiler flags
if(CMAKE_Fortran_COMPILER_ID MATCHES NAG)
  include(NAGFortranCompilerVersion)  # for older NAG versions
  set(CMAKE_Fortran_FLAGS_RELEASE "-O3 -w=uda -DNDEBUG")
  set(CMAKE_Fortran_FLAGS_DEBUG "-g -gline")
endif()

# Intel Fortran compiler flags
if(CMAKE_Fortran_COMPILER_ID MATCHES Intel)
  add_definitions(-DNO_2008_LHS_POLY_REALLOC)
  if(CMAKE_Fortran_COMPILER_VERSION VERSION_LESS "17.0.0")
    set(CMAKE_Fortran_FLAGS "-assume realloc_lhs")
  endif()
  if(CMAKE_Fortran_COMPILER_VERSION VERSION_GREATER "18.0.0")
    add_definitions(-DINTEL_BUG20171115)
  endif()
endif()

# GFortran compiler flags
if(CMAKE_Fortran_COMPILER_ID MATCHES GNU)
  set(CMAKE_Fortran_FLAGS "-ffree-line-length-none")
  add_definitions(-DGNU_PR61767)
  add_definitions(-DNO_2008_LHS_POLY_REALLOC)
endif()

# PGI Fortran compiler flags
if(CMAKE_Fortran_COMPILER_ID MATCHES PGI)
  add_definitions(-DNO_2008_LHS_POLY_REALLOC)
  add_definitions(-DFLANG_ISSUE720)
  add_definitions(-DFLANG_ISSUE721)
endif()

# Flang compiler flags
if(CMAKE_Fortran_COMPILER_ID MATCHES Flang)
  add_definitions(-DNO_2008_LHS_POLY_REALLOC)
  add_definitions(-DFLANG_ISSUE720)
  add_definitions(-DFLANG_ISSUE721)
endif()

# RPATH handling for installed shared libraries and dynamically-linked
# executables.  See http://www.cmake.org/Wiki/CMake_RPATH_handling
set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib")
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

add_subdirectory(src)

option(BUILD_TESTS "Build test programs" ON)
if(BUILD_TESTS)
  enable_testing()
  add_subdirectory(test)
endif()

option(BUILD_HTML "Build HTML documentation (requires Sphinx)" OFF)
if(BUILD_HTML)
  find_package(Sphinx REQUIRED)
  add_subdirectory(doc/sphinx)
endif()
